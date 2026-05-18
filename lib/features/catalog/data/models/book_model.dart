import 'package:bookstore_app/features/catalog/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.description,
    required super.coverUrl,
    required super.genre,
    required super.price,
    required super.rating,
    required super.ageCategory,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>? ?? {};
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {};

    return BookModel(
      id: json['id'] as String? ?? '',
      title: volumeInfo['title'] as String? ?? 'Unknown Title',
      author: (volumeInfo['authors'] as List<dynamic>?)?.first as String? ?? 'Unknown Author',
      description: volumeInfo['description'] as String? ?? 'No description available.',
      coverUrl: (imageLinks['thumbnail'] as String? ?? '').replaceAll('http://', 'https://'),
      genre: (volumeInfo['categories'] as List<dynamic>?)?.first as String? ?? 'General',
      price: ((volumeInfo['pageCount'] as int? ?? 100) % 20 + 9).toDouble(),
      rating: (volumeInfo['averageRating'] as num?)?.toDouble() ?? 4.0,
      ageCategory: _getAgeCategory(volumeInfo['maturityRating'] as String?),
    );
  }

  static String _getAgeCategory(String? maturityRating) {
    if (maturityRating == 'MATURE') return '18+';
    return 'All ages';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'description': description,
    'coverUrl': coverUrl,
    'genre': genre,
    'price': price,
    'rating': rating,
    'ageCategory': ageCategory,
  };
}