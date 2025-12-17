import 'package:app_crud_bloc/core/theme/app_theme.dart';
import 'package:app_crud_bloc/logic/theme/theme_bloc.dart';
import 'package:app_crud_bloc/logic/theme/theme_event.dart';
import 'package:app_crud_bloc/logic/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'l10n/app_localizations.dart';
import 'logic/item/item_bloc.dart';
import 'logic/item/item_event.dart';
import 'logic/locale/locale_bloc.dart';
import 'logic/locale/locale_event.dart';
import 'logic/locale/locale_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBloc>(
          create: (context) =>
              getIt<LocaleBloc>()..add(const LoadSavedLocaleEvent()),
        ),

        // ThemeBloc (Singleton) - NOVO!
        BlocProvider<ThemeBloc>(
          create: (context) =>
              getIt<ThemeBloc>()..add(const LoadSavedThemeEvent()),
        ),

        BlocProvider<ItemBloc>(
          create: (context) => getIt<ItemBloc>()..add(const LoadItemsEvent()),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          Locale locale = const Locale('en');
          if (state is LocaleChanged) {
            locale = state.locale;
          }

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              bool isDark = false;
              if (themeState is ThemeLoaded) {
                isDark = themeState.isDark;
              }

              return MaterialApp.router(
                title: 'CRUD App',
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.router,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('pt'),
                  Locale('es'),
                ],
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              );
            },
          );
        },
      ),
    );
  }
}
