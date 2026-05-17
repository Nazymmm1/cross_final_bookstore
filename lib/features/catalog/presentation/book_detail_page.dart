import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'package:bookstore_app/features/catalog/presentation/providers/catalog_provider.dart';
import 'package:bookstore_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:bookstore_app/features/catalog/presentation/providers/catalog_provider.dart';
import 'package:bookstore_app/features/wishlist/data/wishlist_provider.dart';
class BookDetailPage extends ConsumerWidget {
  final String bookId;
  const BookDetailPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksProvider);

    return books.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF6B4EFF))),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text('Error: $e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(booksProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (bookList) {
        final book = bookList.cast<Book?>().firstWhere(
          (b) => b?.id == bookId,
          orElse: () => null,
        );

        if (book == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Book not found')),
          );
        }

        return _BookDetailView(book: book);
      },
    );
  }
}

class _BookDetailView extends ConsumerWidget {
  final Book book;
  const _BookDetailView({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar configuration fixed
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: const Color(0xFF6B4EFF),
            leading: IconButton(
              icon:  Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.surfaceContainerLowest,),
              onPressed: () => context.pop(),
            ),
            actions: [
              // Heart button
              Consumer(
                builder: (context, ref, _) {
                  final isWishlisted = ref.watch(isWishlistedProvider(book.id));
                  return isWishlisted.when(
                    loading: () => const SizedBox(width: 48),
                    error: (_, __) => const SizedBox(width: 48),
                    data: (wishlisted) => IconButton(
                      icon: Icon(
                        wishlisted ? Icons.favorite : Icons.favorite_border,
                        color: wishlisted ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        await ref.read(wishlistNotifierProvider).toggle(book);
                        ref.invalidate(isWishlistedProvider(book.id));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                wishlisted
                                    ? '${book.title} removed from wishlist'
                                    : '${book.title} added to wishlist',
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor: const Color(0xFF6B4EFF),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
            // Wired up your cover placeholder here
            flexibleSpace: FlexibleSpaceBar(
              background: _CoverPlaceholder(title: book.title),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Author
                  Text(
                    'by ${book.author}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating, genre, age row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Chip(
                        icon: Icons.star_rounded,
                        label: book.rating.toStringAsFixed(1),
                        color: Colors.amber,
                      ),
                      _Chip(
                        icon: Icons.category_outlined,
                        label: book.genre,
                        color: const Color(0xFF6B4EFF),
                      ),
                      _Chip(
                        icon: Icons.person_outline,
                        label: book.ageCategory,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${book.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B4EFF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description header
                  const Text(
                    'About this book',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description
                  Text(
                    book.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 100), // space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),

      // Add to cart bottom bar
      bottomNavigationBar: _AddToCartBar(book: book),
    );
  }
}

class _AddToCartBar extends ConsumerWidget {
  final Book book;
  const _AddToCartBar({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: () {
          ref.read(cartProvider.notifier).addBook(book);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${book.title} added to cart'),
              duration: const Duration(seconds: 1),
              backgroundColor: const Color(0xFF6B4EFF),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart_outlined),
        label: const Text(
          'Add to cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF6B4EFF),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Chip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  final String title;
  const _CoverPlaceholder({required this.title});

  Color _colorFromTitle(String title) {
    final colors = [
      const Color(0xFF6B4EFF),
      const Color(0xFF4E9EFF),
      const Color(0xFFFF6B9D),
      const Color(0xFF4ECFB5),
      const Color(0xFFFF9F4E),
    ];
    return colors[title.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFromTitle(title);
    return Container(
      color: color.withOpacity(0.15),
      child: Center(
        child: Icon(Icons.book, size: 80, color: color.withOpacity(0.4)),
      ),
    );
  }
}