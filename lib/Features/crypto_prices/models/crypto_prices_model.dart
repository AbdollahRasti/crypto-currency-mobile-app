class CryptoPricesModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  int marketCap;
  int marketCapRank;
  int totalVolume;
  double high24H;
  double low24H;
  double priceChange24H;
  double priceChangePercentage24H;
  double marketCapChange24H;
  double marketCapChangePercentage24H;
  DateTime lastUpdated;

  CryptoPricesModel({
    required this.id,
    required this.name,
    required this.currentPrice,
    required this.symbol,
    required this.image,
    required this.marketCap,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.lastUpdated,
  });

  factory CryptoPricesModel.fromJson(Map<String, dynamic> json) {
    return CryptoPricesModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      symbol: json['symbol'] ?? '',
      image: json['image'] ?? '',
      marketCap: json['market_cap'] ?? 0,
      marketCapRank: json['market_cap_rank'] ?? 0,
      totalVolume: json['total_volume'] ?? 0,
      high24H: (json['high_24h'] as num?)?.toDouble() ?? 0.0,
      low24H: (json['low_24h'] as num?)?.toDouble() ?? 0.0,
      priceChange24H: (json['price_change_24h'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24H:
          (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      marketCapChange24H:
          (json['market_cap_change_24h'] as num?)?.toDouble() ?? 0.0,
      marketCapChangePercentage24H:
          (json['market_cap_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      lastUpdated:
          DateTime.tryParse(json['last_updated'] ?? '') ?? DateTime.now(),
    );
  }
}
