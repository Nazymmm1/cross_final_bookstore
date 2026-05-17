import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookstore_app/features/catalog/data/sources/book_remote_source.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'package:bookstore_app/features/catalog/domain/repositories/book_repository.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final remoteSource = ref.watch(bookRemoteSourceProvider);
  return BookRepositoryImpl(remoteSource);
});

class BookRepositoryImpl implements BookRepository {
  final BookRemoteSource _remoteSource;
  BookRepositoryImpl(this._remoteSource);

  @override
  Future<List<Book>> searchBooks(String query) async {
    return _remoteSource.searchBooks(query);
  }

  @override
  Future<List<Book>> getBooksByGenre(String genre) async {
    return _remoteSource.getBooksByGenre(genre);
  }

  @override
  Future<List<Book>> getFeaturedBooks() async {
    return _remoteSource.searchBooks('bestseller fiction');
  }
}