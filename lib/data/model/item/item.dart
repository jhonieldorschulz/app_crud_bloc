import 'package:drift/drift.dart';

@DataClassName('Item')
class Items extends Table{
  IntColumn get id => integer().autoIncrement()();
  // CAMPOS OBRIGATÓRIOS
  TextColumn get title => text().withLength(min: 3, max: 100)();
  TextColumn get description => text().withLength(min: 10, max: 500)();

  // TIMESTAMPS
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();

  DateTimeColumn get updatedAt => dateTime().nullable().clientDefault(
        () => DateTime.now(),
  )();
}