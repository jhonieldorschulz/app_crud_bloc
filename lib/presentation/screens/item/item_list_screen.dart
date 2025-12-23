import 'package:app_crud_bloc/presentation/screens/widgets/app_navigation_drawer.dart';
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
import '../../../logic/item/item_list_cubit.dart';
import '../../../logic/item/item_list_state.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemListCubit>(
      create: (_) => ItemListCubit(),
      child: const _ItemListView(),
    );
  }
}

/// 🔁 Escuta o CrudBloc e sincroniza a listagem
class _ItemListView extends StatelessWidget {
  const _ItemListView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrudBloc<Item>, CrudState<Item>>(
      listener: (context, state) {
        if (state is CrudLoaded<Item>) {
          context.read<ItemListCubit>().setItems(state.entities);
        }
      },
      child: const _Scaffold(),
    );
  }
}

/// 🧱 Estrutura visual
class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.description_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppTheme.space8),
            Text(l10n.itemList),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(RouteNames.settings),
            tooltip: l10n.settings,
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _showDeleteAllDialog(context),
            tooltip: l10n.deleteAll,
          ),
        ],
      ),
      drawer: AppNavigationDrawer(currentRoute: RouteNames.items),
      body: Column(
        children: const [
          _SearchBar(),
          Expanded(child: _ItemListBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.itemCreate),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 🔍 Busca simples (estado visual)
class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ItemListCubit, ItemListState>(
      builder: (context, state) {
        final isSearching = state is ItemListLoaded && state.isSearching;

        return Padding(
          padding: const EdgeInsets.all(AppTheme.space16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.search,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: isSearching
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  context.read<ItemListCubit>().clearSearch();
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              context.read<ItemListCubit>().search(value);
            },
          ),
        );
      },
    );
  }
}

/// 📋 Corpo da listagem
class _ItemListBody extends StatelessWidget {
  const _ItemListBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ItemListCubit, ItemListState>(
      builder: (context, state) {
        if (state is ItemListInitial || state is ItemListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ItemListLoaded) {
          // Lista vazia (sem items cadastrados)
          if (state.isEmpty) {
            return Center(child: Text(l10n.tapToAddFirst));
          }

          // Busca sem resultados
          if (state.hasNoResults) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: AppTheme.grey400,
                  ),
                  const SizedBox(height: AppTheme.space16),
                  Text(
                    l10n.noItemsFound,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTheme.space8),
                  Text(
                    'Busca: "${state.searchText}"',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          // Mostrar lista
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.space8),
            itemCount: state.visibleItems.length,
            itemBuilder: (context, index) {
              final item = state.visibleItems[index];
              return _ItemCard(item: item);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

/// 📇 Card do item (simplificado)
class _ItemCard extends StatelessWidget {
  final Item item;

  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.space8,
        vertical: AppTheme.space4,
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.itemsColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(
            Icons.description_outlined,
            color: AppTheme.itemsColor,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleAction(context, value),
          itemBuilder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return [
              PopupMenuItem(
                value: 'view',
                child: Row(
                  children: [
                    const Icon(Icons.visibility_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(l10n.view),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(l10n.edit),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline, size: 20,
                        color: AppTheme.errorColor),
                    const SizedBox(width: 8),
                    Text(l10n.delete,
                        style: const TextStyle(color: AppTheme.errorColor)),
                  ],
                ),
              ),
            ];
          },
        ),
        onTap: () => context.push(RouteNames.itemDetailPath(item.id!)),
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'view':
        context.push(RouteNames.itemDetailPath(item.id!));
        break;
      case 'edit':
        context.push(RouteNames.itemEditPath(item.id!));
        break;
      case 'delete':
        _showDeleteDialog(context);
        break;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text('${l10n.confirmDeleteMessage}\n\n"${item.title}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CrudBloc<Item>>().add(
                DeleteEvent<Item>(id: item.id!),
              );
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

/// ⚠️ Dialog de exclusão total
void _showDeleteAllDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.confirmDeleteAllTitle),
      content: Text(l10n.confirmDeleteAllMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            context.read<CrudBloc<Item>>().add(
              const DeleteAllEvent<Item>(),
            );
            Navigator.pop(dialogContext);
          },
          style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
          child: Text(l10n.deleteAll),
        ),
      ],
    ),
  );
}