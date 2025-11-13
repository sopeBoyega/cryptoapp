import 'package:cryptoapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// A custom list tile widget to display cryptocurrency information,
class CryptoListTile extends StatefulWidget {
  final String iconSymbol;
  final String? imageUrl;
  final String name;
  final String symbol;
  final String price;
  final double changePercent;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  const CryptoListTile({
    Key? key,
    this.imageUrl,
    this.iconSymbol = "B",
    this.name = "Bitcoin",
    this.symbol = "BTC",
    this.price = "67,234.56",
    this.changePercent = 2.34,
    this.isFavorite = false,
    this.onFavoritePressed,
  }) : super(key: key);

  @override
  State<CryptoListTile> createState() => _CryptoListTileState();
}

class _CryptoListTileState extends State<CryptoListTile> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (!mounted) return;

    setState(() {
      _isOnline = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPositive = widget.changePercent >= 0;
    final Color changeColor =
        isPositive ? Web3Theme.success : Web3Theme.destructive;
    final IconData changeIcon =
        isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Web3Theme.card,
        borderRadius: Web3Theme.borderRadius,
        border: Border.all(color: Web3Theme.border.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // 1. Leading Icon / Image
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Web3Theme.muted,
            ),
            child: _isOnline && widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            widget.name[0].toUpperCase(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Web3Theme.foreground,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      widget.name[0].toUpperCase(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Web3Theme.foreground,
                      ),
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          // 2. Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        widget.name.length < 10 ? widget.name : "Coin",
                        style: GoogleFonts.inter(
                          color: Web3Theme.foreground,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.symbol,
                        style: GoogleFonts.inter(
                          color: Web3Theme.mutedForeground,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${widget.price}",
                  style: GoogleFonts.inter(
                    color: Web3Theme.foreground,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // 3. Trailing Items (Change Chip + Star)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            decoration: BoxDecoration(
              color: changeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(changeIcon, color: changeColor, size: 16),
                const SizedBox(width: 2),
                Text(
                  "${isPositive ? '+' : ''}${widget.changePercent.toStringAsFixed(2)}%",
                  style: GoogleFonts.inter(
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          IconButton(
            icon: Icon(
              widget.isFavorite
                  ? Icons.star
                  : Icons.star_border_outlined,
              color: widget.isFavorite
                  ? Web3Theme.warning
                  : Web3Theme.mutedForeground,
              size: 20,
            ),
            onPressed: widget.onFavoritePressed,
          ),
        ],
      ),
    );
  }
}
