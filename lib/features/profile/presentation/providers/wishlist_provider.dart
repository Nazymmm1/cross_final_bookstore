import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'package:bookstore_app/features/catalog/data/models/book_model.dart';

const _wishlistKey = 'wishlist_books';

class WishlistNotifier extends StateNotifier<List<Book>> {
  WishlistNotifier() : super([]) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_wishlistKey) ?? [];
    state = jsonList
        .map((s) => BookModel.fromJson(json.decode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state
        .map((b) => json.encode((b as BookModel).toJson()))
        .toList();
    await prefs.setStringList(_wishlistKey, jsonList);
  }

  void toggleWishlist(Book book) {
    final exists = state.any((b) => b.id == book.id);
    if (exists) {
      state = state.where((b) => b.id != book.id).toList();
    } else {
      state = [...state, book];
    }
    _saveToPrefs();
  }

  bool isWishlisted(String bookId) {
    return state.any((b) => b.id == bookId);
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<Book>>((ref) {
  return WishlistNotifier();
});