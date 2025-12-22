import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import '../../presentation/screens/item/item_list_screen.dart';
import '../../presentation/screens/item/item_form_screen.dart';
import '../../presentation/screens/item/item_detail_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart'; // ✅ PRESERVADO

/// AppRouter - Configuração de rotas com GoRouter
class AppRouter {
  AppRouter._();

  // NavigatorKey global para preservar estado de navegação
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RouteNames.items,
    debugLogDiagnostics: true,

    routes: [
      // ========================================
      // HOME (Redireciona para Items)
      // ========================================
      GoRoute(
        path: RouteNames.home,
        redirect: (context, state) => RouteNames.items,
      ),

      // ========================================
      // ITEMS - Lista
      // ========================================
      GoRoute(
        path: RouteNames.items,
        name: 'items',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ItemListScreen(),
        ),
      ),

      // ========================================
      // ITEMS - Criar
      // ========================================
      GoRoute(
        path: RouteNames.itemCreate,
        name: 'item-create',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ItemFormScreen(itemId: null), // ✅ CORRETO
        ),
      ),

      // ========================================
      // ITEMS - Detalhes
      // ========================================
      GoRoute(
        path: RouteNames.itemDetail,
        name: 'item-detail',
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MaterialPage(
            key: state.pageKey,
            child: ItemDetailScreen(itemId: id), // ✅ CORRETO
          );
        },
      ),

      // ========================================
      // ITEMS - Editar
      // ========================================
      GoRoute(
        path: RouteNames.itemEdit,
        name: 'item-edit',
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MaterialPage(
            key: state.pageKey,
            child: ItemFormScreen(itemId: id), // ✅ CORRETO
          );
        },
      ),

      // ========================================
      // SETTINGS (✅ PRESERVADO!)
      // ========================================
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SettingsScreen(), // ✅ PRESERVADO
        ),
      ),
    ],

    // ========================================
    // ERROR PAGE
    // ========================================
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.items),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}