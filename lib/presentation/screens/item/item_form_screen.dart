import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/crud_bloc.dart';
import '../../../core/base/crud_event.dart';
import '../../../core/base/crud_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_localizations.dart';

/// ItemFormScreen - Tela de formulário para criar/editar item
///
/// Modos:
/// - Create: id == null
/// - Edit: id != null
///
/// Features:
/// - Validação de campos
/// - Auto-fill em modo edit
/// - Loading state
/// - Error handling
/// - Success feedback
class ItemFormScreen extends StatefulWidget {
  final int? itemId; // null = create, int = edit

  const ItemFormScreen({
    super.key,
    this.itemId,
  });

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;
  Item? _currentItem;
  bool _hasLoaded = false;

  bool get _isEditMode => widget.itemId != null;

  @override
  void initState() {
    super.initState();
    // Carregar item em modo edit após o primeiro frame
    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_hasLoaded) {
          _hasLoaded = true;
          _loadItem();
        }
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Carregar item em modo edit
  void _loadItem() {
    if (!mounted) return;
    setState(() => _isLoading = true);
    context.read<CrudBloc<Item>>().add(
      LoadByIdEvent<Item>(id: widget.itemId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usar o BlocProvider do contexto pai (do main.dart)
    return BlocConsumer<CrudBloc<Item>, CrudState<Item>>(
        listener: (context, state) {
          // Estado: Item carregado (modo edit)
          if (state is CrudDetailLoaded<Item>) {
            setState(() {
              _currentItem = state.entity;
              _titleController.text = state.entity.title;
              _descriptionController.text = state.entity.description;
              _isLoading = false;
            });
          }

          // Estado: Operação bem-sucedida
          if (state is CrudOperationSuccess<Item>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.successColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context, true); // Retornar true = sucesso
          }

          // Estado: Erro
          if (state is CrudError<Item>) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          // Estado: Loading
          if (state is CrudLoading) {
            setState(() => _isLoading = true);
          }
        },
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          return Scaffold(
            appBar: AppBar(
              title: Text(_isEditMode ? l10n.editItem : l10n.addItem),
              actions: [
                if (_isEditMode)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: l10n.delete,
                    onPressed: () => _showDeleteDialog(context),
                  ),
              ],
            ),
            body: _isLoading && _currentItem == null
                ? const Center(child: CircularProgressIndicator())
                : _buildForm(context),
          );
        },
      );
  }

  Widget _buildForm(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        children: [
          // Header com ícone
          _buildHeader(),

          const SizedBox(height: AppTheme.space24),

          // Campo: Title
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: l10n.title,
              hintText: l10n.title,
              prefixIcon: const Icon(Icons.title),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationTitleRequired;
              }
              if (value.trim().length < 3) {
                return l10n.validationTitleMinLength;
              }
              if (value.length > 200) {
                return l10n.validationTitleMinLength; // Usar tradução similar
              }
              return null;
            },
            enabled: !_isLoading,
          ),

          const SizedBox(height: AppTheme.space16),

          // Campo: Description
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: l10n.description,
              hintText: l10n.description,
              prefixIcon: const Icon(Icons.description),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            minLines: 3,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationDescriptionRequired;
              }
              if (value.trim().length < 10) {
                return l10n.validationDescriptionMinLength;
              }
              return null;
            },
            enabled: !_isLoading,
          ),

          const SizedBox(height: AppTheme.space32),

          // Botões
          _buildButtons(context),

          const SizedBox(height: AppTheme.space16),

          // Dica
          if (!_isEditMode) _buildHint(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.itemsColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: AppTheme.avatarSizeLarge,
            height: AppTheme.avatarSizeLarge,
            decoration: BoxDecoration(
              color: AppTheme.itemsColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            ),
            child: Icon(
              _isEditMode ? Icons.edit : Icons.add_box,
              color: AppTheme.itemsColor,
              size: AppTheme.iconSizeLarge,
            ),
          ),
          const SizedBox(width: AppTheme.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditMode ? 'Edit Item' : 'New Item',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.itemsColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.space4),
                Text(
                  _isEditMode
                      ? 'Update item information'
                      : 'Fill in the details to create a new item',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.grey700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        // Botão Cancel
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ),

        const SizedBox(width: AppTheme.space12),

        // Botão Save/Update
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(_isEditMode ? l10n.saveChanges : l10n.save),
          ),
        ),
      ],
    );
  }

  Widget _buildHint() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.infoColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.infoColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppTheme.infoColor,
            size: AppTheme.iconSizeMedium,
          ),
          const SizedBox(width: AppTheme.space12),
          Expanded(
            child: Text(
              'Items are the basic building blocks of your inventory. '
                  'Make sure to provide clear and descriptive information.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.grey700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
    };

    final bloc = context.read<CrudBloc<Item>>();

    if (_isEditMode) {
      // Update
      final updatedItem = _currentItem!.copyWith(
        title: data['title'],
        description: data['description'],
      );
      bloc.add(UpdateEvent<Item>(entity: updatedItem));
    } else {
      // Create
      bloc.add(CreateEvent<Item>(data: data));
    }
  }

  void _showDeleteDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text(
          '${l10n.confirmDeleteMessage}\n\n"${_currentItem?.title}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CrudBloc<Item>>().add(
                DeleteEvent<Item>(id: widget.itemId!),
              );
              Navigator.pop(dialogContext); // Fechar dialog
              Navigator.pop(context, true); // Voltar para lista
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}