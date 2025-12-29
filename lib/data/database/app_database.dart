import 'dart:io';
import 'package:app_crud_bloc/data/dao/products_dao.dart';
import 'package:app_crud_bloc/data/model/product/product.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../model/item/item.dart';

import '../dao/items_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
    tables: [Items, Products],
    daos: [ItemsDao, ProductsDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  ItemsDao get itemsDao => ItemsDao(this);
  ProductsDao get productsDao => ProductsDao(this);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
