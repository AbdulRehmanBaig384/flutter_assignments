import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../core/theme/app_theme.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({
    super.key,
    this.product,
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  
  bool get isEditMode => widget.product != null;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(
      text: widget.product != null ? widget.product!.price.toStringAsFixed(2) : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final name = _nameController.text.trim();
    final price = double.parse(_priceController.text.trim());
    final provider = context.read<ProductProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    bool success;
    if (isEditMode) {
      success = await provider.updateProduct(widget.product!.id!, name, price);
    } else {
      success = await provider.addProduct(name, price);
    }

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
    }

    if (success) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            isEditMode
                ? 'Product "$name" updated successfully!'
                : 'Product "$name" created successfully!',
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      navigator.pop();
    } else {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'An error occurred during submission.'),
          backgroundColor: AppTheme.deleteColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildInfoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.infoBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppTheme.infoText,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.infoText,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(isEditMode ? 'Edit Product' : 'Add Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CATALOG MANAGEMENT',
                    style: TextStyle(
                      color: AppTheme.textMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    isEditMode ? 'Modify Product' : 'Define New Product',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditMode ? 'PRODUCT NAME' : 'Product Name',
                          style: TextStyle(
                            color: isEditMode ? AppTheme.primaryColor : AppTheme.textMedium,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: isEditMode ? 0.8 : 0.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          enabled: !_isSubmitting,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Enterprise Cloud Module',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a product name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        Text(
                          isEditMode ? 'PRICE' : 'Price',
                          style: TextStyle(
                            color: isEditMode ? AppTheme.primaryColor : AppTheme.textMedium,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: isEditMode ? 0.8 : 0.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _priceController,
                          enabled: !_isSubmitting,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: '\$ 0.00',
                            prefixText: '\$ ',
                            prefixStyle: const TextStyle(
                              color: AppTheme.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a price';
                            }
                            final cleanValue = value.replaceAll('\$', '').trim();
                            final parsed = double.tryParse(cleanValue);
                            if (parsed == null) {
                              return 'Please enter a valid number';
                            }
                            if (parsed < 0) {
                              return 'Price cannot be negative';
                            }
                            return null;
                          },
                        ),
                        
                        if (!isEditMode) ...[
                          const SizedBox(height: 24),
                          _buildInfoBox(
                            'Ensure product pricing aligns with current regional tax regulations and platform fees.',
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(isEditMode ? 'Save Changes' : 'Save Product'),
                  ),
                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                    ),
                    child: const Text('Cancel'),
                  ),
                  
                  if (isEditMode) ...[
                    const SizedBox(height: 24),
                    _buildInfoBox(
                      'Updating product details will synchronize changes across all active inventory dashboards and analytics reports instantly.',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
