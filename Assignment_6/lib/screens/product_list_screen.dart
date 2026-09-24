import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../widgets/cart_sheet.dart';
import '../widgets/category_selector.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/filter_modal_sheet.dart';
import '../widgets/product_card.dart';
import '../widgets/product_detail_sheet.dart';
import '../widgets/search_filter_header.dart';

/// ProductListScreen manages the dynamic product catalog.
///
/// Demonstrates explicit state handling using `setState`:
/// - Search query text filtering (`_onSearchChanged`, `_clearSearch`)
/// - Category filtering via horizontal chips (`_onCategorySelected`)
/// - Sorting (Price, Rating, Featured) and Availability toggle (`_openFilterModal`)
/// - Favorite state toggling (`_toggleFavorite`)
/// - Cart item counter (`_addToCart`)
/// - Resetting all active filters (`_resetAllFilters`)
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Master list of products
  late List<Product> _products;

  // Search state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter & Sort states
  ProductCategory _selectedCategory = ProductCategory.all;
  ProductSortOption _selectedSort = ProductSortOption.featured;
  bool _inStockOnly = false;

  // Cart state (product ID -> CartItem)
  final Map<String, CartItem> _cartItems = {};

  int get _cartItemCount =>
      _cartItems.values.fold(0, (sum, item) => sum + item.quantity);

  @override
  void initState() {
    super.initState();
    _products = List<Product>.from(Product.getSampleProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ======================================================
  // FILTERING & SORTING LOGIC
  // ======================================================

  /// Computes the filtered and sorted product list based on current state.
  List<Product> get _filteredProducts {
    List<Product> results = _products.where((product) {
      // Search matching (name, brand, description, tags)
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.brand.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query) ||
          product.tags.any((tag) => tag.toLowerCase().contains(query));

      // Category matching
      final matchesCategory = _selectedCategory == ProductCategory.all ||
          product.category == _selectedCategory;

      // In-stock availability matching
      final matchesStock = !_inStockOnly || (product.inStock && product.stockQuantity > 0);

      return matchesSearch && matchesCategory && matchesStock;
    }).toList();

    // Sorting
    switch (_selectedSort) {
      case ProductSortOption.featured:
        // Default ordering
        break;
      case ProductSortOption.priceLowToHigh:
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceHighToLow:
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.highestRated:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return results;
  }

  /// Calculates item count per category based on current in-stock and search filters.
  Map<ProductCategory, int> get _categoryCounts {
    final counts = <ProductCategory, int>{
      ProductCategory.all: _products.length,
    };

    for (final category in ProductCategory.values) {
      if (category == ProductCategory.all) continue;
      counts[category] = _products.where((p) => p.category == category).length;
    }

    return counts;
  }

  /// Returns whether non-default filters (sort or in-stock) are currently active.
  bool get _hasActiveFilters =>
      _selectedSort != ProductSortOption.featured || _inStockOnly;

  // ======================================================
  // STATE MUTATION METHODS (Using setState)
  // ======================================================

  /// Handles real-time search query changes.
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  /// Clears the search field and resets query state.
  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  /// Updates active category filter.
  void _onCategorySelected(ProductCategory category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  /// Toggles favorite status of a product by ID.
  void _toggleFavorite(String productId) {
    setState(() {
      final index = _products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        final current = _products[index];
        _products[index] = current.copyWith(isFavorite: !current.isFavorite);
      }
    });

    final updated = _products.firstWhere((p) => p.id == productId);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              updated.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: updated.isFavorite
                  ? AppPalette.favoriteActive
                  : Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                updated.isFavorite
                    ? 'Added "${updated.name}" to favorites'
                    : 'Removed "${updated.name}" from favorites',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: AppPalette.textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Adds product to cart with animated SnackBar and badge update.
  void _addToCart(Product product) {
    setState(() {
      if (_cartItems.containsKey(product.id)) {
        _cartItems[product.id]!.quantity++;
      } else {
        _cartItems[product.id] = CartItem(product: product);
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppPalette.success,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Added "${product.name}" to cart!',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: AppPalette.accent,
          onPressed: _openCartSheet,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: AppPalette.textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Updates item quantity in cart.
  void _updateCartQuantity(String productId, int delta) {
    setState(() {
      if (_cartItems.containsKey(productId)) {
        final newQty = _cartItems[productId]!.quantity + delta;
        if (newQty <= 0) {
          _cartItems.remove(productId);
        } else {
          _cartItems[productId]!.quantity = newQty;
        }
      }
    });
  }

  /// Removes an item completely from the cart.
  void _removeFromCart(String productId) {
    setState(() {
      _cartItems.remove(productId);
    });
  }

  /// Empties all items from the cart.
  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  /// Simulates checkout completion with celebratory feedback.
  void _checkout() {
    final totalAmount =
        _cartItems.values.fold(0.0, (sum, i) => sum + i.subtotal);
    setState(() {
      _cartItems.clear();
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: AppPalette.success, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Order placed successfully! Total: \$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppPalette.textPrimary,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Opens the interactive Cart bottom sheet.
  void _openCartSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (sheetContext, setModalState) {
          return CartSheet(
            items: _cartItems.values.toList(),
            onUpdateQuantity: (productId, delta) {
              _updateCartQuantity(productId, delta);
              setModalState(() {});
            },
            onRemoveItem: (productId) {
              _removeFromCart(productId);
              setModalState(() {});
            },
            onClearCart: () {
              _clearCart();
              setModalState(() {});
            },
            onCheckout: _checkout,
          );
        },
      ),
    );
  }

  /// Resets all search, category, and sorting filters.
  void _resetAllFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedCategory = ProductCategory.all;
      _selectedSort = ProductSortOption.featured;
      _inStockOnly = false;
    });
  }

  /// Opens the modal bottom sheet for detailed product view.
  void _openProductDetail(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ProductDetailSheet(
        product: product,
        onFavoriteToggle: () {
          _toggleFavorite(product.id);
          Navigator.pop(ctx);
        },
        onAddToCart: () {
          _addToCart(product);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  /// Opens the sort and filter bottom sheet modal.
  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FilterModalSheet(
        currentSort: _selectedSort,
        currentInStockOnly: _inStockOnly,
        onSortChanged: (sort) {
          setState(() {
            _selectedSort = sort;
          });
        },
        onInStockChanged: (inStock) {
          setState(() {
            _inStockOnly = inStock;
          });
        },
        onReset: _resetAllFilters,
      ),
    );
  }

  // ======================================================
  // BUILD METHOD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProducts;

    return Scaffold(
      backgroundColor: AppPalette.background,
      appBar: AppBar(
        backgroundColor: AppPalette.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover',
              style: TextStyle(
                color: AppPalette.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'Find premium gear & accessories',
              style: TextStyle(
                color: AppPalette.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          // Cart Icon with Reactive Badge
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppPalette.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppPalette.textPrimary,
                    ),
                    onPressed: _openCartSheet,
                    tooltip: 'View Cart',
                  ),
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppPalette.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          '$_cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // SEARCH AND FILTER HEADER
          // ==========================================
          SearchFilterHeader(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onClear: _clearSearch,
            onFilterTap: _openFilterModal,
            hasActiveFilters: _hasActiveFilters,
          ),

          // ==========================================
          // HORIZONTAL CATEGORY SELECTOR
          // ==========================================
          CategorySelector(
            selectedCategory: _selectedCategory,
            onCategorySelected: _onCategorySelected,
            categoryCounts: _categoryCounts,
          ),
          const SizedBox(height: 10),

          // ==========================================
          // RESULTS STATUS BANNER
          // ==========================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filtered.length} product${filtered.length == 1 ? '' : 's'} found',
                  style: const TextStyle(
                    color: AppPalette.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_hasActiveFilters || _searchQuery.isNotEmpty || _selectedCategory != ProductCategory.all)
                  GestureDetector(
                    onTap: _resetAllFilters,
                    child: const Text(
                      'Clear Filters',
                      style: TextStyle(
                        color: AppPalette.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // ==========================================
          // DYNAMIC LISTVIEW.BUILDER
          // ==========================================
          Expanded(
            child: filtered.isEmpty
                ? EmptyStateView(
                    searchQuery: _searchQuery,
                    onReset: _resetAllFilters,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      return ProductCard(
                        key: ValueKey(product.id),
                        product: product,
                        onTap: () => _openProductDetail(product),
                        onFavoriteToggle: () => _toggleFavorite(product.id),
                        onAddToCart: () => _addToCart(product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
