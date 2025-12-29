import '../../database/app_database.dart';

/// ProductExtension - Métodos auxiliares para Product
///
/// Adiciona funcionalidades à classe Product gerada pelo Drift
/// sem modificar a classe gerada.
extension ProductExtension on Product {
  // ========================================
  // OBRIGATÓRIOS - CrudBloc precisa!
  // ========================================

  /// Título para exibição
  /// CrudBloc usa este método para BUSCA
  /// Equivalente ao "title" do Item
  String get displayTitle => name;

  /// Descrição para exibição
  /// CrudBloc usa este método para BUSCA
  /// Busca em: displayTitle OU displayDescription
  String? get displayDescription => description;

  /// Data de criação para ORDENAÇÃO
  /// CrudBloc usa este método para ordenar lista
  DateTime get entityCreatedAt => createdAt;

  // ========================================
  // FORMATAÇÕES
  // ========================================

  /// Preço formatado em reais
  ///
  /// Converte centavos → R$ formatado
  /// Exemplos:
  /// - 1999 → "R$ 19,99"
  /// - 199900 → "R$ 1999,00"
  /// - 50 → "R$ 0,50"
  String get formattedPrice {
    final reais = price ~/ 100;        // Divisão inteira
    final centavos = price % 100;      // Resto da divisão
    return 'R\$ ${reais.toString()},${centavos.toString().padLeft(2, '0')}';
  }

  /// Preço em reais (decimal) para cálculos
  ///
  /// Exemplo: 1999 → 19.99
  double get priceInReals => price / 100;

  // ========================================
  // LÓGICA DE ESTOQUE
  // ========================================

  /// Estoque está baixo? (menos de 10 unidades)
  bool get isLowStock => stock < 10;

  /// Produto está esgotado? (estoque = 0)
  bool get isOutOfStock => stock == 0;

  /// Produto tem estoque disponível?
  bool get isInStock => stock > 0;

  /// Status do estoque em texto
  ///
  /// Retorna:
  /// - "Esgotado" se stock = 0
  /// - "Estoque Baixo" se stock < 10
  /// - "Disponível" se stock >= 10
  String get stockStatus {
    if (isOutOfStock) return 'Esgotado';
    if (isLowStock) return 'Estoque Baixo';
    return 'Disponível';
  }

  /// Cor do status (para UI)
  ///
  /// Retorna:
  /// - 'red' se esgotado
  /// - 'yellow' se estoque baixo
  /// - 'green' se disponível
  String get stockStatusColor {
    if (isOutOfStock) return 'red';
    if (isLowStock) return 'yellow';
    return 'green';
  }

  // ========================================
  // VALIDAÇÕES DE NEGÓCIO
  // ========================================

  /// Produto está disponível para venda?
  ///
  /// Verifica: ativo E tem estoque
  bool get isAvailableForSale => isActive && isInStock;

  /// Produto precisa de reposição?
  bool get needsRestocking => isLowStock || isOutOfStock;

  // ========================================
  // CÁLCULOS
  // ========================================

  /// Valor total do estoque (em centavos)
  ///
  /// Exemplo: R$ 19,99 × 10 un = 19990 centavos
  double get totalStockValue => price * stock;

  /// Valor total formatado
  ///
  /// Exemplo: R$ 19,99 × 10 = "R$ 199,90"
  String get formattedTotalStockValue {
    final total = totalStockValue;
    final reais = total ~/ 100;
    final centavos = total % 100;
    return 'R\$ ${reais.toString()},${centavos.toString().padLeft(2, '0')}';
  }
}