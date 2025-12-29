import 'package:bloc/bloc.dart';
import '../../data/database/app_database.dart';
import 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  void setProducts(List<Product> products) {
    if (state is ProductListLoaded) {
      final current = state as ProductListLoaded;
      final filtered = _applyFilter(products, current.searchText);
      emit(current.copyWith(
        allProducts: products,
        visibleProducts: filtered,
      ));
    } else {
      emit(ProductListLoaded(
        allProducts: products,
        visibleProducts: products,
        searchText: '',
      ));
    }
  }

  void search(String text) {
    if (state is! ProductListLoaded) return;
    final current = state as ProductListLoaded;
    final filtered = _applyFilter(current.allProducts, text);
    emit(current.copyWith(
      searchText: text,
      visibleProducts: filtered,
    ));
  }

  void clearSearch() {
    if (state is! ProductListLoaded) return;
    final current = state as ProductListLoaded;
    emit(current.copyWith(
      searchText: '',
      visibleProducts: current.allProducts,
    ));
  }

  List<Product> _applyFilter(List<Product> products, String text) {
    if (text.isEmpty) return products;
    final lower = text.toLowerCase();
    return products.where((product) {
      return product.name.toLowerCase().contains(lower) ||
          product.description.toLowerCase().contains(lower) ||
          product.category.toLowerCase().contains(lower);
    }).toList();
  }
}