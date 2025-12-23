import '../../core/base/base_repository.dart';
import '../database/app_database.dart';
import '../model/item_extensions.dart';

/// ItemRepository - Implementação de BaseRepository para Item
///
/// Agora implementa interface genérica BaseRepository<Item>
/// Todas as operações CRUD seguem o contrato da interface
class ItemRepository implements BaseRepository<Item> {
  final AppDatabase _database;

  ItemRepository({required AppDatabase database}) : _database = database;

  @override
  Future<List<Item>> getAll() async {
    try {
      return await _database.itemsDao.getAllItems();
    } catch (e) {
      throw Exception('Failed to get all items: $e');
    }
  }

  @override
  Future<Item?> getById(Object id) async {
    try {
      if (id is! int) {
        throw ArgumentError('Item ID must be int, got: ${id.runtimeType}');
      }
      return await _database.itemsDao.getItemById(id);
    } catch (e) {
      throw Exception('Failed to get item by id: $e');
    }
  }

  @override
  Future<int> create(Map<String, dynamic> data) async {
    try {
      // Validação ANTES de tentar criar
      _validateItemData(data);

      return await _database.itemsDao.insertItem(
        ItemsCompanion.insert(
          title: data['title'] as String,
          description: data['description'] as String,
        ),
      );
    } catch (e) {
      if (e is ArgumentError) {
        rethrow; // Propagar erro de validação
      }
      throw Exception('Failed to create item: $e');
    }
  }

  @override
  Future<bool> update(Item entity) async {
    try {
      // Validar se item existe
      final exists = await getById(entity.id!);
      if (exists == null) {
        throw StateError('Item not found: ${entity.id}');
      }

      return await _database.itemsDao.updateItem(entity);
    } catch (e) {
      if (e is StateError) {
        rethrow;
      }
      throw Exception('Failed to update item: $e');
    }
  }

  @override
  Future<bool> delete(Object id) async {
    try {
      if (id is! int) {
        throw ArgumentError('Item ID must be int, got: ${id.runtimeType}');
      }

      final rows = await _database.itemsDao.deleteItem(id);
      return rows > 0;
    } catch (e) {
      if (e is ArgumentError) {
        rethrow;
      }
      throw Exception('Failed to delete item: $e');
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _database.itemsDao.deleteAllItems();
    } catch (e) {
      throw Exception('Failed to delete all items: $e');
    }
  }

  @override
  @override
  Future<List<Item>> search(String query) async {
    final allItems = await getAll();
    final lowerQuery = query.toLowerCase();

    return allItems.where((item) {
      final titleMatch = item.title.toLowerCase().contains(lowerQuery);
      final descMatch = item.description.toLowerCase().contains(lowerQuery);

      return titleMatch || descMatch;
    }).toList();
  }

  /// Validar dados do item (privado)
  void _validateItemData(Map<String, dynamic> data) {
    // Validar título
    if (!data.containsKey('title')) {
      throw ArgumentError('Title is required');
    }

    final title = data['title'];
    if (title is! String) {
      throw ArgumentError('Title must be a string');
    }

    if (title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }

    if (title.length < 3) {
      throw ArgumentError('Title must be at least 3 characters');
    }

    if (title.length > 200) {
      throw ArgumentError('Title cannot exceed 200 characters');
    }

    // Validar descrição
    if (!data.containsKey('description')) {
      throw ArgumentError('Description is required');
    }

    final description = data['description'];
    if (description is! String) {
      throw ArgumentError('Description must be a string');
    }

    if (description.trim().isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }

    if (description.length < 10) {
      throw ArgumentError('Description must be at least 10 characters');
    }
  }
}