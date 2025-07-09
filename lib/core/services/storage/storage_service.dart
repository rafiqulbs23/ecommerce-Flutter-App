abstract class StorageService {

  Future<void> store<T>(String key, T value);

  Future<T?> get<T>(String key);

  Future<bool> exists(String key);

  Future<void> remove(String key);

  Future<void> clear();
}