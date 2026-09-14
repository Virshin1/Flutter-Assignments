import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

/// Supported product categories with icons, labels, and color tokens.
enum ProductCategory {
  all,
  electronics,
  audio,
  wearables,
  footwear,
  accessories;

  String get label => switch (this) {
        ProductCategory.all => 'All',
        ProductCategory.electronics => 'Electronics',
        ProductCategory.audio => 'Audio',
        ProductCategory.wearables => 'Wearables',
        ProductCategory.footwear => 'Footwear',
        ProductCategory.accessories => 'Accessories',
      };

  IconData get icon => switch (this) {
        ProductCategory.all => Icons.grid_view_rounded,
        ProductCategory.electronics => Icons.laptop_mac_rounded,
        ProductCategory.audio => Icons.headphones_rounded,
        ProductCategory.wearables => Icons.watch_rounded,
        ProductCategory.footwear => Icons.directions_run_rounded,
        ProductCategory.accessories => Icons.backpack_rounded,
      };

  Color get color => switch (this) {
        ProductCategory.all => AppPalette.primary,
        ProductCategory.electronics => AppPalette.catElectronics,
        ProductCategory.audio => AppPalette.catAudio,
        ProductCategory.wearables => AppPalette.catWearables,
        ProductCategory.footwear => AppPalette.catFootwear,
        ProductCategory.accessories => AppPalette.catAccessories,
      };

  Color get backgroundColor => switch (this) {
        ProductCategory.all => AppPalette.primaryLight,
        ProductCategory.electronics => AppPalette.catElectronicsBg,
        ProductCategory.audio => AppPalette.catAudioBg,
        ProductCategory.wearables => AppPalette.catWearablesBg,
        ProductCategory.footwear => AppPalette.catFootwearBg,
        ProductCategory.accessories => AppPalette.catAccessoriesBg,
      };
}

/// Sort options for products.
enum ProductSortOption {
  featured,
  priceLowToHigh,
  priceHighToLow,
  highestRated;

  String get label => switch (this) {
        ProductSortOption.featured => 'Featured',
        ProductSortOption.priceLowToHigh => 'Price: Low to High',
        ProductSortOption.priceHighToLow => 'Price: High to Low',
        ProductSortOption.highestRated => 'Top Rated',
      };

  IconData get icon => switch (this) {
        ProductSortOption.featured => Icons.auto_awesome_rounded,
        ProductSortOption.priceLowToHigh => Icons.arrow_upward_rounded,
        ProductSortOption.priceHighToLow => Icons.arrow_downward_rounded,
        ProductSortOption.highestRated => Icons.star_rounded,
      };
}

