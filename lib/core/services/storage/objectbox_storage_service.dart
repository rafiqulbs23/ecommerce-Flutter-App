import 'dart:convert';
import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import '../../../objectbox.g.dart';
import 'objectbox.dart';

import 'entities/storage_entity.dart';
import 'storage_service.dart';

@injectable
class ObjectBoxStorageService implements StorageService {
  late final Store _store;
  late final Box<StorageEntity> _box;

  Future<void> initialize() async {
    final box = await ObjectBox.create();
    _store = box.store;
    _box = _store.box<StorageEntity>();
  }

  @override
  Future<void> store<T>(String key, T value) async {
    // Convert the value to a JSON string
    final jsonString = jsonEncode(value);

    // Check if the key already exists
    final query = _box.query(StorageEntity_.key.equals(key)).build();
    final existing = await query.findFirstAsync();
    query.close();

    if (existing != null) {
      // Update existing entity
      existing.value = jsonString;
      existing.createdAt = DateTime.now();
      await _box.putAsync(existing);
    } else {
      // Create new entity
      final entity = StorageEntity(
        key: key,
        value: jsonString,
        createdAt: DateTime.now(),
      );
      await _box.putAsync(entity);
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    final query = _box.query(StorageEntity_.key.equals(key)).build();
    final entity = await query.findFirstAsync();
    query.close();

    if (entity == null) {
      return null;
    }

    try {
      return jsonDecode(entity.value) as T;
    } catch (e) {
      // Handle parsing errors
      log('Error parsing stored value for key $key: $e');
      return null;
    }
  }

  @override
  Future<bool> exists(String key) async {
    final query = _box.query(StorageEntity_.key.equals(key)).build();
    final count = query.count();
    query.close();
    return count > 0;
  }

  @override
  Future<void> remove(String key) async {
    final query = _box.query(StorageEntity_.key.equals(key)).build();
    final entities = await query.findAsync();
    query.close();

    if (entities.isNotEmpty) {
      final ids = entities.map((e) => e.id).toList();
      await _box.removeManyAsync(ids);
    }
  }

  @override
  Future<void> clear() async {
    await _box.removeAllAsync();
  }
}