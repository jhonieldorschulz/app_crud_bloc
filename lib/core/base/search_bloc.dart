import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';

/// SearchBloc<T> - BLoC genérico para busca e filtros
///
/// Funciona para QUALQUER entidade que tenha os métodos:
/// - displayTitle
/// - displayDescription
/// - entityCreatedAt (ou createdAt)
///
/// IMPORTANTE: SearchBloc não carrega dados do banco!
/// Ele apenas filtra/ordena dados fornecidos via UpdateAllEntitiesEvent
///
/// Fluxo típico:
/// 1. CrudBloc carrega dados do banco → CrudLoaded
/// 2. UI dispara UpdateAllEntitiesEvent no SearchBloc
/// 3. SearchBloc filtra/ordena conforme query e sortFilter
/// 4. UI exibe filteredEntities
///
/// Uso:
/// ```dart
/// // Criar SearchBloc
/// final searchBloc = SearchBloc<Item>();
///
/// // Quando CrudBloc carregar, sincronizar
/// BlocListener<CrudBloc<Item>, CrudState<Item>>(
///   listener: (context, state) {
///     if (state is CrudLoaded<Item>) {
///       searchBloc.add(UpdateAllEntitiesEvent(state.entities));
///     }
///   },
/// )
///
/// // Buscar
/// searchBloc.add(UpdateSearchQueryEvent('laptop'));
///
/// // Ordenar
/// searchBloc.add(UpdateSortFilterEvent(SortFilter.alphabeticalAZ));
/// ```
class SearchBloc<T> extends Bloc<SearchEvent<T>, SearchState<T>> {

  SearchBloc() : super(const SearchState()) {
    // Pattern matching com sealed classes
    on<SearchEvent<T>>((event, emit) async {
      switch (event) {
        case UpdateSearchQueryEvent():
          await _onUpdateQuery(event, emit);
        case ClearSearchEvent():
          await _onClear(emit);
        case UpdateSortFilterEvent():
          await _onUpdateSortFilter(event, emit);
        case UpdateAllEntitiesEvent():
          await _onUpdateAllEntities(event, emit);
      }
    });
  }

  /// Atualizar query de busca
  Future<void> _onUpdateQuery(
      UpdateSearchQueryEvent<T> event,
      Emitter<SearchState<T>> emit,
      ) async {
    final query = event.query.toLowerCase().trim();

    // Filtrar entidades
    final filtered = _filterEntities(state.allEntities, query);

    // Ordenar resultado
    final sorted = _sortEntities(filtered, state.sortFilter);

    emit(state.copyWith(
      query: query,
      filteredEntities: sorted,
    ));
  }

  /// Limpar busca (restaurar lista completa ordenada)
  Future<void> _onClear(Emitter<SearchState<T>> emit) async {
    final sorted = _sortEntities(state.allEntities, state.sortFilter);

    emit(state.copyWith(
      query: '',
      filteredEntities: sorted,
    ));
  }

  /// Atualizar filtro de ordenação
  Future<void> _onUpdateSortFilter(
      UpdateSortFilterEvent<T> event,
      Emitter<SearchState<T>> emit,
      ) async {
    // Re-ordenar as entidades filtradas atuais
    final sorted = _sortEntities(state.filteredEntities, event.filter);

    emit(state.copyWith(
      sortFilter: event.filter,
      filteredEntities: sorted,
    ));
  }

  /// Atualizar lista completa de entidades
  ///
  /// CHAMADO quando CrudBloc emite CrudLoaded
  Future<void> _onUpdateAllEntities(
      UpdateAllEntitiesEvent<T> event,
      Emitter<SearchState<T>> emit,
      ) async {
    // Se há busca ativa, aplicar filtro
    final filtered = state.query.isEmpty
        ? event.entities
        : _filterEntities(event.entities, state.query);

    // Aplicar ordenação
    final sorted = _sortEntities(filtered, state.sortFilter);

    emit(state.copyWith(
      allEntities: event.entities,
      filteredEntities: sorted,
    ));
  }

  /// Filtrar entidades por query
  ///
  /// Usa displayTitle e displayDescription (da extension)
  List<T> _filterEntities(List<T> entities, String query) {
    if (query.isEmpty) return entities;

    return entities.where((entity) {
      // IMPORTANTE: entity deve ter displayTitle e displayDescription
      // Item tem via ItemEntityExtension
      // Product terá via ProductEntityExtension
      final dynamic e = entity;

      final titleMatch = (e.displayTitle as String)
          .toLowerCase()
          .contains(query);

      final descMatch = (e.displayDescription as String?)
          ?.toLowerCase()
          .contains(query) ?? false;

      return titleMatch || descMatch;
    }).toList();
  }

  /// Ordenar entidades conforme filtro
  ///
  /// Usa entityCreatedAt e displayTitle
  List<T> _sortEntities(List<T> entities, SortFilter filter) {
    final sorted = List<T>.from(entities);

    switch (filter) {
      case SortFilter.recentFirst:
        sorted.sort((a, b) {
          final dynamic aEntity = a;
          final dynamic bEntity = b;
          return (bEntity.entityCreatedAt as DateTime)
              .compareTo(aEntity.entityCreatedAt as DateTime);
        });

      case SortFilter.oldestFirst:
        sorted.sort((a, b) {
          final dynamic aEntity = a;
          final dynamic bEntity = b;
          return (aEntity.entityCreatedAt as DateTime)
              .compareTo(bEntity.entityCreatedAt as DateTime);
        });

      case SortFilter.alphabeticalAZ:
        sorted.sort((a, b) {
          final dynamic aEntity = a;
          final dynamic bEntity = b;
          return (aEntity.displayTitle as String)
              .toLowerCase()
              .compareTo((bEntity.displayTitle as String).toLowerCase());
        });

      case SortFilter.alphabeticalZA:
        sorted.sort((a, b) {
          final dynamic aEntity = a;
          final dynamic bEntity = b;
          return (bEntity.displayTitle as String)
              .toLowerCase()
              .compareTo((aEntity.displayTitle as String).toLowerCase());
        });
    }

    return sorted;
  }
}