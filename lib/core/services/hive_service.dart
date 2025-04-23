import 'dart:developer';

import 'package:book_listing_app/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../features/home/domain/entities/results_entity.dart';

class HiveService {
  bool _isInitialized = false;
  final Map<String, Box> _openBoxes = {};

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await Hive.initFlutter();
      registerAdapters();
      _isInitialized = true;
    } catch (e) {
      log('Failed to initialize Hive: $e');
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  Future<Box> _getBox(String boxName) async {
    await init();
    if (_openBoxes.containsKey(boxName) && _openBoxes[boxName]!.isOpen) {
      return _openBoxes[boxName]!;
    }
    try {
      final box = await Hive.openBox(boxName);
      _openBoxes[boxName] = box;
      return box;
    } catch (e) {
      log('Failed to open box $boxName: $e');
      throw Exception('Failed to open box $boxName: $e');
    }
  }

  Future<void> add<T>(String boxName, String key, T value) async {
    final box = await _getBox(boxName);
    try {
      await box.put(key, value);
    } catch (e) {
      log('Failed to add to $boxName: $e');
      throw Exception('Failed to add to $boxName: $e');
    }
  }

  Future<void> remove(String boxName, String key) async {
    final box = await _getBox(boxName);
    try {
      await box.delete(key);
    } catch (e) {
      log('Failed to remove from $boxName: $e');
      throw Exception('Failed to remove from $boxName: $e');
    }
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await _getBox(boxName);
    try {
      final dynamic value = box.get(key);

      if (value == null) {
        return null;
      }

      if (value is T) {
        return value;
      }

      if ((T == List<ResultsEntity>) && value is List) {
        return value.map((item) => item as ResultsEntity).toList() as T?;
      }

      if (T.toString().startsWith('List<') && value is List) {
        return value as T?;
      }

      return value as T?;
    } catch (e) {
      log('Failed to get from $boxName: $e');
      throw Exception('Failed to get from $boxName: $e');
    }
  }

  Future<List<dynamic>> getAll(String boxName) async {
    final box = await _getBox(boxName);
    try {
      return box.values.toList();
    } catch (e) {
      log('Failed to get all from $boxName: $e');
      throw Exception('Failed to get all from $boxName: $e');
    }
  }

  Future<void> closeBox(String boxName) async {
    try {
      final box = Hive.box(boxName);
      await box.close();
    } catch (e) {
      log('Failed to close box $boxName: $e');
      throw Exception('Failed to close box $boxName: $e');
    }
  }

  Future<void> clearBox(String boxName) async {
    try {
      final box = Hive.box(boxName);
      await box.clear();
    } catch (e) {
      log('Failed to clear box $boxName: $e');
      throw Exception('Failed to close box $boxName: $e');
    }
  }

  Future<void> closeAllBoxes() async {
    for (var box in _openBoxes.values) {
      if (box.isOpen) {
        await box.close();
      }
    }
    _openBoxes.clear();
  }
}
