import 'package:equatable/equatable.dart';
import '../../data/database/app_database.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();
  @override
  List<Object?> get props => [];
}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListLoaded extends ProductListState {
  final List<Product> allProducts;
  final List<Product> visibleProducts;
  final String searchText;

  const ProductListLoaded({
    required this.allProducts,
    required this.visibleProducts,
    required this.searchText,
  });

  bool get isEmpty => allProducts.isEmpty;
  bool get hasNoResults => searchText.isNotEmpty && visibleProducts.isEmpty;
  bool get isSearching => searchText.isNotEmpty;

  ProductListLoaded copyWith({
    List<Product>? allProducts,
    List<Product>? visibleProducts,
    String? searchText,
  }) {
    return ProductListLoaded(
      allProducts: allProducts ?? this.allProducts,
      visibleProducts: visibleProducts ?? this.visibleProducts,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [allProducts, visibleProducts, searchText];
}