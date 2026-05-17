import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'wishlist_database.dart';

final wishlistDatabaseProvider = Provider<WishlistDatabase>((ref) {
  final db = WishlistDatabase();
  ref.onDispose(db.close);
  return db;
});

// Stream of all wishlisted books
final wishlistProvider = StreamProvider<List<Book>>((ref) {
  final db = ref.watch(wishlistDatabaseProvider);
  return db.watchAllItems().map(
    (items) => items.map((item) => _itemToBook(item)).toList(),
  );
});

// Check if a specific book is wishlisted
final isWishlistedProvider = FutureProvider.family<bool, String>((ref, bookId) {
  final db = ref.watch(wishlistDatabaseProvider);
  return db.isWishlisted(bookId);
});

Book _itemToBook(WishlistItem item) {
  return Book(
    id: item.id,
    title: item.title,
    author: item.author,
    description: item.description,
    coverUrl: item.coverUrl,
    genre: item.genre,
    price: item.price,
    rating: item.rating,
    ageCategory: item.ageCategory,
  );
}

// Notifier to add/remove
final wishlistNotifierProvider = Provider((ref) => WishlistNotifier(ref));

class WishlistNotifier {
  final Ref _ref;
  WishlistNotifier(this._ref);

  WishlistDatabase get _db => _ref.read(wishlistDatabaseProvider);

  Future<void> toggle(Book book) async {
    final isIn = await _db.isWishlisted(book.id);
    if (isIn) {
      await _db.removeItem(book.id);
    } else {
      await _db.addItem(WishlistItemsCompanion(
        id: Value(book.id),
        title: Value(book.title),
        author: Value(book.author),
        description: Value(book.description),
        coverUrl: Value(book.coverUrl),
        genre: Value(book.genre),
        price: Value(book.price),
        rating: Value(book.rating),
        ageCategory: Value(book.ageCategory),
      ));
    }
  }
}