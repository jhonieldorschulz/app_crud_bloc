import 'package:equatable/equatable.dart';
import '../../data/database/app_database.dart';

/// Estados do ItemListCubit
sealed class ItemListState extends Equatable {
  const ItemListState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
final class ItemListInitial extends ItemListState {}

/// Estado de carregamento
final class ItemListLoading extends ItemListState {}

/// Estado com dados carregados
final class ItemListLoaded extends ItemListState {
  final List<Item> allItems;
  final List<Item> visibleItems;
  final String searchText;

  const ItemListLoaded({
    required this.allItems,
    required this.visibleItems,
    required this.searchText,
  });

  /// Helpers úteis
  bool get isEmpty => allItems.isEmpty;
  bool get hasNoResults => searchText.isNotEmpty && visibleItems.isEmpty;
  bool get isSearching => searchText.isNotEmpty;

  /// CopyWith para facilitar atualizações
  ItemListLoaded copyWith({
    List<Item>? allItems,
    List<Item>? visibleItems,
    String? searchText,
  }) {
    return ItemListLoaded(
      allItems: allItems ?? this.allItems,
      visibleItems: visibleItems ?? this.visibleItems,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [allItems, visibleItems, searchText];
}