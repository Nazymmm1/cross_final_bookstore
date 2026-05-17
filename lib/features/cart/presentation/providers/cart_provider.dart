import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';

class CartItem {
  final Book book;
  final int quantity;

  const CartItem({required this.book, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(book: book, quantity: quantity ?? this.quantity);
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addBook(Book book) {
    final index = state.indexWhere((item) => item.book.id == book.id);
    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem(book: book, quantity: 1)];
    }
  }

  void removeBook(String bookId) {
    state = state.where((item) => item.book.id != bookId).toList();
  }

  void decreaseQuantity(String bookId) {
    final index = state.indexWhere((item) => item.book.id == bookId);
    if (index >= 0) {
      if (state[index].quantity <= 1) {
        removeBook(bookId);
      } else {
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index)
              state[i].copyWith(quantity: state[i].quantity - 1)
            else
              state[i],
        ];
      }
    }
  }

  void clearCart() => state = [];

  double get totalPrice => state.fold(
        0,
        (sum, item) => sum + item.book.price * item.quantity,
      );

  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final notifier = ref.watch(cartProvider.notifier);
  ref.watch(cartProvider);
  return notifier.totalPrice;
});

final cartItemCountProvider = Provider<int>((ref) {
  final notifier = ref.watch(cartProvider.notifier);
  ref.watch(cartProvider);
  return notifier.totalItems;
});