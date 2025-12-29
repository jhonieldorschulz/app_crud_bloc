import '../database/app_database.dart';
import '../model/product/product.dart';
import '../model/product/product_extensions.dart';
import '../../core/base/base_repository.dart';
import 'package:drift/drift.dart';

class ProductRepository implements BaseRepository<Product> {
  final AppDatabase database;

  ProductRepository({required this.database});

  @override
  Future<List<Product>> getAll() async {
    return await database.productsDao.getAllProducts();
  }

  @override
  Future<Product?> getById(Object id) async {
    if (id is! int) {
      throw ArgumentError('Product ID must be an integer');
    }
    return await database.productsDao.getProductById(id);
  }

  @override
  Future<Object> create(Map<String, dynamic> data) async {
    final companion = ProductsCompanion(
      name: Value(data['name'] as String),
      description: Value(data['description'] as String),
      price: Value(data['price'] as double),
      stock: Value(data['stock'] as int? ?? 0),
      category: Value(data['category'] as String),
      barcode: Value(data['barcode'] as String?),
      isActive: Value(data['isActive'] as bool? ?? true),
    );
    final id = await database.productsDao.insertProduct(companion);
    return id;
  }

  @override
  Future<bool> update(Product entity) async {
    return await database.productsDao.updateProduct(entity);
  }

  @override
  Future<bool> delete(Object id) async {
    if (id is! int) {
      throw ArgumentError('Product ID must be an integer');
    }
    final deletedRows = await database.productsDao.deleteProduct(id);
    return deletedRows > 0;
  }

  @override
  Future<void> deleteAll() async {
    await database.productsDao.deleteAllProducts();
  }

  @override
  Future<List<Product>> search(String query) async {
    return await database.productsDao.searchProducts(query);
  }
}