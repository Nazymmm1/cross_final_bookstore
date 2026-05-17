import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'package:bookstore_app/features/catalog/data/sources/book_remote_source.dart';
import 'package:bookstore_app/features/catalog/domain/repositories/book_repository.dart';
import 'package:bookstore_app/features/catalog/data/repositories/book_repository_impl.dart';

export 'package:bookstore_app/features/catalog/data/repositories/book_repository_impl.dart';

final genresProvider = Provider<List<String>>((ref) {
  return [
    'All',
    'Fantasy',
    'Psychology',
    'Dark Romance',
    'Classic',
    'Science Fiction',
    'Self-Help',
    'Mystery',
  ];
});

final selectedGenreProvider = StateProvider<String>((ref) => 'All');

final searchQueryProvider = StateProvider<String>((ref) => '');

final booksProvider = FutureProvider<List<Book>>((ref) async {
  final genre = ref.watch(selectedGenreProvider);
  final query = ref.watch(searchQueryProvider);
  final repo = ref.watch(bookRepositoryProvider);

  if (query.isNotEmpty) {
    return repo.searchBooks(query);
  }
  if (genre == 'All') {
    return repo.getFeaturedBooks();
  }
  return repo.getBooksByGenre(genre);
});

final bookDetailProvider =
    FutureProvider.family<List<Book>, String>((ref, genre) {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBooksByGenre(genre);
});