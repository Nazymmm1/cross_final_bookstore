import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookstore_app/features/cart/presentation/providers/cart_provider.dart';

// Firestore orders provider
final firestoreOrdersProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return FirebaseFirestore.instance
      .collection('orders')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList());
});

// Add order to Firestore
Future<void> addOrderToFirestore(List<CartItem> items, double total) async {
  await FirebaseFirestore.instance.collection('orders').add({
    'items': items.map((i) => {'title': i.book.title, 'author': i.book.author, 'price': i.book.price, 'quantity': i.quantity}).toList(),
    'total': total,
    'status': 'Processing',
    'createdAt': FieldValue.serverTimestamp(),
  });
}

// Keep local notifier for cart_screen compatibility
class OrdersNotifier extends StateNotifier<List<dynamic>> {
  OrdersNotifier() : super([]);
  void addOrder(List<CartItem> items, double total) {
    addOrderToFirestore(items, total);
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<dynamic>>((ref) {
  return OrdersNotifier();
});

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(firestoreOrdersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        title: const Text('My Orders', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF6B4EFF))),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (orders) => orders.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 80, color: Color(0xFF6B4EFF)),
                    SizedBox(height: 16),
                    Text('No orders yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final items = (order['items'] as List<dynamic>?) ?? [];
                  final total = (order['total'] as num?)?.toDouble() ?? 0;
                  final status = order['status'] as String? ?? 'Processing';
                  final ts = order['createdAt'] as Timestamp?;
                  final date = ts != null ? ts.toDate() : DateTime.now();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ORD-${order['id'].toString().substring(0, 8).toUpperCase()}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            _StatusBadge(status: status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('${items.length} item(s) · \$${total.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('${date.day}/${date.month}/${date.year}',
                            style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                        const SizedBox(height: 12),
                        ...items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '• ${item['title']} x${item['quantity']}',
                            style: const TextStyle(fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'Delivered' => Colors.green,
      'Shipped' => Colors.blue,
      'Cancelled' => Colors.red,
      _ => Colors.orange,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }
}