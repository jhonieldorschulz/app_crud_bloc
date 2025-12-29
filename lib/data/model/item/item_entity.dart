import '../../../core/base/base_entity.dart';
import '../../database/app_database.dart';

/// ItemEntity - Adapter do Item (Drift) para BaseEntity
/// 
/// Design Pattern: Adapter
/// Converte interface do Drift (Item) para interface genérica (BaseEntity)
/// 
/// Uso:
/// ```dart
/// final item = await database.itemsDao.getItemById(1);
/// final entity = item.toEntity(); // Agora é BaseEntity!
///
/// // Usar em código genérico:
/// print(entity.displayTitle); // item.title
/// print(entity.displayDescription); // item.description
/// ```
extension ItemEntity on Item {
  /// Converter Item para BaseEntity
  BaseEntity toEntity() => _ItemEntityAdapter(this);
}

/// _ItemEntityAdapter - Implementação privada do adapter
///
/// Privada (_) porque só deve ser acessada via extension
class _ItemEntityAdapter implements BaseEntity {
  final Item _item;

  _ItemEntityAdapter(this._item);

  @override
  Object? get id => _item.id;

  @override
  String get displayTitle => _item.title;

  @override
  String? get displayDescription => _item.description;

  @override
  DateTime get createdAt => _item.createdAt;

  @override
  BaseEntity copyWith() => _ItemEntityAdapter(_item);

  @override
  Map<String, dynamic> toMap() => {
    'id': _item.id,
    'title': _item.title,
    'description': _item.description,
    'createdAt': _item.createdAt.toIso8601String(),
  };

  /// Obter Item original (útil para operações específicas)
  Item get original => _item;
}