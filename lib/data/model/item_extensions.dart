import '../database/app_database.dart';

/// ItemEntityExtension - Adapta Item para BaseEntity
///
/// Item é gerado automaticamente pelo Drift em app_database.g.dart
/// Não podemos modificar a classe gerada diretamente
/// Usamos Extension para adicionar comportamento de BaseEntity
///
/// Agora Item "age como" um BaseEntity através desta extension
///
/// Uso:
/// ```dart
/// final item = await database.itemsDao.getItemById(1);
///
/// // Métodos da extension funcionam automaticamente:
/// print(item.displayTitle);        // title
/// print(item.displayDescription);  // description
/// print(item.entityCreatedAt);     // createdAt
/// ```
extension ItemEntityExtension on Item {
  /// ID da entidade (Item já tem id)
  Object? get entityId => id;

  /// Título para exibição (usa title da tabela)
  String get displayTitle => title;

  /// Descrição para exibição (usa description da tabela)
  String? get displayDescription => description;

  /// Data de criação (Item já tem createdAt)
  DateTime get entityCreatedAt => createdAt;

  /// Converter para Map (para serialização)
  Map<String, dynamic> toEntityMap() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
  };
}