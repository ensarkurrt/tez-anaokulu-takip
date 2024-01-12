import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindergarden_mobile/service_layer/hive/models/hive_model.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabaseOperation<T extends HiveModelMixin> {
  final String _key = T.toString();

  /// The `box` property is a Hive box of type `T` with the given key.
  Box<T> get _box => Hive.box<T>(_key);

  /// The function `start` opens a Hive box of type `T` with the given key asynchronously.
  Future start() async {
    Logger.instance.log("HiveManagerMixin starting");
    if (Hive.isBoxOpen(_key)) return;
    Box<T> bx = await Hive.openBox<T>(_key, path: (await getApplicationDocumentsDirectory()).path);
    Logger.instance.log("HiveManagerMixin started box is open : ${bx.isOpen}");
  }

  /// The `clear` function clears all data in the `box`.
  Future clear() async => await _box.clear();

  /// The `getItem` function retrieves an item from a box using a given key and returns it, or returns null if the item does
  /// not exist.
  ///
  /// Args:
  ///   model (T): The `model` parameter is of type `T`, which represents the type of the item being added or updated in the
  /// box. It is used to store or update an item in the box using the provided key.
  Future addOrUpdateItem(T model) async => await _box.put(model.key, model);

  /// The function `getItem` retrieves an item from a box using a given key and returns it, or returns null if the item does
  /// not exist.
  ///
  /// Args:
  ///   key (String): The key is a string that is used to retrieve an item from a box.
  T? getItem(String key) => _box.get(key);

  List<T>? getAll() => _box.values.toList();

  /// The function `deleteItem` deletes an item from a box using a given key.
  ///
  /// Args:
  ///   key (String): The key is a string that represents the unique identifier of the item to be deleted from the box.
  Future deleteItem(String key) async => await _box.delete(key);
}
