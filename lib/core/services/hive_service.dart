import '../../hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveService {
  bool _isInitialized = false;
  final Map<String, Box> _openBoxes = {};

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await Hive.initFlutter();
      Hive.registerAdapters();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  Future<Box<T>> _getBox<T>(String boxName) async {
    await init();
    if (_openBoxes.containsKey(boxName) && _openBoxes[boxName]!.isOpen) {
      return _openBoxes[boxName]! as Box<T>;
    }
    try {
      final box = await Hive.openBox<T>(boxName);
      _openBoxes[boxName] = box;
      return box;
    } catch (e) {
      throw Exception('Failed to open box $boxName: $e');
    }
  }

  Future<void> add<T>(String boxName, String key, T value) async {
    final box = await _getBox<T>(boxName);
    try {
      await box.put(key, value);
    } catch (e) {
      throw Exception('Failed to add to $boxName: $e');
    }
  }

  Future<void> remove<T>(String boxName, String key) async {
    final box = await _getBox<T>(boxName);
    try {
      await box.delete(key);
    } catch (e) {
      throw Exception('Failed to remove from $boxName: $e');
    }
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await _getBox<T>(boxName);
    try {
      return box.get(key);
    } catch (e) {
      throw Exception('Failed to get from $boxName: $e');
    }
  }

  Future<List<T>> getAll<T>(String boxName) async {
    final box = await _getBox<T>(boxName);
    try {
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to get all from $boxName: $e');
    }
  }

  Future<void> closeBox(String boxName) async {
    try {
      final box = Hive.box(boxName);
      await box.close();
    } catch (e) {
      throw Exception('Failed to close box $boxName: $e');
    }
  }

    Future<void> clearBox(String boxName) async {
    try {
      final box = Hive.box(boxName);
      await box.clear();
    } catch (e) {
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
