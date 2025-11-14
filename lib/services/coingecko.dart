import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cryptoapp/models/coin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PricePoint {
  final DateTime time;
  final double price;

  PricePoint(this.time, this.price);
}

class CoinGeckoService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';
  static const String _cacheKey = 'homeData';
  static const String _cacheName = 'cachedData';

  static String get _marketUrl {
    return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=24h";
  }

  static String? get _apiKey => dotenv.env['API_KEY'];

  /// Check if device is online
  static Future<bool> isOnline() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Fetch coins market data with caching
  static Future<List<Coin>> fetchCoinMarkets() async {
    final online = await isOnline();
    late Box<dynamic> box;

    try {
      box = await Hive.openBox(_cacheName);

      if (online) {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        };

        try {
          final response = await http.get(Uri.parse(_marketUrl), headers: headers);

          if (response.statusCode == 200) {
            box.put(_cacheKey, response.body);
            final decoded = jsonDecode(response.body) as List<dynamic>;
            return decoded.map((e) => Coin.fromJson(e as Map<String, dynamic>)).toList();
          } else {
            throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
          }
        } catch (e) {
          debugPrint('❌ Error fetching data: $e');
          debugPrint('Stacktrace: ${StackTrace.current}');

          // Try to use cached data on error
          final cached = box.get(_cacheKey);
          if (cached != null) {
            debugPrint('⚠️ Using cached data due to fetch error.');
            final decoded = jsonDecode(cached) as List<dynamic>;
            return decoded.map((e) => Coin.fromJson(e as Map<String, dynamic>)).toList();
          } else {
            throw Exception('Failed to fetch and no cached data available');
          }
        }
      } else {
        // Offline: use cached data
        final cached = box.get(_cacheKey);
        if (cached != null) {
          final decoded = jsonDecode(cached) as List<dynamic>;
          return decoded.map((e) => Coin.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          throw Exception('No internet and no cached data');
        }
      }
    } finally {
     
    }
  }

  static Future<List<PricePoint>> fetchPriceHistory(String coinId) async {
    final url = Uri.parse('$_baseUrl/coins/$coinId/market_chart?vs_currency=usd&days=7&interval=daily');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch price history');
    }

    final data = json.decode(response.body);
    final List prices = data['prices'];

    return prices.map((point) {
      final timestamp = point[0];
      final price = point[1];
      return PricePoint(
        DateTime.fromMillisecondsSinceEpoch(timestamp),
        (price as num).toDouble(),
      );
    }).toList();
  }
}
