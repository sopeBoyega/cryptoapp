import 'package:cryptoapp/models/coin.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/widgets/app_icon.dart';
import 'package:cryptoapp/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinDetails extends StatefulWidget {
  const CoinDetails({super.key, required this.coin});

  final Coin coin;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  @override
  Widget build(BuildContext context) {
    final bool isPositive = widget.coin.priceChangePercentage24h >= 0;
    final Color changeColor = isPositive
        ? Web3Theme.success
        : Web3Theme.destructive;
    final IconData changeIcon = isPositive
        ? Icons.trending_up
        : Icons.trending_down;
    return Scaffold(
      backgroundColor: Web3Theme.background,
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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

                    Container(
                      margin: EdgeInsets.all(8),
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
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Web3Theme.muted,
                                  // boxShadow: Web3Theme.shadowNeonCyan,
                                ),
                                child: Center(
                                  child: Image.network(
                                    widget.coin.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(width: 7),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.coin.name,
                                      style: GoogleFonts.inter(
                                        color: Web3Theme.foreground,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    const SizedBox(height: 4),
                                    // Subtitle (Price)
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
                          SizedBox(height: 20),
                          Text(
                            "\$${widget.coin.currentPrice}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = Web3Theme.gradientPrimary
                                    .createShader(
                                      Rect.fromLTWH(50, 0, 200, 40),
                                    ),
                            ),
                          ),

                          Row(
                            children: [
                              Icon(changeIcon, color: changeColor, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                "${isPositive ? '+' : ''}${widget.coin.priceChangePercentage24h}%",
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

                    InfoCard(title: "24hr high", value: "2.45"),
                    InfoCard(title: "24hr low", value: "2.00"),
                    InfoCard(title: "24hr change", value: "1.50%"),
                    InfoCard(title: "Market Cap", value: "\$1316.00B", isPriceInfo: false,),
                    InfoCard(title: "Market Cap", value: "\$1316.00B", isPriceInfo: false,)
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
