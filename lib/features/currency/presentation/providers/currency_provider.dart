import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final currencyProvider = FutureProvider<Map<String, double>>((ref) async {
  try {
    final response = await http.get(
      Uri.parse('https://open.er-api.com/v6/latest/USD'),
    ).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rates = data['rates'] as Map<String, dynamic>;
      return {
        'EUR': (rates['EUR'] as num).toDouble(),
        'GBP': (rates['GBP'] as num).toDouble(),
        'KZT': (rates['KZT'] as num).toDouble(),
        'RUB': (rates['RUB'] as num).toDouble(),
      };
    }
  } catch (_) {}
  // fallback rates
  return {'EUR': 0.92, 'GBP': 0.79, 'KZT': 450.0, 'RUB': 89.5};
});