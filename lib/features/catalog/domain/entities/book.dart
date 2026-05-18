class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String genre;
  final double price;
  final double rating;
  final String ageCategory;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.genre,
    required this.price,
    required this.rating,
    required this.ageCategory,
  });
}