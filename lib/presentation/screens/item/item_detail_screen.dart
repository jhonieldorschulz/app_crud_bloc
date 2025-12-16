import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/routing/route_names.dart';
import '../../../logic/item/item_bloc.dart';
import '../../../logic/item/item_event.dart';
import '../../../logic/item/item_state.dart';

class ItemDetailScreen extends StatefulWidget {
  final int itemId;

  const ItemDetailScreen({super.key, required this.itemId});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(LoadItemDetailEvent(id: widget.itemId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.itemDetails),
      ),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            context.go(RouteNames.home);
          } else if (state is ItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ItemDetailLoaded) {
            final item = state.item;
            final dateFormat = DateFormat.yMMMMd(Localizations.localeOf(context).toString()).add_Hm();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.title, style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(height: 8),
                          Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
                          const Divider(height: 24),
                          Text(l10n.description, style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(height: 8),
                          Text(item.description, style: const TextStyle(fontSize: 16)),
                          const Divider(height: 24),
                          Row(
                            children: [
                              Icon(Icons.schedule, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Text('${l10n.createdAt} ${dateFormat.format(item.createdAt)}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => context.push(RouteNames.itemEditPath(widget.itemId)),
                          icon: const Icon(Icons.edit),
                          label: Text(l10n.edit),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _showDeleteDialog(context),
                          icon: const Icon(Icons.delete),
                          label: Text(l10n.delete),
                          style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          if (state is ItemError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 80, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text(l10n.confirmDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<ItemBloc>().add(DeleteItemEvent(id: widget.itemId));
              Navigator.pop(dialogContext);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}