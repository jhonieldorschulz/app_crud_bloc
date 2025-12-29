import 'package:app_crud_bloc/data/model/item/item_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/crud_bloc.dart';
import '../../../core/base/crud_event.dart';
import '../../../core/base/crud_state.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_localizations.dart';

/// ItemDetailScreen - Tela de detalhes do item
///
/// Features:
/// - Visualização completa dos dados
/// - Metadata card (ID, Created, Updated)
/// - Botões de ação (Edit, Delete)
/// - Hero animation do avatar
/// - Loading e error states
class ItemDetailScreen extends StatefulWidget {
  final int itemId;

  const ItemDetailScreen({
    super.key,
    required this.itemId,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    // Carregar item após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasLoaded) {
        _hasLoaded = true;
        _loadItem();
      }
    });
  }

  void _loadItem() {
    if (!mounted) return;
    context.read<CrudBloc<Item>>().add(
      LoadByIdEvent<Item>(id: widget.itemId),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usar o BlocProvider do contexto pai (do main.dart)
    return BlocConsumer<CrudBloc<Item>, CrudState<Item>>(
        listener: (context, state) {
          if (state is CrudOperationSuccess<Item>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.successColor,
              ),
            );
            Navigator.pop(context, true);
          }

          if (state is CrudError<Item>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(context, state),
            body: _buildBody(context, state),
            floatingActionButton: state is CrudDetailLoaded<Item>
                ? FloatingActionButton(
              onPressed: () => _navigateToEdit(context, state.entity),
              child: const Icon(Icons.edit),
            )
                : null,
          );
        },
      );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, CrudState<Item> state) {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(
        state is CrudDetailLoaded<Item>
            ? state.entity.displayTitle
            : l10n.itemDetails,
      ),
      actions: state is CrudDetailLoaded<Item>
          ? [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _navigateToEdit(context, state.entity),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteDialog(context, state.entity),
        ),
      ]
          : null,
    );
  }

  Widget _buildBody(BuildContext context, CrudState<Item> state) {
    if (state is CrudLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CrudError<Item>) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppTheme.iconSizeExtraLarge * 2,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: AppTheme.space16),
            Text(l10n.itemDetails, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppTheme.space8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingLarge),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.grey600),
              ),
            ),
            const SizedBox(height: AppTheme.space24),
            ElevatedButton.icon(
              onPressed: _loadItem,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (state is CrudDetailLoaded<Item>) {
      final item = state.entity;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        child: Column(
          children: [
            _buildHeroHeader(context, item),
            const SizedBox(height: AppTheme.space24),
            _buildInfoCard(context, item),
            const SizedBox(height: AppTheme.space16),
            _buildMetadataCard(context, item),
            const SizedBox(height: AppTheme.space24),
            _buildActionButtons(context, item),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildHeroHeader(BuildContext context, Item item) {
    return Hero(
      tag: 'item_${item.id}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTheme.paddingLarge),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.itemsColor, AppTheme.itemsColor.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: AppTheme.itemsColor.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              ),
              child: const Icon(Icons.inventory_2, size: 64, color: Colors.white),
            ),
            const SizedBox(height: AppTheme.space16),
            Text(
              item.displayTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.space8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.space8,
                vertical: AppTheme.space4,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Text(
                'ID: ${item.id}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, Item item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.itemsColor),
                        const SizedBox(width: AppTheme.space8),
                        Text('Information', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    const Divider(height: AppTheme.space24),
                    _InfoRow(icon: Icons.title, label: l10n.title, value: item.title),
                    const SizedBox(height: AppTheme.space16),
                    _InfoRow(icon: Icons.description, label: l10n.description, value: item.description, maxLines: null),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataCard(BuildContext context, Item item) {
    return Card(
      color: AppTheme.grey100,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics_outlined, color: AppTheme.grey700),
                const SizedBox(width: AppTheme.space8),
                Text('Metadata', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppTheme.space16),
            _MetadataRow(icon: Icons.tag, label: 'ID', value: item.id.toString()),
            const SizedBox(height: AppTheme.space8),
            Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return _MetadataRow(icon: Icons.calendar_today, label: l10n.createdAt, value: _formatDateTime(item.createdAt));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Item item) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _navigateToEdit(context, item),
            icon: const Icon(Icons.edit),
            label: Text(l10n.editItem),
          ),
        ),
        const SizedBox(height: AppTheme.space12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _showDeleteDialog(context, item),
            icon: const Icon(Icons.delete),
            label: Text(l10n.delete),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
              side: const BorderSide(color: AppTheme.errorColor),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToEdit(BuildContext context, Item item) {
    context.push(RouteNames.itemEditPath(item.id!)).then((result) {
      if (result == true && mounted) {
        _loadItem();
      }
    });
  }

  void _showDeleteDialog(BuildContext context, Item item) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text('${l10n.confirmDeleteMessage}\n\n"${item.displayTitle}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CrudBloc<Item>>().add(DeleteEvent<Item>(id: item.id!));
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final int? maxLines;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppTheme.grey500),
        const SizedBox(width: AppTheme.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.grey600)),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyMedium, maxLines: maxLines),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetadataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetadataRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.grey600),
        const SizedBox(width: AppTheme.space8),
        Text('$label:', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.grey600)),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}