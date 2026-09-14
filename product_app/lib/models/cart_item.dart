import 'product.dart';

/// Domain entity representing a product item in the shopping cart with quantity.
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// Total price for this cart line item
  double get subtotal => product.price * quantity;

  /// Formatted subtotal string
  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
}
