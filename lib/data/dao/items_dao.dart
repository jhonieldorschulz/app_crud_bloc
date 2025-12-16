import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../model/item.dart';

/// ItemsDao - Data Access Object para operações CRUD
///
/// @DriftAccessor: Marca classe como DAO do Drift
/// part: Arquivo gerado pelo build_runner
part 'items_dao.g.dart';

@DriftAccessor(tables: [Items])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  // ========== CREATE ==========

  /// Insere novo item
  Future<int> insertItem(ItemsCompanion companion) {
    return into(items).insert(companion);
  }

  // ========== READ ==========

  /// Retorna todos os itens (ordenado por data decrescente)
  Future<List<Item>> getAllItems() {
    return (select(items)
      ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
      ]))
        .get();
  }

  /// Retorna item por ID
  Future<Item?> getItemById(int id) {
    return (select(items)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Stream reativo de todos os itens
  Stream<List<Item>> watchAllItems() {
    return (select(items)
      ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
      ]))
        .watch();
  }

  /// Stream reativo de item específico
  Stream<Item?> watchItemById(int id) {
    return (select(items)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  // ========== UPDATE ==========

  /// Atualiza item existente
  Future<bool> updateItem(Item item) {
    return update(items).replace(item);
  }

  // ========== DELETE ==========

  /// Deleta item por ID
  Future<int> deleteItem(int id) {
    return (delete(items)..where((t) => t.id.equals(id))).go();
  }

  /// Deleta todos os itens
  Future<int> deleteAllItems() {
    return delete(items).go();
  }

  // ========== QUERIES EXTRAS ==========

  /// Busca itens por texto
  Future<List<Item>> searchItems(String query) {
    final pattern = '%$query%';
    return (select(items)
      ..where((t) =>
      t.title.like(pattern) | t.description.like(pattern))
      ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
      ]))
        .get();
  }

  /// Conta total de itens
  Future<int> countItems() async {
    final query = selectOnly(items)..addColumns([items.id.count()]);
    final result = await query.getSingle();
    return result.read(items.id.count()) ?? 0;
  }
}