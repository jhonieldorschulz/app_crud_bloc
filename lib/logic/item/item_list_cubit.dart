import 'package:bloc/bloc.dart';
import '../../data/database/app_database.dart';
import 'item_list_state.dart';

/// ItemListCubit - Gerencia estado visual da lista
///
/// Responsabilidades:
/// - Receber items do CrudBloc (setItems)
/// - Filtrar items localmente (search)
/// - Manter estado da busca
class ItemListCubit extends Cubit<ItemListState> {
  ItemListCubit() : super(ItemListInitial());

  /// Recebe a lista SEMPRE vinda do CrudBloc
  void setItems(List<Item> items) {
    if (state is ItemListLoaded) {
      final current = state as ItemListLoaded;
      final filtered = _applyFilter(items, current.searchText);

      emit(
        current.copyWith(
          allItems: items,
          visibleItems: filtered,
        ),
      );
    } else {
      emit(
        ItemListLoaded(
          allItems: items,
          visibleItems: items,
          searchText: '',
        ),
      );
    }
  }

  /// Atualiza apenas o estado visual (busca)
  void search(String text) {
    if (state is! ItemListLoaded) return;

    final current = state as ItemListLoaded;
    final filtered = _applyFilter(current.allItems, text);

    emit(
      current.copyWith(
        searchText: text,
        visibleItems: filtered,
      ),
    );
  }

  /// Limpa a busca (volta para lista completa)
  void clearSearch() {
    if (state is! ItemListLoaded) return;

    final current = state as ItemListLoaded;

    emit(
      current.copyWith(
        searchText: '',
        visibleItems: current.allItems,
      ),
    );
  }

  /// Filtro local simples
  List<Item> _applyFilter(List<Item> items, String text) {
    if (text.isEmpty) return items;

    final lower = text.toLowerCase();

    return items.where((item) {
      return item.title.toLowerCase().contains(lower) ||
          item.description.toLowerCase().contains(lower);
    }).toList();
  }
}