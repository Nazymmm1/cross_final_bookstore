import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bookstore_app/core/constants/api_constants.dart';
import 'package:bookstore_app/features/catalog/data/models/book_model.dart';
import 'package:bookstore_app/core/network/book_api_service.dart';
import 'package:bookstore_app/core/network/chopper_client.dart';

final bookRemoteSourceProvider = Provider<BookRemoteSource>((ref) {
  final service = ref.watch(bookApiServiceProvider);
  return BookRemoteSource(service);
});

final _mockBooks = <BookModel>[
  BookModel(id: '1', title: 'The Name of the Wind', author: 'Patrick Rothfuss', description: 'A fantasy epic.', coverUrl: '', genre: 'Fantasy', price: 14, rating: 4.8, ageCategory: 'All ages'),
  BookModel(id: '2', title: 'Atomic Habits', author: 'James Clear', description: 'Build better habits.', coverUrl: '', genre: 'Self-Help', price: 12, rating: 4.9, ageCategory: 'All ages'),
  BookModel(id: '3', title: 'It Ends with Us', author: 'Colleen Hoover', description: 'A powerful love story.', coverUrl: '', genre: 'Dark Romance', price: 11, rating: 4.7, ageCategory: '18+'),
  BookModel(id: '4', title: 'Dune', author: 'Frank Herbert', description: 'Sci-fi masterpiece.', coverUrl: '', genre: 'Science Fiction', price: 15, rating: 4.8, ageCategory: 'All ages'),
  BookModel(id: '5', title: 'Pride and Prejudice', author: 'Jane Austen', description: 'A classic romance.', coverUrl: '', genre: 'Classic', price: 9, rating: 4.6, ageCategory: 'All ages'),
  BookModel(id: '6', title: 'The Psychology of Money', author: 'Morgan Housel', description: 'Money and mindset.', coverUrl: '', genre: 'Psychology', price: 13, rating: 4.7, ageCategory: 'All ages'),
  BookModel(id: '7', title: 'A Court of Thorns and Roses', author: 'Sarah J. Maas', description: 'A fantasy romance.', coverUrl: '', genre: 'Fantasy', price: 14, rating: 4.6, ageCategory: '18+'),
  BookModel(id: '8', title: 'Thinking, Fast and Slow', author: 'Daniel Kahneman', description: 'How we think.', coverUrl: '', genre: 'Psychology', price: 16, rating: 4.5, ageCategory: 'All ages'),
  BookModel(id: '9', title: '1984', author: 'George Orwell', description: 'A dystopian classic.', coverUrl: '', genre: 'Classic', price: 10, rating: 4.7, ageCategory: 'All ages'),
  BookModel(id: '10', title: 'The Hobbit', author: 'J.R.R. Tolkien', description: 'A fantasy adventure.', coverUrl: '', genre: 'Fantasy', price: 13, rating: 4.8, ageCategory: 'All ages'),
  BookModel(id: '11', title: 'Verity', author: 'Colleen Hoover', description: 'A dark thriller.', coverUrl: '', genre: 'Dark Romance', price: 12, rating: 4.5, ageCategory: '18+'),
  BookModel(id: '12', title: 'The Martian', author: 'Andy Weir', description: 'Survival on Mars.', coverUrl: '', genre: 'Science Fiction', price: 12, rating: 4.7, ageCategory: 'All ages'),
  BookModel(id: '13', title: 'The Alchemist', author: 'Paulo Coelho', description: 'Follow your dreams.', coverUrl: '', genre: 'Classic', price: 10, rating: 4.5, ageCategory: 'All ages'),
  BookModel(id: '14', title: 'Influence', author: 'Robert Cialdini', description: 'The psychology of persuasion.', coverUrl: '', genre: 'Psychology', price: 14, rating: 4.6, ageCategory: 'All ages'),
  BookModel(id: '15', title: 'Fourth Wing', author: 'Rebecca Yarros', description: 'A fantasy romance.', coverUrl: '', genre: 'Dark Romance', price: 15, rating: 4.7, ageCategory: '18+'),
  BookModel(id: '16', title: 'Project Hail Mary', author: 'Andy Weir', description: 'A lone astronaut.', coverUrl: '', genre: 'Science Fiction', price: 13, rating: 4.9, ageCategory: 'All ages'),
];

class BookRemoteSource {
  final BookApiService _service;
  BookRemoteSource(this._service);

  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.booksBaseUrl}/volumes'
        '?q=${Uri.encodeComponent(query)}'
        '&maxResults=20'
        '&key=${ApiConstants.googleBooksApiKey}',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final items = body['items'] as List<dynamic>? ?? [];
        if (items.isNotEmpty) {
          return items
              .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (_) {}
    // fallback — return all mock books if query is featured/empty
    if (query.contains('bestseller') || query.isEmpty) {
      return _mockBooks;
    }
    final q = query.toLowerCase();
    return _mockBooks.where((b) =>
      b.title.toLowerCase().contains(q) ||
      b.author.toLowerCase().contains(q) ||
      b.genre.toLowerCase().contains(q)
    ).toList();
  }

  Future<List<BookModel>> getBooksByGenre(String genre) async {
    if (genre == 'All' || genre.contains('bestseller')) {
      return _mockBooks;
    }
    try {
      final uri = Uri.parse(
        '${ApiConstants.booksBaseUrl}/volumes'
        '?q=subject:${Uri.encodeComponent(genre)}'
        '&maxResults=20'
        '&key=${ApiConstants.googleBooksApiKey}',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final items = body['items'] as List<dynamic>? ?? [];
        if (items.isNotEmpty) {
          return items
              .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (_) {}
    // fallback to mock
    return _mockBooks.where((b) =>
      b.genre.toLowerCase() == genre.toLowerCase()
    ).toList();
  }
}