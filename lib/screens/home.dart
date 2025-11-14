import 'package:cryptoapp/data/dummy_data.dart';
import 'package:cryptoapp/models/coin.dart';
import 'package:cryptoapp/screens/coin_details.dart';
import 'package:cryptoapp/screens/favorites.dart';
import 'package:cryptoapp/services/coingecko.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/widgets/app_icon.dart';
import 'package:cryptoapp/widgets/list_tile.dart';
import 'package:cryptoapp/provider/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Coin>> _loadedCoins;

  @override
  void initState() {
    super.initState();
    _loadedCoins = CoinGeckoService.fetchCoinMarkets();
  }

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
              "Crypto Wallet App",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = Web3Theme.gradientPrimary.createShader(
                    Rect.fromLTWH(0, 0, 200, 40),
                  ),
              ),
            ),
            Text(
              "Web 3 Portfolio Tracker",
              style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => FavoritesPage()));
            },
            icon: Icon(Icons.favorite_outline_outlined, color: Colors.white),
          ),
        ],
      ),

      body: Stack(
        children: [
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

          Positioned.fill(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                //   child: Container(
                //     constraints: BoxConstraints(maxWidth: 1024.0),
                //     decoration: BoxDecoration(
                //       color: Web3Theme.card,
                //       borderRadius: BorderRadius.circular(12.0),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.12),
                //           blurRadius: 8,
                //           offset: Offset(0, 2),
                //         ),
                //       ],
                //       border: Border.all(
                //         width: 1,
                //         color: Web3Theme.primary.withOpacity(0.08),
                //       ),
                //     ),
                //     child: TextField(
                //       onChanged: (val) {
                //         setState(() {
                //            var _searchQuery = val;
                //         });
                //       },
                //       style: GoogleFonts.inter(color: Colors.white),
                //       cursorColor: Web3Theme.primary,
                //       decoration: InputDecoration(
                //         prefixIcon: Padding(
                //           padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                //           child: Icon(Icons.search, color: Web3Theme.primary),
                //         ),
                //         prefixIconConstraints: BoxConstraints(minWidth: 40),
                //         hintText: 'Search coins (name or symbol)',
                //         hintStyle: GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 14),
                //         border: InputBorder.none,
                //         contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: FutureBuilder<List<Coin>>(
                    future: _loadedCoins,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Unable to load data and no cache found.",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final coins = snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.all(5.0),
                          itemCount: coins.length,
                          itemBuilder: (context, index) {
                            final currentCoin = coins[index];
                            return Consumer<CoinProvider>(
                              builder: (context, coinProvider, _) {
                                final isFav = coinProvider.isFavorite(
                                  currentCoin,
                                );
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            CoinDetails(coin: currentCoin),
                                      ),
                                    );
                                  },
                                  child: CryptoListTile(
                                    name: currentCoin.name,
                                    price: currentCoin.currentPrice
                                        .ceil()
                                        .toStringAsFixed(2),
                                    changePercent:
                                        currentCoin.priceChangePercentage24h,
                                    symbol: currentCoin.symbol.toUpperCase(),
                                    imageUrl: currentCoin.imageUrl,
                                    isFavorite: isFav,
                                    onFavoritePressed: () {
                                      if (isFav) {
                                        coinProvider.removeFavorite(
                                          currentCoin,
                                        );
                                      } else {
                                        coinProvider.addFavorite(currentCoin);
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No data, Please check your internet connection',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
