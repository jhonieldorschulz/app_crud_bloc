// ============================================================================
// product_form_screen.dart
// Caminho: lib/presentation/screens/product/product_form_screen.dart
// ============================================================================

import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/database/app_database.dart';
import '../../../core/base/crud_bloc.dart';
import '../../../core/base/crud_state.dart';
import '../../../core/base/crud_event.dart';

class ProductFormScreen extends StatefulWidget {
  final int? productId;

  const ProductFormScreen({
    super.key,
    this.productId,
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _categoryController = TextEditingController();
  final _barcodeController = TextEditingController();

  bool _isActive = true;
  bool _isEditMode = false;
  Product? _currentProduct;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.productId != null;

    if (_isEditMode) {
      context.read<CrudBloc<Product>>().add(
        LoadByIdEvent<Product>(id: widget.productId!),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  void _loadProductData(Product product) {
    _currentProduct = product;
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toStringAsFixed(2);
    _stockController.text = product.stock.toString();
    _categoryController.text = product.category;
    _barcodeController.text = product.barcode ?? '';
    _isActive = product.isActive;
    setState(() {});
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'price': double.parse(_priceController.text.trim()),
      'stock': int.parse(_stockController.text.trim()),
      'category': _categoryController.text.trim(),
      'barcode': _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      'isActive': _isActive,
    };

    if (_isEditMode && _currentProduct != null) {
      // Update
      final updatedProduct = _currentProduct!.copyWith(
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        stock: data['stock'] as int,
        category: data['category'] as String,
        barcode: Value(data['barcode'] as String?),
        isActive: data['isActive'] as bool,
        updatedAt: Value(DateTime.now()),
      );

      context.read<CrudBloc<Product>>().add(
        UpdateEvent<Product>(entity: updatedProduct),
      );
    } else {
      // Create
      context.read<CrudBloc<Product>>().add(
        CreateEvent<Product>(data: data),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? AppLocalizations.of(context)!.editProduct
              : AppLocalizations.of(context)!.createProduct,
        ),
      ),
      body: BlocConsumer<CrudBloc<Product>, CrudState<Product>>(
        listener: (context, state) {
          // ✅ CORRETO: Usa CrudOperationSuccess (não CrudCreated/CrudUpdated)
          if (state is CrudOperationSuccess<Product>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isEditMode
                      ? AppLocalizations.of(context)!.productUpdated
                      : AppLocalizations.of(context)!.productCreated,
                ),
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

          // ✅ CORRETO: Usa CrudDetailLoaded para carregar dados no edit mode
          if (state is CrudDetailLoaded<Product>) {
            _loadProductData(state.entity);
          }
        },
        builder: (context, state) {
          if (state is CrudLoading<Product> && _currentProduct == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildForm(context);
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // General Information Section
            _SectionHeader(
              title: AppLocalizations.of(context)!.generalInfo,
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 16),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                hintText: AppLocalizations.of(context)!.productNameHint,
                prefixIcon: const Icon(Icons.label),
                border: const OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.nameRequired;
                }
                if (value.trim().length < 3) {
                  return AppLocalizations.of(context)!.nameMinLength;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                hintText: AppLocalizations.of(context)!.productDescriptionHint,
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.descriptionRequired;
                }
                if (value.trim().length < 10) {
                  return AppLocalizations.of(context)!.descriptionMinLength;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category Field
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.category,
                hintText: AppLocalizations.of(context)!.categoryHint,
                prefixIcon: const Icon(Icons.category),
                border: const OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.categoryRequired;
                }
                if (value.trim().length < 3) {
                  return AppLocalizations.of(context)!.categoryMinLength;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Stock and Price Section
            _SectionHeader(
              title: AppLocalizations.of(context)!.stockAndPrice,
              icon: Icons.attach_money,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                // Price Field
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.price,
                      prefixIcon: const Icon(Icons.attach_money),
                      border: const OutlineInputBorder(),
                      helperText: AppLocalizations.of(context)!.priceHelper,
                      helperMaxLines: 2,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.priceRequired;
                      }
                      final price = double.tryParse(value.trim());
                      if (price == null || price <= 0) {
                        return AppLocalizations.of(context)!.priceInvalid;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),

                // Stock Field
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.stock,
                      prefixIcon: const Icon(Icons.inventory),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.stockRequired;
                      }
                      final stock = int.tryParse(value.trim());
                      if (stock == null || stock < 0) {
                        return AppLocalizations.of(context)!.stockInvalid;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Additional Information Section
            _SectionHeader(
              title: AppLocalizations.of(context)!.additionalInfo,
              icon: Icons.more_horiz,
            ),
            const SizedBox(height: 16),

            // Barcode Field (Optional)
            TextFormField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: '${AppLocalizations.of(context)!.barcode} (${AppLocalizations.of(context)!.optional})',
                prefixIcon: const Icon(Icons.qr_code),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Active Switch
            Card(
              child: SwitchListTile(
                title: Text(AppLocalizations.of(context)!.productActive),
                subtitle: Text(
                  _isActive
                      ? AppLocalizations.of(context)!.productActiveDescription
                      : AppLocalizations.of(context)!.productInactiveDescription,
                ),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
                secondary: Icon(
                  _isActive ? Icons.check_circle : Icons.block,
                  color: _isActive ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            BlocBuilder<CrudBloc<Product>, CrudState<Product>>(
              builder: (context, state) {
                final isLoading = state is CrudLoading<Product>;

                return ElevatedButton.icon(
                  onPressed: isLoading ? null : _submitForm,
                  icon: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Icon(_isEditMode ? Icons.save : Icons.add),
                  label: Text(
                    _isEditMode
                        ? AppLocalizations.of(context)!.update
                        : AppLocalizations.of(context)!.create,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}