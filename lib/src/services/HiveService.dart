import 'package:hive/hive.dart';

class HiveService {
  final String _boxName;
  Box? _box;

  HiveService(this._boxName);

  /// Ensures the box is opened
  Future<void> _initializeBox() async {
    if (_box == null) {
      if (!Hive.isBoxOpen(_boxName)) {
        _box = await Hive.openBox(_boxName); // Ouvre seulement si nécessaire
      } else {
        _box = Hive.box(_boxName); // Réutilise la boîte déjà ouverte
      }
    }
  }
  /// Saves a value in the box
  Future<void> saveData<T>(String key, T value) async {
    await _initializeBox();
    await _box!.put(key, value);
  }

  /// Retrieves a value from the box
  T? getData<T>(String key) {
    return _box?.get(key) as T?;
  }

  /// Deletes a value from the box
  Future<void> deleteData(String key) async {
    await _initializeBox();
    await _box!.delete(key);
  }

  /// Clears all data from the box
  Future<void> clearAll() async {
    await _initializeBox();
    await _box!.clear();
  }

  /// Checks if a key exists in the box
  bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }
}
