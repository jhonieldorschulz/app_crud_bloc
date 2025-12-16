import '../database/app_database.dart';
import 'package:drift/drift.dart';

class ItemRepository {
  final AppDatabase _database;

  ItemRepository({required AppDatabase database}) : _database = database;

  Future<int> createItem({required String title, required String description}) async {
    return await _database.itemsDao.insertItem(
      ItemsCompanion.insert(title: title, description: description),
    );
  }

  Future<List<Item>> getAllItems() async {
    return await _database.itemsDao.getAllItems();
  }

  Future<Item?> getItemById(int id) async {
    return await _database.itemsDao.getItemById(id);
  }

  Future<bool> updateItem(Item item) async {
    return await _database.itemsDao.updateItem(item);
  }

  Future<bool> deleteItem(int id) async {
    final rows = await _database.itemsDao.deleteItem(id);
    return rows > 0;
  }

  Future<void> deleteAllItems() async {
    await _database.itemsDao.deleteAllItems();
  }
}