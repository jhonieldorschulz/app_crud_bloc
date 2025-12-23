import 'package:app_crud_bloc/core/base/crud_bloc.dart';
import 'package:app_crud_bloc/logic/item/item_list_cubit.dart';
import 'package:app_crud_bloc/logic/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/item_repository.dart';
import '../../logic/locale/locale_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<ItemRepository>(
    ItemRepository(database: getIt<AppDatabase>()),
  );

  getIt.registerFactory<CrudBloc<Item>>(
        () => CrudBloc<Item>(
      repository: getIt<ItemRepository>(),
    ),
  );

  getIt.registerFactory<ItemListCubit>(
        () => ItemListCubit(),
  );

  getIt.registerSingleton<LocaleBloc>(LocaleBloc());

  getIt.registerSingleton<ThemeBloc>(ThemeBloc());
}