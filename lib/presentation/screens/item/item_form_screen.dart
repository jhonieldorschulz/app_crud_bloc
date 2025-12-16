import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/routing/route_names.dart';
import '../../../l10n/app_localizations.dart';
import '../../../logic/item/item_bloc.dart';
import '../../../logic/item/item_event.dart';
import '../../../logic/item/item_state.dart';

class ItemFormScreen extends StatefulWidget {
  final FormMode mode;
  final int? itemId;

  const ItemFormScreen({super.key, required this.mode, this.itemId});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.mode == FormMode.edit && widget.itemId != null) {
      context.read<ItemBloc>().add(LoadItemDetailEvent(id: widget.itemId!));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.mode == FormMode.edit;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? l10n.editItem : l10n.newItem),
      ),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemDetailLoaded) {
            _titleController.text = state.item.title;
            _descriptionController.text = state.item.description;
            setState(() => _isLoading = false);
          } else if (state is ItemOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            context.go(RouteNames.home);
          } else if (state is ItemError) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is ItemLoading) {
            setState(() => _isLoading = true);
          }
        },
        builder: (context, state) {
          if (isEdit && state is ItemLoading && _titleController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: l10n.title,
                      prefixIcon: const Icon(Icons.title),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.validationTitleRequired;
                      }
                      if (value.trim().length < 3) {
                        return l10n.validationTitleMinLength;
                      }
                      return null;
                    },
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: l10n.description,
                      prefixIcon: const Icon(Icons.description),
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 5,
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
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : _submit,
                      icon: _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Icon(Icons.save),
                      label: Text(isEdit ? l10n.saveChanges : l10n.save),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : () => context.pop(),
                      icon: const Icon(Icons.close),
                      label: Text(l10n.cancel),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (widget.mode == FormMode.create) {
      context.read<ItemBloc>().add(AddItemEvent(title: title, description: description));
    } else {
      final state = context.read<ItemBloc>().state;
      if (state is ItemDetailLoaded) {
        final updated = state.item.copyWith(title: title, description: description);
        context.read<ItemBloc>().add(UpdateItemEvent(item: updated));
      }
    }
  }
}