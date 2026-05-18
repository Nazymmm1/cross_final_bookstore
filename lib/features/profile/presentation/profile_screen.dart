import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore_app/features/profile/presentation/providers/wishlist_provider.dart';
import 'package:bookstore_app/features/currency/presentation/providers/currency_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: const Color(0xFFEEEDFE),
                  child: const Icon(Icons.person, size: 40, color: Color(0xFF6B4EFF)),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Lover', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('reader@bookstore.com', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Currency converter
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.currency_exchange, color: Color(0xFF6B4EFF)),
                    SizedBox(width: 8),
                    Text('Currency Converter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                currency.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF6B4EFF))),
                  error: (e, _) => Text('Could not load rates: $e', style: const TextStyle(color: Colors.red, fontSize: 12)),
                  data: (rates) => Column(
                    children: [
                      _CurrencyRow(flag: '🇪🇺', currency: 'EUR', rate: rates['EUR'] ?? 0),
                      _CurrencyRow(flag: '🇬🇧', currency: 'GBP', rate: rates['GBP'] ?? 0),
                      _CurrencyRow(flag: '🇰🇿', currency: 'KZT', rate: rates['KZT'] ?? 0),
                      _CurrencyRow(flag: '🇷🇺', currency: 'RUB', rate: rates['RUB'] ?? 0),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Wishlist
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_outline, color: Color(0xFF6B4EFF)),
                    const SizedBox(width: 8),
                    Text('Wishlist (${wishlist.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                wishlist.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No saved books yet', style: TextStyle(color: Colors.grey)),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: wishlist.length,
                        itemBuilder: (context, index) {
                          final book = wishlist[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 40, height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEDFE),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.book, color: Color(0xFF6B4EFF), size: 20),
                            ),
                            title: Text(book.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text(book.author, style: const TextStyle(fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                            trailing: IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                              onPressed: () => ref.read(wishlistProvider.notifier).toggleWishlist(book),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Settings
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Column(
              children: [
                _SettingsTile(icon: Icons.receipt_long_outlined, title: 'My Orders', onTap: () => context.go('/orders')),
                const Divider(height: 1),
                _SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
                const Divider(height: 1),
                _SettingsTile(icon: Icons.help_outline, title: 'Help & Support', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyRow extends StatelessWidget {
  final String flag;
  final String currency;
  final double rate;
  const _CurrencyRow({required this.flag, required this.currency, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$flag  $currency', style: const TextStyle(fontSize: 14)),
          Text('1 USD = ${rate.toStringAsFixed(2)} $currency',
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF6B4EFF))),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _SettingsTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6B4EFF)),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}