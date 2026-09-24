import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/product.dart';

/// ProductCard widget represents a single product item in the ListView.
///
/// Designed with rich visual feedback:
/// - Visual category badge with icon and ambient tint
/// - Discount badge (-X%) when original price exists
/// - Star rating and review count
/// - Stock availability indicator
/// - Favorite toggle button with animated heart
/// - Quick add-to-cart button
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: product.isFavorite
              ? AppPalette.primary.withValues(alpha: 0.3)
              : AppPalette.cardBorder,
          width: 1.2,
        ),
        boxShadow: AppPalette.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================
                // PRODUCT ICON & DISCOUNT BADGE
                // ==========================================
                Stack(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: product.category.backgroundColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: product.imageUrl != null
                            ? Image.network(
                                product.imageUrl!,
                                width: 88,
                                height: 88,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                        color: product.category.color,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      product.icon,
                                      size: 40,
                                      color: product.category.color,
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Icon(
                                  product.icon,
                                  size: 40,
                                  color: product.category.color,
                                ),
                              ),
                      ),
                    ),
                    if (product.hasDiscount)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.danger,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '-${product.discountPercentage}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),

                // ==========================================
                // PRODUCT DETAILS (Title, Brand, Rating)
                // ==========================================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand & Stock status row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.brand.toUpperCase(),
                            style: const TextStyle(
                              color: AppPalette.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          // Stock badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: product.stockColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              product.stockStatus,
                              style: TextStyle(
                                color: product.stockColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Product Title
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Rating & Reviews row
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppPalette.starFilled,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: AppPalette.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${product.reviewCount})',
                            style: const TextStyle(
                              color: AppPalette.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // ==========================================
                      // PRICE & ACTION BUTTONS
                      // ==========================================
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price display
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.hasDiscount)
                                Text(
                                  product.formattedOriginalPrice!,
                                  style: const TextStyle(
                                    color: AppPalette.textMuted,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                product.formattedPrice,
                                style: const TextStyle(
                                  color: AppPalette.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          // Favorite Button
                          IconButton(
                            onPressed: onFavoriteToggle,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            icon: Icon(
                              product.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 20,
                              color: product.isFavorite
                                  ? AppPalette.favoriteActive
                                  : AppPalette.textMuted,
                            ),
                            tooltip: product.isFavorite
                                ? 'Remove from favorites'
                                : 'Add to favorites',
                          ),
                          const SizedBox(width: 6),

                          // Quick Add to Cart Button
                          InkWell(
                            onTap: product.inStock ? onAddToCart : null,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: product.inStock
                                    ? AppPalette.primary
                                    : AppPalette.surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 14,
                                    color: product.inStock
                                        ? Colors.white
                                        : AppPalette.textMuted,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Add',
                                    style: TextStyle(
                                      color: product.inStock
                                          ? Colors.white
                                          : AppPalette.textMuted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
