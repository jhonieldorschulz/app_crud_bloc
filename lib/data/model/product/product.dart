import 'package:drift/drift.dart';

/// Product - Tabela de Produtos
///
/// Representa um produto com nome, preço, estoque e categoria
/// Segue o mesmo padrão da tabela Items
@DataClassName('Product')
class Products extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // CAMPOS OBRIGATÓRIOS
  TextColumn get name => text().withLength(min: 3, max: 100)();
  TextColumn get description => text().withLength(min: 10, max: 500)();

  // CAMPOS DE PRODUTO
  Column<double> get price => real()(); // Preço em centavos
  IntColumn get stock => integer().withDefault(const Constant(0))();
  TextColumn get category => text().withLength(min: 3, max: 50)();

  // CAMPO OPCIONAL
  TextColumn get barcode => text().withLength(max: 50).nullable()();

  // CAMPO BOOLEANO
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  // TIMESTAMPS
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();

  DateTimeColumn get updatedAt => dateTime().nullable().clientDefault(
        () => DateTime.now(),
  )();
}