/// Domain model representing a single Product in the listing.
///
/// Demonstrates Dart OOP, null-safety, computed getters,
/// and immutability with `copyWith`.
class Product {
  final String id;
  final String name;
  final String brand;
  final ProductCategory category;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final int stockQuantity;
  final String description;
  final String? imageUrl;
  final IconData icon;
  final Color accentColor;
  final bool isFavorite;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    required this.stockQuantity,
    required this.description,
    this.imageUrl,
    required this.icon,
    required this.accentColor,
    this.isFavorite = false,
    this.tags = const [],
  });

  /// Formatted current price in USD ($)
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Formatted original retail price if discount applies
  String? get formattedOriginalPrice =>
      originalPrice != null ? '\$${originalPrice!.toStringAsFixed(2)}' : null;

  /// Whether product has a markdown discount
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Percentage discount computed dynamically
  int get discountPercentage => hasDiscount
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;

  /// Human-readable stock status indicator
  String get stockStatus {
    if (!inStock || stockQuantity <= 0) return 'Out of Stock';
    if (stockQuantity <= 5) return 'Only $stockQuantity left';
    return 'In Stock';
  }

  /// Color corresponding to the stock status
  Color get stockColor {
    if (!inStock || stockQuantity <= 0) return AppPalette.danger;
    if (stockQuantity <= 5) return AppPalette.accent;
    return AppPalette.success;
  }

  /// Creates a copy of Product with modified attributes
  Product copyWith({
    String? id,
    String? name,
    String? brand,
    ProductCategory? category,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    bool? inStock,
    int? stockQuantity,
    String? description,
    String? imageUrl,
    IconData? icon,
    Color? accentColor,
    bool? isFavorite,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      inStock: inStock ?? this.inStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      icon: icon ?? this.icon,
      accentColor: accentColor ?? this.accentColor,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }

  /// Initial sample catalog populated with diverse product lines
  static List<Product> getSampleProducts() {
    return [
      const Product(
        id: 'prod-001',
        name: 'Pro ANC Wireless Headphones',
        brand: 'AcoustiQ',
        category: ProductCategory.audio,
        price: 199.99,
        originalPrice: 249.99,
        rating: 4.8,
        reviewCount: 342,
        inStock: true,
        stockQuantity: 18,
        description:
            'Premium over-ear studio headphones with hybrid active noise cancellation, 40-hour battery life, and spatial audio support.',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=400&q=80',
        icon: Icons.headphones_rounded,
        accentColor: AppPalette.catAudio,
        isFavorite: true,
        tags: ['Best Seller', 'ANC', 'Wireless'],
      ),
      const Product(
        id: 'prod-002',
        name: 'Ultra-Slim 4K OLED Monitor 27"',
        brand: 'PixelCraft',
        category: ProductCategory.electronics,
        price: 489.00,
        originalPrice: 549.00,
        rating: 4.9,
        reviewCount: 128,
        inStock: true,
        stockQuantity: 7,
        description:
            'Stunning 27-inch 4K OLED display with 144Hz refresh rate, 99% DCI-P3 color gamut, and 90W USB-C power delivery.',
        imageUrl:
            'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=400&q=80',
        icon: Icons.desktop_windows_rounded,
        accentColor: AppPalette.catElectronics,
        isFavorite: false,
        tags: ['4K OLED', 'Featured', 'Gaming'],
      ),
      const Product(
        id: 'prod-003',
        name: 'AeroPulse GPS Fitness Smartwatch',
        brand: 'Chronos',
        category: ProductCategory.wearables,
        price: 229.50,
        originalPrice: 279.00,
        rating: 4.6,
        reviewCount: 215,
        inStock: true,
        stockQuantity: 4,
        description:
            'Lightweight titanium smartwatch with standalone multi-band GPS, continuous heart-rate & SpO2 tracking, and 7-day battery life.',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=400&q=80',
        icon: Icons.watch_rounded,
        accentColor: AppPalette.catWearables,
        isFavorite: false,
        tags: ['Fitness', 'GPS', 'Titanium'],
      ),
      const Product(
        id: 'prod-004',
        name: 'CloudStride Pro Running Shoes',
        brand: 'Velocity',
        category: ProductCategory.footwear,
        price: 139.95,
        originalPrice: 160.00,
        rating: 4.7,
        reviewCount: 489,
        inStock: true,
        stockQuantity: 22,
        description:
            'Engineered mesh upper with responsive carbon-fiber plate cushion for maximum energy return and marathon durability.',
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=400&q=80',
        icon: Icons.directions_run_rounded,
        accentColor: AppPalette.catFootwear,
        isFavorite: true,
        tags: ['Running', 'Carbon-Plate', 'Lightweight'],
      ),
      const Product(
        id: 'prod-005',
        name: 'Urban Commuter Waterproof Backpack',
        brand: 'NomadGear',
        category: ProductCategory.accessories,
        price: 89.90,
        originalPrice: 110.00,
        rating: 4.5,
        reviewCount: 96,
        inStock: true,
        stockQuantity: 15,
        description:
            'Weatherproof 24L commuter pack featuring a dedicated 16-inch padded laptop sleeve, magnetic Fidlock buckles, and hidden passport pocket.',
        imageUrl:
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=400&q=80',
        icon: Icons.backpack_rounded,
        accentColor: AppPalette.catAccessories,
        isFavorite: false,
        tags: ['Waterproof', 'Laptop Bag', 'Everyday'],
      ),
      const Product(
        id: 'prod-006',
        name: 'True Wireless Earbuds Pro',
        brand: 'AcoustiQ',
        category: ProductCategory.audio,
        price: 119.00,
        originalPrice: 149.00,
        rating: 4.4,
        reviewCount: 180,
        inStock: true,
        stockQuantity: 30,
        description:
            'Compact in-ear wireless buds with dynamic drivers, transparency mode, IPX5 water resistance, and wireless charging case.',
        imageUrl:
            'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=400&q=80',
        icon: Icons.earbuds_rounded,
        accentColor: AppPalette.catAudio,
        isFavorite: false,
        tags: ['Earbuds', 'IPX5', 'Compact'],
      ),
      const Product(
        id: 'prod-007',
        name: 'Mechanical RGB Hot-Swap Keyboard',
        brand: 'KeyForge',
        category: ProductCategory.electronics,
        price: 145.00,
        originalPrice: null,
        rating: 4.8,
        reviewCount: 310,
        inStock: false,
        stockQuantity: 0,
        description:
            'Custom gasket-mounted 75% mechanical keyboard with factory-lubed linear switches, PBT keycaps, and per-key RGB backlighting.',
        imageUrl:
            'https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=400&q=80',
        icon: Icons.keyboard_rounded,
        accentColor: AppPalette.catElectronics,
        isFavorite: false,
        tags: ['Mechanical', 'Hot-Swap', 'RGB'],
      ),
      const Product(
        id: 'prod-008',
        name: 'Smart Ceramic Temperature Mug',
        brand: 'ThermalCraft',
        category: ProductCategory.accessories,
        price: 99.00,
        originalPrice: 125.00,
        rating: 4.3,
        reviewCount: 75,
        inStock: true,
        stockQuantity: 3,
        description:
            'Precision app-controlled heated ceramic mug that keeps your coffee or tea at your dialed-in temperature for up to 2 hours.',
        imageUrl:
            'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=400&q=80',
        icon: Icons.coffee_rounded,
        accentColor: AppPalette.catAccessories,
        isFavorite: false,
        tags: ['Smart Home', 'App Controlled', 'Ceramic'],
      ),
      const Product(
        id: 'prod-009',
        name: 'TrailVenture Waterproof Hiking Boots',
        brand: 'Velocity',
        category: ProductCategory.footwear,
        price: 179.99,
        originalPrice: 210.00,
        rating: 4.7,
        reviewCount: 164,
        inStock: true,
        stockQuantity: 12,
        description:
            'Rugged all-terrain hiking boots built with breathable waterproof membrane, Vibram Megagrip outsoles, and ankle support collar.',
        imageUrl:
            'https://images.unsplash.com/photo-1520639888713-7851133b1ed0?auto=format&fit=crop&w=400&q=80',
        icon: Icons.hiking_rounded,
        accentColor: AppPalette.catFootwear,
        isFavorite: false,
        tags: ['Waterproof', 'Hiking', 'Vibram'],
      ),
      const Product(
        id: 'prod-010',
        name: 'Slim MagSafe Magnetic Power Bank',
        brand: 'VoltGrid',
        category: ProductCategory.electronics,
        price: 49.99,
        originalPrice: 65.00,
        rating: 4.5,
        reviewCount: 420,
        inStock: true,
        stockQuantity: 40,
        description:
            '10,000mAh ultra-compact magnetic wireless battery pack with 20W PD fast charging and pass-through capability.',
        imageUrl:
            'https://images.unsplash.com/photo-1609081219099-158cce91c28c?auto=format&fit=crop&w=400&q=80',
        icon: Icons.battery_charging_full_rounded,
        accentColor: AppPalette.catElectronics,
        isFavorite: true,
        tags: ['Wireless', 'MagSafe', 'Fast Charge'],
      ),
    ];
  }
}
