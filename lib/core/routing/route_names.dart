class RouteNames {
  static const home = '/';
  static const settings = '/settings';
  static const itemDetail = '/item/:id';
  static const itemCreate = '/item/new';
  static const itemEdit = '/item/:id/edit';

  static String itemDetailPath(int id) => '/item/$id';
  static String itemEditPath(int id) => '/item/$id/edit';
}