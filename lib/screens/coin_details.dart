import 'package:cryptoapp/models/coin.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/widgets/info_card.dart';
import 'package:cryptoapp/widgets/price_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CoinDetails extends StatefulWidget {
  const CoinDetails({super.key, required this.coin});

  final Coin coin;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPositive = widget.coin.priceChangePercentage24h >= 0;
    final Color changeColor =
        isPositive ? Web3Theme.success : Web3Theme.destructive;
    final IconData changeIcon =
        isPositive ? Icons.trending_up : Icons.trending_down;

    return Scaffold(
      backgroundColor: Web3Theme.background,
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
                    stops: const [0.0, 0.5, 1.0],
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
                  constraints: const BoxConstraints(maxWidth: 1024.0),
                  height: 384.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Web3Theme.primary.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Back button
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Web3Theme.foreground,
                          ),
                        ),
                        Text(
                          "Back",
                          style: GoogleFonts.inter(
                            color: Web3Theme.foreground,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    // Coin details card
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Web3Theme.card,
                        borderRadius: Web3Theme.borderRadius,
                        border: Border.all(
                          color: Web3Theme.border.withOpacity(0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Coin header (image + name)
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Web3Theme.muted,
                                ),
                                child: _isOnline &&
                                        widget.coin.imageUrl.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          widget.coin.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Text(
                                                widget.coin.name[0]
                                                    .toUpperCase(),
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  color: Web3Theme.foreground,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          widget.coin.name[0].toUpperCase(),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            color: Web3Theme.foreground,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 7),

                              // Coin name + symbol
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.coin.name ,
                                      style: GoogleFonts.inter(
                                        color: Web3Theme.foreground,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.coin.symbol.toUpperCase(),
                                      style: GoogleFonts.inter(
                                        color: Web3Theme.mutedForeground,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Current Price
                          Text(
                            "\$${widget.coin.currentPrice}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = Web3Theme.gradientPrimary
                                    .createShader(
                                  const Rect.fromLTWH(50, 0, 200, 40),
                                ),
                            ),
                          ),

                          // Price Change
                          Row(
                            children: [
                              Icon(changeIcon, color: changeColor, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                "${isPositive ? '+' : ''}${widget.coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                                style: GoogleFonts.inter(
                                  color: changeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Info cards
                    InfoCard(title: "24hr high", value: widget.coin.high24.toStringAsFixed(2)),
                    InfoCard(title: "24hr low", value: widget.coin.low24.toStringAsFixed(2)),
                    InfoCard(title: "24hr change", value: "${isPositive ? '+' : ''}${widget.coin.priceChangePercentage24h.toStringAsFixed(2)}%",),
                    InfoCard(
                      title: "Market Cap",
                      value: "\$${widget.coin.marketCap}",
                      isPriceInfo: false,
                    ),
                    InfoCard(
                      title: "Market Cap Rank",
                      value: "${widget.coin.marketCapRank}",
                      isPriceInfo: false,
                    ),
                    _isOnline ? PriceChart(coinId: widget.coin.id) : Center(child: Text("Please connect to the internet to see the chart."),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
