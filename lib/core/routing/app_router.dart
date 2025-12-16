import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/item/item_list_screen.dart';
import '../../presentation/screens/item/item_detail_screen.dart';
import '../../presentation/screens/item/item_form_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import 'route_names.dart';

enum FormMode { create, edit }

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      // ========== HOME ==========
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const ItemListScreen(),
      ),

      // ========== SETTINGS ==========
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // ========== ITEM CREATE (ANTES do :id!) ==========
      /// IMPORTANTE: /item/new DEVE vir ANTES de /item/:id
      /// GoRouter testa rotas na ORDEM declarada
      /// Se :id vier primeiro, "new" será capturado como ID
      GoRoute(
        path: RouteNames.itemCreate,  // '/item/new'
        builder: (context, state) => const ItemFormScreen(
          mode: FormMode.create,
        ),
      ),

      // ========== ITEM DETAIL (DEPOIS do /new!) ==========
      /// Agora /item/new já foi tratado acima
      /// Apenas IDs numéricos chegam aqui
      GoRoute(
        path: RouteNames.itemDetail,  // '/item/:id'
        builder: (context, state) {
          final idParam = state.pathParameters['id'];

          // Validar que é número
          if (idParam == null) {
            throw Exception('Item ID é obrigatório');
          }

          final id = int.tryParse(idParam);
          if (id == null) {
            throw Exception('ID inválido: $idParam');
          }

          return ItemDetailScreen(itemId: id);
        },
      ),

      // ========== ITEM EDIT ==========
      GoRoute(
        path: RouteNames.itemEdit,  // '/item/:id/edit'
        builder: (context, state) {
          final idParam = state.pathParameters['id'];

          if (idParam == null) {
            throw Exception('Item ID é obrigatório');
          }

          final id = int.tryParse(idParam);
          if (id == null) {
            throw Exception('ID inválido: $idParam');
          }

          return ItemFormScreen(
            mode: FormMode.edit,
            itemId: id,
          );
        },
      ),
    ],
  );
}