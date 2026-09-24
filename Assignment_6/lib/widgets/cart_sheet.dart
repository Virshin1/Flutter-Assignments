import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/cart_item.dart';

/// CartSheet displays the active items in the shopping cart,
/// supports quantity adjustment, removal, and checkout actions.
class CartSheet extends StatelessWidget {
  final List<CartItem> items;
  final void Function(String productId, int delta) onUpdateQuantity;
  final void Function(String productId) onRemoveItem;
  final VoidCallback onClearCart;
  final VoidCallback onCheckout;

  const CartSheet({
    super.key,
    required this.items,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
    required this.onClearCart,
    required this.onCheckout,
  });

  double get _subtotal =>
      items.fold(0.0, (sum, item) => sum + item.subtotal);

  int get _totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppPalette.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header: Title, Count, Clear Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'My Cart',
                        style: TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppPalette.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_totalItemCount',
                          style: const TextStyle(
                            color: AppPalette.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (items.isNotEmpty)
                    TextButton(
                      onPressed: onClearCart,
                      child: const Text(
                        'Clear Cart',
                        style: TextStyle(
                          color: AppPalette.danger,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(color: AppPalette.divider),

            // ==========================================
            // CART ITEMS OR EMPTY STATE
            // ==========================================
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppPalette.surfaceVariant,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 36,
                                  color: AppPalette.textMuted,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Your cart is empty',
                              style: TextStyle(
                                color: AppPalette.textPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Explore our catalog and add items you like.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppPalette.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppPalette.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Start Shopping',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: AppPalette.divider, height: 20),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final product = item.product;

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Product Image / Thumbnail
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: product.category.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppPalette.cardBorder,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: product.imageUrl != null
                                    ? Image.network(
                                        product.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                          child: Icon(
                                            product.icon,
                                            size: 28,
                                            color: product.category.color,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          product.icon,
                                          size: 28,
                                          color: product.category.color,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.brand.toUpperCase(),
                                    style: const TextStyle(
                                      color: AppPalette.textMuted,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppPalette.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.formattedPrice,
                                    style: const TextStyle(
                                      color: AppPalette.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Quantity Stepper Controls
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _QuantityButton(
                                  icon: Icons.remove_rounded,
                                  onPressed: () =>
                                      onUpdateQuantity(product.id, -1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      color: AppPalette.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _QuantityButton(
                                  icon: Icons.add_rounded,
                                  onPressed: () =>
                                      onUpdateQuantity(product.id, 1),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),

                            // Remove Button
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 20,
                                color: AppPalette.textMuted,
                              ),
                              onPressed: () => onRemoveItem(product.id),
                              tooltip: 'Remove from cart',
                            ),
                          ],
                        );
                      },
                    ),
            ),

            // ==========================================
            // FOOTER CHECKOUT SUMMARY
            // ==========================================
            if (items.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppPalette.surface,
                  border: const Border(
                    top: BorderSide(color: AppPalette.cardBorder),
                  ),
                  boxShadow: AppPalette.cardShadow,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Subtotal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            color: AppPalette.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '\$${_subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppPalette.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Delivery
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping',
                          style: TextStyle(
                            color: AppPalette.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'FREE',
                          style: TextStyle(
                            color: AppPalette.success,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: AppPalette.divider),
                    const SizedBox(height: 6),

                    // Total Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            color: AppPalette.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${_subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppPalette.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: onCheckout,
                        icon: const Icon(
                          Icons.lock_outline_rounded,
                          size: 18,
                        ),
                        label: Text(
                          'Checkout • \$${_subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppPalette.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppPalette.cardBorder),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: AppPalette.textPrimary),
        onPressed: onPressed,
      ),
    );
  }
}
