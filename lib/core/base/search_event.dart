import 'package:equatable/equatable.dart';

/// SearchEvent<T> - Eventos genéricos de busca
/// 
/// Sealed class para pattern matching exhaustivo
sealed class SearchEvent<T> extends Equatable {
  const SearchEvent();
}

/// UpdateSearchQueryEvent - Atualizar query de busca
/// 
/// Disparado quando usuário digita no campo de busca
final class UpdateSearchQueryEvent<T> extends SearchEvent<T> {
  final String query;

  const UpdateSearchQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// ClearSearchEvent - Limpar busca
/// 
/// Disparado quando usuário clica no botão "X" ou limpa o campo
final class ClearSearchEvent<T> extends SearchEvent<T> {
  const ClearSearchEvent();

  @override
  List<Object?> get props => [];
}

/// UpdateSortFilterEvent - Atualizar filtro de ordenação
/// 
/// Disparado quando usuário seleciona um filtro diferente
final class UpdateSortFilterEvent<T> extends SearchEvent<T> {
  final SortFilter filter;

  const UpdateSortFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// UpdateAllEntitiesEvent - Atualizar lista completa
/// 
/// IMPORTANTE: Disparado quando CrudBloc emite CrudLoaded
/// Sincroniza a lista de busca com a lista do CRUD
/// 
/// Uso:
/// ```dart
/// BlocListener<CrudBloc<Item>, CrudState<Item>>(
///   listener: (context, state) {
///     if (state is CrudLoaded<Item>) {
///       context.read<SearchBloc<Item>>().add(
///         UpdateAllEntitiesEvent(state.entities),
///       );
///     }
///   },
/// )
/// ```
final class UpdateAllEntitiesEvent<T> extends SearchEvent<T> {
  final List<T> entities;

  const UpdateAllEntitiesEvent(this.entities);

  @override
  List<Object?> get props => [entities];
}

/// SortFilter - Tipos de ordenação disponíveis
enum SortFilter {
  recentFirst,    // Mais recente primeiro (padrão)
  oldestFirst,    // Mais antigo primeiro
  alphabeticalAZ, // Alfabético A → Z
  alphabeticalZA, // Alfabético Z → A
}

/// Extension para labels e ícones dos filtros
extension SortFilterExtension on SortFilter {
  /// Label para exibição
  String get label {
    return switch (this) {
      SortFilter.recentFirst => 'Recent',
      SortFilter.oldestFirst => 'Oldest',
      SortFilter.alphabeticalAZ => 'A-Z',
      SortFilter.alphabeticalZA => 'Z-A',
    };
  }

  /// Ícone para exibição (emoji)
  String get icon {
    return switch (this) {
      SortFilter.recentFirst => '🕐',
      SortFilter.oldestFirst => '⏰',
      SortFilter.alphabeticalAZ => '🔤',
      SortFilter.alphabeticalZA => '🔡',
    };
  }
}