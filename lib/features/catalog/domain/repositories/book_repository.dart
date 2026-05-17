import 'package:bookstore_app/features/catalog/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query);
  Future<List<Book>> getBooksByGenre(String genre);
  Future<List<Book>> getFeaturedBooks();
}