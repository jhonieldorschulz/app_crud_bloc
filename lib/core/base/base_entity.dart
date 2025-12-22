/// BaseEntity - Interface base para todas as entidades
///
/// Toda entidade (Item, Product, Order, etc) deve implementar esta interface
/// para ser compatível com o sistema CRUD genérico.
///
/// Princípios SOLID aplicados:
/// - Interface Segregation: Apenas métodos essenciais
/// - Dependency Inversion: High-level depende de abstração
abstract class BaseEntity {
  /// ID único da entidade
  /// Pode ser int, String, ou qualquer tipo comparável
  Object? get id;

  /// Título/Nome principal (para exibição em listas)
  /// Exemplo: "Laptop Dell XPS", "João Silva", "Pedido #123"
  String get displayTitle;

  /// Descrição/Resumo (para exibição em cards)
  /// Pode incluir informações secundárias
  /// Exemplo: "R$ 5.999,00 • 5 unidades • Eletrônicos"
  String? get displayDescription;

  /// Data de criação (para ordenação temporal)
  DateTime get createdAt;

  /// Copiar entidade com modificações
  BaseEntity copyWith();

  /// Converter para Map (para persistência/serialização)
  Map<String, dynamic> toMap();
}