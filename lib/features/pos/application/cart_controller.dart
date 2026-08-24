import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';

final cartControllerProvider = NotifierProvider<CartController, List<CartItem>>(
  CartController.new,
);

final cartDiscountProvider = StateProvider<int>((ref) => 0);

final selectedPaymentMethodProvider = StateProvider<String>((ref) => 'cash');

class CartController extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => const [];

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItem(product: product, qty: 1)];
      return;
    }

    state = [
      for (final (itemIndex, item) in state.indexed)
        itemIndex == index ? item.copyWith(qty: item.qty + 1) : item,
    ];
  }

  void decreaseQty(String productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId && item.qty > 1)
          item.copyWith(qty: item.qty - 1)
        else if (item.product.id != productId)
          item,
    ];
  }

  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void clear() {
    state = const [];
  }
}

class CartItem {
  const CartItem({required this.product, required this.qty});

  final Product product;
  final int qty;

  int get lineTotal => product.price * qty;

  CartItem copyWith({Product? product, int? qty}) {
    return CartItem(product: product ?? this.product, qty: qty ?? this.qty);
  }
}

extension CartSummary on List<CartItem> {
  int get totalQty => fold(0, (total, item) => total + item.qty);

  int get subtotal => fold(0, (total, item) => total + item.lineTotal);

  int grandTotal(int discountTotal) {
    final total = subtotal - discountTotal;
    return total < 0 ? 0 : total;
  }
}
