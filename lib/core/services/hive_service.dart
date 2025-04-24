import 'dart:developer' as developer;

import 'package:book_listing_app/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../features/home/domain/entities/results_entity.dart';
import '../error/exceptions.dart';

/// storage, retrieval, and box management operations.
class HiveService {
  /// Tracks whether Hive has been initialized
  bool _isInitialized = false;

  /// Cache of open boxes to avoid repeatedly opening the same box
  final Map<String, Box> _openBoxes = {};

  /// Singleton instance
  static final HiveService _instance = HiveService._internal();

  /// Factory constructor to return the singleton instance
  factory HiveService() => _instance;

  /// Private constructor
  HiveService._internal();

  /// Initializes Hive and registers all adapters.
  ///
  /// This must be called before any other Hive operations.
  /// Throws an exception if initialization fails.
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();
      registerAdapters();
      _isInitialized = true;
      developer.log('Hive initialized successfully');
    } catch (e) {
      developer.log('Failed to initialize Hive', error: e);
      throw StorageException('Failed to initialize Hive: $e');
    }
  }

  /// Returns a [Box] instance.
  /// Throws [StorageException] if the box cannot be opened.
  Future<Box> _getBox(String boxName) async {
    await init();

    // Return cached box if available
    if (_openBoxes.containsKey(boxName) && _openBoxes[boxName]!.isOpen) {
      return _openBoxes[boxName]!;
    }

    try {
      final box = await Hive.openBox(boxName);
      _openBoxes[boxName] = box;
      return box;
    } catch (e) {
      // Try to recover from corrupted box
      if (e.toString().contains('corrupted') ||
          e.toString().contains('InvalidFormat')) {
        developer.log('Attempting to recover from corrupted box: $boxName');

        try {
          await Hive.deleteBoxFromDisk(boxName);
          final box = await Hive.openBox(boxName);
          _openBoxes[boxName] = box;
          developer.log('Successfully recovered corrupted box: $boxName');
          return box;
        } catch (recoveryError) {
          developer.log('Failed to recover corrupted box: $boxName',
              error: recoveryError);
          throw StorageException(
              'Failed to recover corrupted box $boxName: $recoveryError');
        }
      }

      developer.log('Failed to open box: $boxName', error: e);
      throw StorageException('Failed to open box $boxName: $e');
    }
  }

  /// Throws [StorageException] if the operation fails.
  Future<void> add<T>(String boxName, String key, T value) async {
    final box = await _getBox(boxName);

    try {
      await box.put(key, value);
    } catch (e) {
      developer.log('Failed to add to box: $boxName, key: $key', error: e);
      throw StorageException('Failed to add to $boxName: $e');
    }
  }

  /// Throws [StorageException] if the operation fails.
  Future<void> addMultiple<T>(String boxName, Map<String, T> entries) async {
    final box = await _getBox(boxName);

    try {
      await box.putAll(entries);
    } catch (e) {
      developer.log('Failed to add multiple entries to box: $boxName',
          error: e);
      throw StorageException('Failed to add multiple entries to $boxName: $e');
    }
  }

  /// Removes a value from the specified box.
  ///
  /// [boxName] The name of the box.
  /// [key] The key of the value to remove.
  ///
  /// Throws [StorageException] if the operation fails.
  Future<void> remove(String boxName, String key) async {
    final box = await _getBox(boxName);

    try {
      await box.delete(key);
    } catch (e) {
      developer.log('Failed to remove from box: $boxName, key: $key', error: e);
      throw StorageException('Failed to remove from $boxName: $e');
    }
  }

  /// Removes multiple values from the specified box in a single operation.
  ///
  /// [boxName] The name of the box.
  /// [keys] List of keys to remove.
  ///
  /// Throws [StorageException] if the operation fails.
  Future<void> removeMultiple(String boxName, List<String> keys) async {
    final box = await _getBox(boxName);

    try {
      await box.deleteAll(keys);
    } catch (e) {
      developer.log('Failed to remove multiple keys from box: $boxName',
          error: e);
      throw StorageException(
          'Failed to remove multiple keys from $boxName: $e');
    }
  }

  /// Retrieves a value from the specified box.
  ///
  /// [boxName] The name of the box.
  /// [key] The key of the value to retrieve.
  /// [defaultValue] Optional value to return if the key doesn't exist.
  ///
  /// Returns the value associated with the key, or defaultValue if the key doesn't exist.
  /// Throws [StorageException] if the operation fails.
  Future<T?> get<T>(String boxName, String key, {T? defaultValue}) async {
    final box = await _getBox(boxName);

    try {
      final dynamic value = box.get(key, defaultValue: defaultValue);

      if (value == null) {
        return defaultValue;
      }

      if (value is T) {
        return value;
      }

      // Handle special case for ResultsEntity list
      if ((T == List<ResultsEntity>) && value is List) {
        return value.map((item) => item as ResultsEntity).toList() as T?;
      }

      // Handle generic Lists
      if (T.toString().startsWith('List<') && value is List) {
        return value as T?;
      }

      try {
        return value as T?;
      } catch (castError) {
        developer.log(
            'Type casting error in box: $boxName, key: $key. Expected: $T, got: ${value.runtimeType}',
            error: castError);
        return defaultValue;
      }
    } catch (e) {
      developer.log('Failed to get from box: $boxName, key: $key', error: e);
      throw StorageException('Failed to get from $boxName: $e');
    }
  }

  /// Throws [StorageException] if the operation fails.
  Future<bool> containsKey(String boxName, String key) async {
    final box = await _getBox(boxName);

    try {
      return box.containsKey(key);
    } catch (e) {
      developer.log('Failed to check if key exists in box: $boxName, key: $key',
          error: e);
      throw StorageException('Failed to check if key exists in $boxName: $e');
    }
  }

  /// Throws [StorageException] if the operation fails.
  Future<List<dynamic>> getAll(String boxName) async {
    final box = await _getBox(boxName);

    try {
      return box.values.toList();
    } catch (e) {
      developer.log('Failed to get all values from box: $boxName', error: e);
      throw StorageException('Failed to get all from $boxName: $e');
    }
  }

  /// Retrieves all keys from the specified box.
  ///
  /// [boxName] The name of the box.
  ///
  /// Returns a list of all keys in the box.
  /// Throws [StorageException] if the operation fails.
  Future<List<dynamic>> getAllKeys(String boxName) async {
    final box = await _getBox(boxName);

    try {
      return box.keys.toList();
    } catch (e) {
      developer.log('Failed to get all keys from box: $boxName', error: e);
      throw StorageException('Failed to get all keys from $boxName: $e');
    }
  }

  Future<void> closeBox(String boxName) async {
    try {
      // Check if the box is in our cache first
      if (_openBoxes.containsKey(boxName)) {
        final box = _openBoxes[boxName]!;
        if (box.isOpen) {
          await box.close();
          _openBoxes.remove(boxName);
        }
      } else if (Hive.isBoxOpen(boxName)) {
        // If not in our cache but still open in Hive
        final box = Hive.box(boxName);
        await box.close();
      }
    } catch (e) {
      developer.log('Failed to close box: $boxName', error: e);
      throw StorageException('Failed to close box $boxName: $e');
    }
  }

  Future<void> clearBox(String boxName) async {
    try {
      final box = await _getBox(boxName);
      await box.clear();
    } catch (e) {
      developer.log('Failed to clear box: $boxName', error: e);
      throw StorageException('Failed to clear box $boxName: $e');
    }
  }

  Future<void> deleteBox(String boxName) async {
    try {
      // Close the box if it's open
      if (_openBoxes.containsKey(boxName)) {
        final box = _openBoxes[boxName]!;
        if (box.isOpen) {
          await box.close();
        }
        _openBoxes.remove(boxName);
      } else if (Hive.isBoxOpen(boxName)) {
        // If not in our cache but still open in Hive
        final box = Hive.box(boxName);
        await box.close();
      }

      // Delete the box from disk
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      developer.log('Failed to delete box: $boxName', error: e);
      throw StorageException('Failed to delete box $boxName: $e');
    }
  }

  Future<void> closeAllBoxes() async {
    try {
      for (var box in _openBoxes.values) {
        if (box.isOpen) {
          await box.close();
        }
      }
      _openBoxes.clear();
    } catch (e) {
      developer.log('Failed to close all boxes', error: e);
      throw StorageException('Failed to close all boxes: $e');
    }
  }

  Future<int> getCount(String boxName) async {
    final box = await _getBox(boxName);

    try {
      return box.length;
    } catch (e) {
      developer.log('Failed to get count from box: $boxName', error: e);
      throw StorageException('Failed to get count from $boxName: $e');
    }
  }
}
