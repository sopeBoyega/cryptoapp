import 'package:cryptoapp/models/coin.dart';



class CoinDummyData {
  static final List<Coin> coins = [
    Coin(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      imageUrl: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
      currentPrice: 97500,
      marketCap: 1920000000000,
      marketCapRank: 1,
      priceChangePercentage24h: 2.45,
    ),
    Coin(
      id: 'ethereum',
      symbol: 'eth',
      name: 'Ethereum',
      imageUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
      currentPrice: 3600,
      marketCap: 432000000000,
      marketCapRank: 2,
      priceChangePercentage24h: 1.82,
    ),
    Coin(
      id: 'cardano',
      symbol: 'ada',
      name: 'Cardano',
      imageUrl: 'https://assets.coingecko.com/coins/images/975/large/cardano.png',
      currentPrice: 108,
      marketCap: 38000000000,
      marketCapRank: 4,
      priceChangePercentage24h: 3.21,
    ),
    Coin(
      id: 'solana',
      symbol: 'sol',
      name: 'Solana',
      imageUrl: 'https://assets.coingecko.com/coins/images/4128/large/solana.png',
      currentPrice: 240,
      marketCap: 82000000000,
      marketCapRank: 5,
      priceChangePercentage24h: -1.15,
    ),
  ];
}