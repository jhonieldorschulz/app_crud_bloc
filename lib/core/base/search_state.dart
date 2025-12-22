import 'package:equatable/equatable.dart';
import 'search_event.dart'; // Para SortFilter enum

/// SearchState<T> - Estado genérico de busca
/// 
/// Contém:
/// - query: texto digitado pelo usuário
/// - sortFilter: filtro de ordenação selecionado
/// - allEntities: lista completa (antes de filtros)
/// - filteredEntities: lista após busca + ordenação
/// 
/// Estado é imutável (usa copyWith)
final class SearchState<T> extends Equatable {
  final String query;
  final SortFilter sortFilter;
  final List<T> allEntities;
  final List<T> filteredEntities;

  const SearchState({
    this.query = '',
    this.sortFilter = SortFilter.recentFirst,
    this.allEntities = const [],
    this.filteredEntities = const [],
  });

  /// Copiar estado com modificações
  SearchState<T> copyWith({
    String? query,
    SortFilter? sortFilter,
    List<T>? allEntities,
    List<T>? filteredEntities,
  }) {
    return SearchState<T>(
      query: query ?? this.query,
      sortFilter: sortFilter ?? this.sortFilter,
      allEntities: allEntities ?? this.allEntities,
      filteredEntities: filteredEntities ?? this.filteredEntities,
    );
  }

  /// Helpers úteis (computed properties)

  /// Está buscando? (query não está vazia)
  bool get isSearching => query.isNotEmpty;

  /// Busca retornou vazio? (está buscando mas não achou nada)
  bool get hasNoResults => isSearching && filteredEntities.isEmpty;

  /// Tem resultados?
  bool get hasResults => filteredEntities.isNotEmpty;

  /// Quantidade de resultados
  int get resultsCount => filteredEntities.length;

  @override
  List<Object?> get props => [query, sortFilter, allEntities, filteredEntities];

  @override
  String toString() {
    return 'SearchState(query: "$query", filter: $sortFilter, '
        'all: ${allEntities.length}, filtered: ${filteredEntities.length})';
  }
}