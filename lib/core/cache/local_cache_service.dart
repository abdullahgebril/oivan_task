import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalCacheService {
  static final provider = Provider<ILocalCacheService>(
    (ref) => LocalCacheServiceImpl(),
  );

  Future<void> init();
  Future<void> saveData<T>(String key, T data);
  Future<T?> getData<T>(String key);
  Future<void> removeData(String key);
  Future<void> clearAll();
  Future<bool> containsKey(String key);
  Future<List<T>> getList<T>(String key);
  Future<void> saveList<T>(String key, List<T> data);
}

class LocalCacheServiceImpl implements ILocalCacheService {
  static const String _mainBoxName = 'oivan_cache';
  late Box _box;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_mainBoxName);
  }

  @override
  Future<void> saveData<T>(String key, T data) async {
    await _box.put(key, data);
  }

  @override
  Future<T?> getData<T>(String key) async {
    return _box.get(key) as T?;
  }

  @override
  Future<void> removeData(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }

  @override
  Future<List<T>> getList<T>(String key) async {
    final dynamic data = _box.get(key);
    if (data == null) return [];
    if (data is List) {
      return data.cast<T>();
    }
    return [];
  }

  @override
  Future<void> saveList<T>(String key, List<T> data) async {
    await _box.put(key, data);
  }
}
