import 'package:chopper/chopper.dart';

class BookApiService extends ChopperService {
  static BookApiService create([ChopperClient? client]) {
    final instance = BookApiService();
    if (client != null) {
      instance.client = client;
    }
    return instance;
  }

  Future<Response> searchBooks(String query, {int maxResults = 20}) {
    final uri = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes'
      '?q=${Uri.encodeComponent(query)}&maxResults=$maxResults',
    );
    return client.get(uri);
  }

  Future<Response> getBookById(String id) {
    final uri = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes/$id',
    );
    return client.get(uri);
  }

  @override
  Type get definitionType => BookApiService;
}