// ============================================================================
// product_detail_screen.dart
// Caminho: lib/presentation/screens/product/product_detail_screen.dart
// ============================================================================

import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/routing/route_names.dart';
import '../../../data/database/app_database.dart';
import '../../../data/model/product/product_extensions.dart';
import '../../../core/base/crud_bloc.dart';
import '../../../core/base/crud_state.dart';
import '../../../core/base/crud_event.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    // Carregar produto ao abrir a tela
    context.read<CrudBloc<Product>>().add(LoadByIdEvent<Product>(id: productId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.productDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push(RouteNames.productEditPath(productId));
            },
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context),
            tooltip: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      body: BlocConsumer<CrudBloc<Product>, CrudState<Product>>(
        listener: (context, state) {
          // ✅ CORRETO: Usa CrudOperationSuccess (não CrudDeleted)
          if (state is CrudOperationSuccess<Product>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.productDeleted),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          }

          if (state is CrudError<Product>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CrudLoading<Product>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CrudError<Product>) {
            return _ErrorState(message: state.message);
          }

          // ✅ CORRETO: Usa CrudDetailLoaded (não CrudLoadedById)
          if (state is CrudDetailLoaded<Product>) {
            final product = state.entity;
            return _ProductDetailBody(product: product);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteProduct),
        content: Text(AppLocalizations.of(context)!.deleteProductConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CrudBloc<Product>>().add(
                DeleteEvent<Product>(id: productId),
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

class _ProductDetailBody extends StatelessWidget {
  final Product product;

  const _ProductDetailBody({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PriceHeader(product: product),
          const SizedBox(height: 24),

          _SectionTitle(title: AppLocalizations.of(context)!.generalInfo),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              _DetailRow(
                icon: Icons.label,
                label: AppLocalizations.of(context)!.name,
                value: product.name,
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.description,
                label: AppLocalizations.of(context)!.description,
                value: product.description,
                maxLines: null,
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.category,
                label: AppLocalizations.of(context)!.category,
                value: product.category,
              ),
            ],
          ),
          const SizedBox(height: 24),

          _SectionTitle(title: AppLocalizations.of(context)!.stockAndPrice),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              _DetailRow(
                icon: Icons.inventory,
                label: AppLocalizations.of(context)!.stock,
                value: '${product.stock} ${AppLocalizations.of(context)!.units}',
                valueColor: _getStockColor(product),
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.info_outline,
                label: AppLocalizations.of(context)!.productStatus,
                value: product.stockStatus,
                valueColor: _getStockColor(product),
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.attach_money,
                label: AppLocalizations.of(context)!.unitPrice,
                value: product.formattedPrice,
                valueColor: Theme.of(context).primaryColor,
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.calculate,
                label: AppLocalizations.of(context)!.totalStockValue,
                value: product.formattedTotalStockValue,
                valueColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 24),

          _SectionTitle(title: AppLocalizations.of(context)!.additionalInfo),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              if (product.barcode != null) ...[
                _DetailRow(
                  icon: Icons.qr_code,
                  label: AppLocalizations.of(context)!.barcode,
                  value: product.barcode!,
                ),
                const Divider(height: 24),
              ],
              _DetailRow(
                icon: product.isActive ? Icons.check_circle : Icons.block,
                label: AppLocalizations.of(context)!.productStatus,
                value: product.isActive
                    ? AppLocalizations.of(context)!.active
                    : AppLocalizations.of(context)!.inactive,
                valueColor: product.isActive ? Colors.green : Colors.red,
              ),
              const Divider(height: 24),
              _DetailRow(
                icon: Icons.calendar_today,
                label: AppLocalizations.of(context)!.createdAt,
                value: _formatDate(product.createdAt),
              ),
              if (product.updatedAt != null) ...[
                const Divider(height: 24),
                _DetailRow(
                  icon: Icons.update,
                  label: AppLocalizations.of(context)!.updatedAt,
                  value: _formatDate(product.updatedAt!),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),

          if (product.needsRestocking) _RestockingAlert(product: product),
        ],
      ),
    );
  }

  Color _getStockColor(Product product) {
    if (product.isOutOfStock) return Colors.red;
    if (product.isLowStock) return Colors.orange;
    return Colors.green;
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}

class _PriceHeader extends StatelessWidget {
  final Product product;

  const _PriceHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.price,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final int? maxLines;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: maxLines,
                overflow: maxLines != null ? TextOverflow.ellipsis : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RestockingAlert extends StatelessWidget {
  final Product product;

  const _RestockingAlert({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Row(
        children: [
          Icon(
            product.isOutOfStock ? Icons.error : Icons.warning,
            color: product.isOutOfStock ? Colors.red : Colors.orange,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.isOutOfStock
                      ? AppLocalizations.of(context)!.outOfStock
                      : AppLocalizations.of(context)!.lowStock,
                  style: TextStyle(
                    color: product.isOutOfStock ? Colors.red : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.restockingRecommended,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;

  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
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
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: Text(AppLocalizations.of(context)!.back),
          ),
        ],
      ),
    );
  }
}