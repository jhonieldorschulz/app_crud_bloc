import 'package:app_crud_bloc/core/base/crud_bloc.dart';
import 'package:app_crud_bloc/core/base/crud_state.dart';
import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/crud_event.dart';
import '../../../core/routing/route_names.dart';
import '../../../data/database/app_database.dart';
import '../../../data/model/product/product_extensions.dart';
import '../../../logic/product/product_list_cubit.dart';
import '../../../logic/product/product_list_state.dart';
import '../widgets/app_navigation_drawer.dart';

/// ProductListScreen - Tela de listagem de produtos
///
/// Features:
/// - Lista todos os produtos
/// - Busca por nome, descrição ou categoria
/// - Navegação para detalhes
/// - Criação de novos produtos
/// - Indicadores de estoque (cores)
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (context) => ProductListCubit(),
      child: const _ProductListView(),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrudBloc<Product>, CrudState<Product>>(
      listener: (context, state) {
        // Sincroniza produtos do CrudBloc com ProductListCubit
        if (state is CrudLoaded<Product>) {
          context.read<ProductListCubit>().setProducts(state.entities);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(AppLocalizations.of(context)!.products),
          actions: [
            // Botão de deletar todos
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _showDeleteAllDialog(context),
              tooltip: AppLocalizations.of(context)!.deleteAll,
            ),
          ],
        ),
        drawer: AppNavigationDrawer(currentRoute: RouteNames.products),
        body: Column(
          children: [
            // Barra de busca
            _SearchBar(),
            const SizedBox(height: 8),
            // Lista de produtos
            Expanded(child: _ProductListBody()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(RouteNames.productCreate),
          child: const Icon(Icons.add),
          tooltip: AppLocalizations.of(context)!.createProduct,
        ),
      ),
    );
  }

  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteAll),
        content: Text(AppLocalizations.of(context)!.deleteAllConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CrudBloc<Product>>().add(
                const DeleteAllEvent<Product>(),
              );
              Navigator.of(dialogContext).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }
}

/// Barra de busca
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        if (state is! ProductListLoaded) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchProducts,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: state.isSearching
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  context.read<ProductListCubit>().clearSearch();
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              context.read<ProductListCubit>().search(value);
            },
          ),
        );
      },
    );
  }
}

/// Corpo da lista
class _ProductListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc<Product>, CrudState<Product>>(
      builder: (context, crudState) {
        // Loading
        if (crudState is CrudLoading<Product>) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (crudState is CrudError<Product>) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.error,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(crudState.message),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CrudBloc<Product>>().add(
                      const LoadAllEvent<Product>(),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(AppLocalizations.of(context)!.retry),
                ),
              ],
            ),
          );
        }

        // Lista carregada - usar ProductListCubit
        return BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, listState) {
            if (listState is! ProductListLoaded) {
              return const SizedBox.shrink();
            }

            // Lista vazia
            if (listState.isEmpty) {
              return _EmptyState();
            }

            // Busca sem resultados
            if (listState.hasNoResults) {
              return _NoResultsState(searchText: listState.searchText);
            }

            // Lista com produtos
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listState.visibleProducts.length,
              itemBuilder: (context, index) {
                final product = listState.visibleProducts[index];
                return _ProductCard(product: product);
              },
            );
          },
        );
      },
    );
  }
}

/// Card de produto
class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getStockColor(),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => context.push(RouteNames.productDetailPath(product.id)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome e preço
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    product.formattedPrice,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Descrição
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Categoria e estoque
              Row(
                children: [
                  // Categoria
                  Chip(
                    label: Text(product.category),
                    avatar: const Icon(Icons.category, size: 16),
                    backgroundColor: Colors.blue[50],
                    labelStyle: TextStyle(color: Colors.blue[900]),
                  ),
                  const Spacer(),

                  // Status de estoque
                  _StockChip(product: product),
                ],
              ),

              // Status ativo/inativo
              if (!product.isActive) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.block, size: 16, color: Colors.red[900]),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context)!.inactive,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStockColor() {
    if (product.isOutOfStock) return Colors.red;
    if (product.isLowStock) return Colors.orange;
    return Colors.green;
  }
}

/// Chip de estoque
class _StockChip extends StatelessWidget {
  final Product product;

  const _StockChip({required this.product});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('${product.stock} un'),
      avatar: Icon(_getStockIcon(), size: 16),
      backgroundColor: _getStockColor().withOpacity(0.1),
      labelStyle: TextStyle(
        color: _getStockColor(),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  IconData _getStockIcon() {
    if (product.isOutOfStock) return Icons.error;
    if (product.isLowStock) return Icons.warning;
    return Icons.check_circle;
  }

  Color _getStockColor() {
    if (product.isOutOfStock) return Colors.red;
    if (product.isLowStock) return Colors.orange;
    return Colors.green;
  }
}

/// Estado vazio
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 120,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noProducts,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.createFirstProduct,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Estado sem resultados
class _NoResultsState extends StatelessWidget {
  final String searchText;

  const _NoResultsState({required this.searchText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 120,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noResults,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.searchFor}: "$searchText"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}