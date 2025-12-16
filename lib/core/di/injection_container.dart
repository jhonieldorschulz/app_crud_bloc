import 'package:get_it/get_it.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/item_repository.dart';
import '../../logic/item/item_bloc.dart';
import '../../logic/locale/locale_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<ItemRepository>(
    ItemRepository(database: getIt<AppDatabase>()),
  );

  getIt.registerFactory<ItemBloc>(
        () => ItemBloc(repository: getIt<ItemRepository>()),
  );

  getIt.registerSingleton<LocaleBloc>(LocaleBloc());
}