import 'package:app_crud_bloc/presentation/screens/widgets/app_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/crud_bloc.dart';
import '../../../core/base/crud_event.dart';
import '../../../core/base/crud_state.dart';
import '../../../core/base/search_bloc.dart';
import '../../../core/base/search_event.dart';
import '../../../core/base/search_state.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_localizations.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar com menu
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: 'Menu',
          ),
        ),
        title: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppTheme.space8),
                Text(l10n.itemList),
              ],
            );
          },
        ),
        actions: [
          // ✅ Settings button
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.push(RouteNames.settings),
                tooltip: l10n.settings,
              );
            },
          ),
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () => _showDeleteAllDialog(context),
                tooltip: l10n.deleteAll,
              );
            },
          ),
        ],
      ),

      // ✅ Drawer (Menu lateral)
      drawer: AppNavigationDrawer(
        currentRoute: RouteNames.items,
      ),

      // Body com busca funcional
      body: BlocListener<CrudBloc<Item>, CrudState<Item>>(
        listener: (context, state) {
          // Sincronizar SearchBloc quando CrudBloc carregar dados
          if (state is CrudLoaded<Item>) {
            context.read<SearchBloc<Item>>().add(
              UpdateAllEntitiesEvent<Item>(state.entities),
            );
          }
        },
        child: Column(
          children: [
            const _SearchBar(),
            const _FilterChips(),
            Expanded(
              child: BlocBuilder<CrudBloc<Item>, CrudState<Item>>(
                builder: (context, crudState) {
                  if (crudState is CrudLoading<Item>) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (crudState is CrudLoaded<Item>) {
                    // Garantir que SearchBloc tenha os dados mesmo se não foi sincronizado ainda
                    final searchBloc = context.read<SearchBloc<Item>>();
                    if (searchBloc.state.allEntities.isEmpty && crudState.entities.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        searchBloc.add(UpdateAllEntitiesEvent<Item>(crudState.entities));
                      });
                    }

                    // Usar SearchBloc para obter itens filtrados
                    return BlocBuilder<SearchBloc<Item>, SearchState<Item>>(
                      builder: (context, searchState) {
                        // Se SearchBloc ainda não tem dados, usar do CrudBloc temporariamente
                        final items = searchState.filteredEntities.isNotEmpty
                            ? searchState.filteredEntities
                            : (searchState.isSearching ? [] : crudState.entities);

                        final l10n = AppLocalizations.of(context)!;
                        
                        // Estado: lista vazia (sem busca)
                        if (items.isEmpty && !searchState.isSearching) {
                          return Center(
                            child: Text(l10n.tapToAddFirst),
                          );
                        }

                        // Estado: busca sem resultados
                        if (searchState.hasNoResults) {
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
                                  l10n.retry,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.grey600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Estado: mostrar resultados filtrados
                        return ListView.builder(
                          padding: const EdgeInsets.all(AppTheme.space8),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return _ItemCard(item: item);
                          },
                        );
                      },
                    );
                  }

                  return const Center(child: Text('Something went wrong'));
                },
              ),
            ),
          ],
        ),
      ),

      // ✅ FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.itemCreate), // ✅ CORRETO
        child: const Icon(Icons.add),
      ),
    );
  }

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
}

// Widgets _SearchBar e _FilterChips (manter existentes)
class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SearchBloc<Item>, SearchState<Item>>(
      builder: (context, state) {
        // Sincronizar controller com o estado da busca
        if (_controller.text != state.query) {
          _controller.text = state.query;
        }

        return Padding(
          padding: const EdgeInsets.all(AppTheme.space16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.itemList, // Usar tradução
              prefixIcon: const Icon(Icons.search),
              suffixIcon: state.isSearching
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        context.read<SearchBloc<Item>>().add(
                          const ClearSearchEvent<Item>(),
                        );
                      },
                      tooltip: l10n.cancel,
                    )
                  : null,
            ),
            onChanged: (value) {
              // Disparar evento de busca conforme digita
              context.read<SearchBloc<Item>>().add(
                UpdateSearchQueryEvent<Item>(value),
              );
            },
          ),
        );
      },
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // Implementar filtros
  }
}

/// Card de item com ações (Visualizar, Editar, Deletar)
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
      child: InkWell(
        onTap: () => context.push(RouteNames.itemDetailPath(item.id!)),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título e ações
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ícone do item
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.itemsColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: AppTheme.itemsColor,
                      size: AppTheme.iconSizeMedium,
                    ),
                  ),
                  const SizedBox(width: AppTheme.space12),
                  
                  // Título e descrição
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppTheme.space4),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.grey600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Menu de ações
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) => _handleAction(context, value),
                    itemBuilder: (context) {
                      final l10n = AppLocalizations.of(context)!;
                      return [
                        PopupMenuItem(
                          value: 'view',
                          child: Row(
                            children: [
                              const Icon(Icons.visibility_outlined, size: 20),
                              const SizedBox(width: AppTheme.space8),
                              Text(l10n.view),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              const Icon(Icons.edit_outlined, size: 20),
                              const SizedBox(width: AppTheme.space8),
                              Text(l10n.edit),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline, size: 20, color: AppTheme.errorColor),
                              const SizedBox(width: AppTheme.space8),
                              Text(l10n.delete, style: const TextStyle(color: AppTheme.errorColor)),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.space12),
              
              // Data de criação
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: AppTheme.iconSizeSmall,
                    color: AppTheme.grey500,
                  ),
                  const SizedBox(width: AppTheme.space4),
                  Text(
                    _formatDate(item.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}