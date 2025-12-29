import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../model/product/product.dart';

part 'products_dao.g.dart'; // ✅ Será gerado!

/// ProductsDao - Data Access Object para produtos
///
/// Responsável por todas as operações SQL na tabela products
@DriftAccessor(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {

  ProductsDao(AppDatabase db) : super(db);

  // ========================================
  // CREATE
  // ========================================

  /// Insere um novo produto no banco
  ///
  /// Retorna o ID do produto inserido
  Future<int> insertProduct(ProductsCompanion product) async {
    return await into(products).insert(product);
  }

  // ========================================
  // READ - Queries
  // ========================================

  /// Retorna TODOS os produtos
  Future<List<Product>> getAllProducts() async {
    return await select(products).get();
  }

  /// Observa TODOS os produtos (Stream reativo)
  ///
  /// Stream emite automaticamente quando:
  /// - Produto é inserido
  /// - Produto é atualizado
  /// - Produto é deletado
  Stream<List<Product>> watchAllProducts() {
    return select(products).watch();
  }

  /// Retorna produto por ID
  Future<Product?> getProductById(int id) async {
    return await (select(products)..where((p) => p.id.equals(id)))
        .getSingleOrNull();
  }

  /// Observa produto por ID (Stream reativo)
  Stream<Product?> watchProductById(int id) {
    return (select(products)..where((p) => p.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Busca produtos por nome, descrição ou categoria
  ///
  /// Case-insensitive (não diferencia maiúsculas/minúsculas)
  Future<List<Product>> searchProducts(String query) async {
    final lowerQuery = query.toLowerCase();
    return await (select(products)
      ..where((p) =>
      p.name.lower().like('%$lowerQuery%') |
      p.description.lower().like('%$lowerQuery%') |
      p.category.lower().like('%$lowerQuery%')))
        .get();
  }

  /// Retorna produtos de uma categoria
  Future<List<Product>> getProductsByCategory(String category) async {
    return await (select(products)..where((p) => p.category.equals(category)))
        .get();
  }

  /// Retorna apenas produtos ativos
  Future<List<Product>> getActiveProducts() async {
    return await (select(products)..where((p) => p.isActive.equals(true)))
        .get();
  }

  /// Retorna produtos com estoque baixo (< 10)
  Future<List<Product>> getLowStockProducts() async {
    return await (select(products)..where((p) => p.stock.isSmallerThanValue(10)))
        .get();
  }

  // ========================================
  // UPDATE
  // ========================================

  /// Atualiza um produto existente
  ///
  /// Retorna true se atualizou com sucesso
  Future<bool> updateProduct(Product product) async {
    return await update(products).replace(product);
  }

  /// Atualiza APENAS o estoque de um produto
  ///
  /// Mais eficiente que updateProduct quando só o estoque muda
  Future<int> updateStock(int id, int newStock) async {
    return await (update(products)..where((p) => p.id.equals(id)))
        .write(ProductsCompanion(
      stock: Value(newStock),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Ativa ou desativa um produto
  Future<int> toggleActive(int id, bool isActive) async {
    return await (update(products)..where((p) => p.id.equals(id)))
        .write(ProductsCompanion(
      isActive: Value(isActive),
      updatedAt: Value(DateTime.now()),
    ));
  }

  // ========================================
  // DELETE
  // ========================================

  /// Deleta um produto por ID
  ///
  /// Retorna número de linhas deletadas (0 ou 1)
  Future<int> deleteProduct(int id) async {
    return await (delete(products)..where((p) => p.id.equals(id))).go();
  }

  /// Deleta TODOS os produtos
  ///
  /// ⚠️ CUIDADO: Ação irreversível!
  Future<int> deleteAllProducts() async {
    return await delete(products).go();
  }

  // ========================================
  // AGGREGATIONS
  // ========================================

  /// Conta total de produtos
  Future<int> countProducts() async {
    final count = countAll();
    final query = selectOnly(products)..addColumns([count]);
    return (await query.getSingle()).read(count) ?? 0;
  }

  /// Calcula valor total em estoque
  ///
  /// Soma: (preço × estoque) de todos os produtos
  /// Retorna valor em centavos
  Future<double> getTotalStockValue() async {
    final allProducts = await getAllProducts();
    return allProducts.fold<double>(0, (sum, p) => sum + (p.price * p.stock));
  }
}