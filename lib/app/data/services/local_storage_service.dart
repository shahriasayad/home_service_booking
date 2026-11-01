import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String settingsBoxName = 'settings_box';
  static const String dataBoxName = 'app_data_box';

  Box<dynamic>? _settingsBox;
  Box<dynamic>? _dataBox;
  final Map<String, dynamic> _memoryFallback = {};
  bool _isInitialized = false;
  bool _inMemory = false;

  bool get isInitialized => _isInitialized;

  Future<void> init({String? testPath, bool inMemory = false}) async {
    if (_isInitialized) return;
    _inMemory = inMemory;
    if (_inMemory) {
      _isInitialized = true;
      return;
    }
    try {
      if (testPath != null) {
        Hive.init(testPath);
      } else {
        await Hive.initFlutter();
      }
      _settingsBox = await Hive.openBox<dynamic>(settingsBoxName);
      _dataBox = await Hive.openBox<dynamic>(dataBoxName);
      _isInitialized = true;
    } catch (e) {
      debugPrint('LocalStorageService fallback to memory storage: $e');
      _inMemory = true;
      _isInitialized = true;
    }
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    if (!_inMemory && _settingsBox != null && _settingsBox!.isOpen) {
      final val = _settingsBox!.get(key, defaultValue: defaultValue);
      return val is T ? val : defaultValue;
    }
    final val = _memoryFallback['setting_$key'];
    return val is T ? val : defaultValue;
  }

  Future<void> setSetting(String key, dynamic value) async {
    _memoryFallback['setting_$key'] = value;
    if (!_inMemory && _settingsBox != null && _settingsBox!.isOpen) {
      await _settingsBox!.put(key, value);
    }
  }

  List<Map<dynamic, dynamic>>? getList(String key) {
    dynamic raw;
    if (!_inMemory && _dataBox != null && _dataBox!.isOpen) {
      raw = _dataBox!.get(key);
    } else {
      raw = _memoryFallback['data_$key'];
    }
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => Map<dynamic, dynamic>.from(e))
          .toList();
    }
    return null;
  }

  Future<void> saveList(String key, List<Map<String, dynamic>> items) async {
    _memoryFallback['data_$key'] = items;
    if (!_inMemory && _dataBox != null && _dataBox!.isOpen) {
      await _dataBox!.put(key, items);
    }
  }

  Future<void> clearAll() async {
    _memoryFallback.clear();
    if (!_inMemory && _settingsBox != null && _settingsBox!.isOpen) {
      await _settingsBox!.clear();
    }
    if (!_inMemory && _dataBox != null && _dataBox!.isOpen) {
      await _dataBox!.clear();
    }
  }

  Future<void> close() async {
    _memoryFallback.clear();
    if (!_inMemory) {
      if (_settingsBox != null && _settingsBox!.isOpen) {
        await _settingsBox!.close();
      }
      if (_dataBox != null && _dataBox!.isOpen) {
        await _dataBox!.close();
      }
    }
    _settingsBox = null;
    _dataBox = null;
    _isInitialized = false;
  }
}
