import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookstore_app/core/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BookstoreApp(),
    ),
  );
}

class BookstoreApp extends ConsumerWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Bookstore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4EFF)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}