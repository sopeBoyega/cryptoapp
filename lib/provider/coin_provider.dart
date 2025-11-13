import 'package:flutter/material.dart';
import 'package:cryptoapp/models/coin.dart';

class CoinProvider extends ChangeNotifier {
  final List<Coin> _favorites = [];

  List<Coin> get favorites => _favorites;

  void addFavorite(Coin coin) {
    if (!_favorites.any((c) => c.id == coin.id)) {
      _favorites.add(coin);
      notifyListeners();
    }
  }

  void removeFavorite(Coin coin) {
    _favorites.removeWhere((c) => c.id == coin.id);
    notifyListeners();
  }

  bool isFavorite(Coin coin) {
    return _favorites.any((c) => c.id == coin.id);
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
