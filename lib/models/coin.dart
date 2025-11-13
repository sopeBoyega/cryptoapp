
class Coin {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double currentPrice;
  final double high24;
  final double low24;
  final double marketCap;
  final int marketCapRank;
  final double priceChangePercentage24h;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.high24,
    required this.low24,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    // Accept both snake_case (API) and camelCase keys
    num? _getNum(dynamic v) => v is num ? v : (v == null ? null : num.tryParse(v.toString()));
    return Coin(
      id: json['id'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['image'] as String? ?? json['imageUrl'] as String? ?? '',
      currentPrice: (_getNum(json['current_price'] ?? json['currentPrice']) ?? 0).toDouble(),
      low24: (_getNum(json['high_24h'] ?? json['high_24h']) ?? 0).toDouble(),
      high24: (_getNum(json['low_24h'] ?? json['low_24h']) ?? 0).toDouble(),
      marketCap: (_getNum(json['market_cap'] ?? json['marketCap']) ?? 0).toDouble(),
      marketCapRank: (_getNum(json['market_cap_rank'] ?? json['marketCapRank']) ?? 0).toInt(),
      priceChangePercentage24h: (_getNum(json['price_change_percentage_24h'] ?? json['priceChangePercentage24h']) ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': imageUrl,
      'current_price': currentPrice,
      'low_24': low24,
      'high_24': high24,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }
}