/// RouteNames - Constantes de rotas do aplicativo
class RouteNames {
  RouteNames._();

  // ========================================
  // HOME
  // ========================================
  static const String home = '/';

  // ========================================
  // ITEMS
  // ========================================
  static const String items = '/items';
  static const String itemCreate = '/item/create';
  static const String itemDetail = '/item/:id';
  static const String itemEdit = '/item/:id/edit';

  // ========================================
  // PRODUCTS (Futuro)
  // ========================================
  // static const String products = '/products';
  // static const String productCreate = '/product/create';
  // static const String productDetail = '/product/:id';
  // static const String productEdit = '/product/:id/edit';

  // ========================================
  // SETTINGS (✅ PRESERVADO!)
  // ========================================
  static const String settings = '/settings';

  // ========================================
  // HELPERS
  // ========================================

  /// Cria rota para detalhes do item
  static String itemDetailPath(int id) => '/item/$id';

  /// Cria rota para edição do item
  static String itemEditPath(int id) => '/item/$id/edit';
}