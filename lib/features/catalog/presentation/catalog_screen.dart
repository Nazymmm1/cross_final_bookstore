import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore_app/features/catalog/presentation/providers/catalog_provider.dart';
import 'package:bookstore_app/features/catalog/domain/entities/book.dart';
import 'package:bookstore_app/features/cart/presentation/providers/cart_provider.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksProvider);
    final genres = ref.watch(genresProvider);
    final selectedGenre = ref.watch(selectedGenreProvider);
    final cartCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF6B4EFF),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Bookstore',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Container(color: const Color(0xFF6B4EFF)),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    onPressed: () => context.go('/cart'),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.white),
                onPressed: () => context.go('/profile'),
              ),
            ],
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _SearchBar(),
            ),
          ),

          // Genre chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: genres.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  final isSelected = genre == selectedGenre;
                  return ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    selectedColor: const Color(0xFF6B4EFF),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF6B4EFF),
                      fontWeight: FontWeight.w500,
                    ),
                    onSelected: (_) {
                      ref.read(selectedGenreProvider.notifier).state = genre;
                    },
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Books grid
          books.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF6B4EFF)),
              ),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text('Error: $e', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            data: (bookList) => bookList.isEmpty
                ? const SliverFillRemaining(
                    child: Center(child: Text('No books found')),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _BookCard(book: bookList[index]),
                        childCount: bookList.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                            mainAxisExtent: 280,
                          ),
                                              ),
                  ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search books...',
        prefixIcon: const Icon(Icons.search, color: Color(0xFF6B4EFF)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).state = value;
      },
    );
  }
}

class _BookCard extends ConsumerWidget {
  final Book book;
  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.go('/book/${book.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: book.coverUrl.isNotEmpty
                    ? Image.network(
                        book.coverUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _PlaceholderCover(
                          title: book.title,
                        ),
                      )
                    : _PlaceholderCover(title: book.title),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${book.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B4EFF),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(cartProvider.notifier).addBook(book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${book.title} added to cart'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: const Color(0xFF6B4EFF),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B4EFF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderCover extends StatelessWidget {
  final String title;
  const _PlaceholderCover({required this.title});

  Color _colorFromTitle(String title) {
    final colors = [
      const Color(0xFF6B4EFF),
      const Color(0xFF4E9EFF),
      const Color(0xFFFF6B9D),
      const Color(0xFF4ECFB5),
      const Color(0xFFFF9F4E),
      const Color(0xFF9F4EFF),
    ];
    return colors[title.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFromTitle(title);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color.withOpacity(0.12),
      child: Stack(
        children: [
          Center(
            child: Icon(Icons.book, size: 56, color: color.withOpacity(0.35)),
          ),
          Positioned(
            bottom: 12,
            left: 8,
            right: 8,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}