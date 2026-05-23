import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../models/product.dart';
import '../product_form/product_form_screen.dart';
import 'widgets/product_card.dart';
import 'widgets/loading_state.dart';
import 'widgets/empty_state.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  void _navigateToAddProduct(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProductFormScreen(),
      ),
    );
  }

  void _navigateToEditProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductFormScreen(product: product),
      ),
    );
  }

  Future<void> _confirmDelete(Product product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delete Product',
            style: Theme.of(dialogContext).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textDark,
                ),
          ),
          content: Text(
            'Are you sure you want to delete "${product.name}"? This action cannot be undone.',
            style: Theme.of(dialogContext).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textMedium,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.textMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.deleteColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      final provider = context.read<ProductProvider>();
      final success = await provider.deleteProduct(product.id!);
      
      if (!mounted) return;
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} deleted successfully!'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to delete product.'),
            backgroundColor: AppTheme.deleteColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload Catalog',
            onPressed: () => context.read<ProductProvider>().fetchProducts(),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.products.isEmpty) {
            return const LoadingState();
          }

          if (provider.hasError && provider.products.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppTheme.deleteColor,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Connection Error',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.textDark,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.errorMessage ?? 'An error occurred while loading products.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textMedium,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () => provider.fetchProducts(),
                        child: const Text('Try Again'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (provider.products.isEmpty) {
            return EmptyState(
              onAddProduct: () => _navigateToAddProduct(context),
            );
          }

          return RefreshIndicator(
            color: AppTheme.primaryColor,
            backgroundColor: Colors.white,
            onRefresh: () => provider.fetchProducts(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ProductCard(
                  product: product,
                  onEdit: () => _navigateToEditProduct(context, product),
                  onDelete: () => _confirmDelete(product),
                );
              },
            ),
          );
        },
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, right: 4.0),
        child: FloatingActionButton.extended(
          onPressed: () => _navigateToAddProduct(context),
          elevation: 4,
          icon: const Icon(Icons.add, size: 20),
          label: const Text(
            'ADD PRODUCT',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
