import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptoapp/provider/coin_provider.dart';
import 'package:cryptoapp/screens/coin_details.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/widgets/app_icon.dart';
import 'package:cryptoapp/widgets/list_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Web3Theme.background,
      appBar: AppBar(
        backgroundColor: Web3Theme.background,
        leading: GradientIcon(containerSize: 10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favorite Coins",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = Web3Theme.gradientPrimary
                      .createShader(Rect.fromLTWH(0, 0, 200, 40)),
              ),
            ),
            Text(
              "Your saved cryptocurrencies",
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Web3Theme.background,
                      Web3Theme.background,
                      Web3Theme.card,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Top overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: true,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1024.0),
                  height: 384.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Web3Theme.primary.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Positioned.fill(
            child: Consumer<CoinProvider>(
              builder: (context, coinProvider, child) {
                final favorites = coinProvider.favorites;

                if (favorites.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 64,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No favorites yet",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add coins to see them here",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final currentCoin = favorites[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CoinDetails(coin: currentCoin),
                          ),
                        );
                      },
                      child: CryptoListTile(
                        name: currentCoin.name,
                        price: currentCoin.currentPrice.toStringAsFixed(2),
                        changePercent: currentCoin.priceChangePercentage24h,
                        symbol: currentCoin.symbol.toUpperCase(),
                        imageUrl: currentCoin.imageUrl,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
