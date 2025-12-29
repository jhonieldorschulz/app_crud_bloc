// ========================================
// PRODUCT ENTITY (NOVO - OPCIONAL!)
// ========================================
abstract class ProductEntity {
  int? get id;
  String get name;
  String get description;
  int get price;
  int get stock;
  String get category;
  String? get barcode;
  bool get isActive;
  DateTime get createdAt;
  DateTime? get updatedAt;
}