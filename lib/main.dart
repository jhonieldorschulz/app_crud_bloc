import 'package:app_crud_bloc/logic/locale/locale_state.dart';
import 'package:app_crud_bloc/logic/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/theme/app_theme.dart';
import 'core/base/crud_bloc.dart';
import 'core/base/crud_event.dart';
import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'data/database/app_database.dart';
import 'logic/theme/theme_bloc.dart';
import 'logic/theme/theme_event.dart';
import 'logic/locale/locale_bloc.dart';
import 'logic/locale/locale_event.dart';
import 'l10n/app_localizations.dart';

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
        // ✅ Item BLoCs
        BlocProvider<CrudBloc<Item>>(
          create: (context) => getIt<CrudBloc<Item>>()
            ..add(const LoadAllEvent<Item>()),
        ),

        BlocProvider<CrudBloc<Product>>(
          create: (context) => getIt<CrudBloc<Product>>()
            ..add(const LoadAllEvent<Product>()),
        ),

        // ✅ Theme BLoC - Carregar tema salvo ao iniciar
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>()
            ..add(const LoadSavedThemeEvent()),
        ),

        // ✅ Locale BLoC - Carregar locale salvo ao iniciar
        BlocProvider<LocaleBloc>(
          create: (context) => getIt<LocaleBloc>()
            ..add(const LoadSavedLocaleEvent()),
        ),
      ],
      child: const _AppWithLocale(),
    );
  }
}

/// Widget que reconstrói completamente quando locale ou tema mudam
class _AppWithLocale extends StatefulWidget {
  const _AppWithLocale();

  @override
  State<_AppWithLocale> createState() => _AppWithLocaleState();
}

class _AppWithLocaleState extends State<_AppWithLocale> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => true, // Sempre reconstruir
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          buildWhen: (previous, current) => true, // Sempre reconstruir
          builder: (context, localeState) {
            // Obter tema
            final isDark = themeState is ThemeLoaded && themeState.isDark;

            // Obter locale - sempre ter um locale válido
            Locale locale;
            if (localeState is LocaleChanged) {
              locale = localeState.locale;
            } else {
              // Estado inicial - usar 'en' como padrão
              locale = const Locale('en');
            }

            // Criar uma key única baseada no locale para forçar reconstrução completa
            final appKey = ValueKey('app_locale_${locale.languageCode}');

            return MaterialApp.router(
              key: appKey,
              title: 'Flutter CRUD App',
              debugShowCheckedModeBanner: false,

              // ✅ Tema
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

              // ✅ Locale (i18n)
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              // ✅ Router (com NavigatorKey para preservar navegação)
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}