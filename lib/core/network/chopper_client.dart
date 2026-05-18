import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'book_api_service.dart';

final chopperClientProvider = Provider<ChopperClient>((ref) {
  return ChopperClient(
    baseUrl: Uri.parse('https://www.googleapis.com/books/v1'),
    services: [BookApiService.create()],
    converter: const JsonConverter(),
  );
});

final bookApiServiceProvider = Provider<BookApiService>((ref) {
  final client = ref.watch(chopperClientProvider);
  return client.getService<BookApiService>();
});