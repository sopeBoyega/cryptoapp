import 'package:cryptoapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// A custom list tile widget to display cryptocurrency information,
class CryptoListTile extends StatelessWidget {
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
    this.price = "\$67,234.56",
    this.changePercent = 2.34,
    this.isFavorite = false,
    this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine color based on positive or negative change
    final bool isPositive = changePercent >= 0;
    final Color changeColor = isPositive ? Web3Theme.success : Web3Theme.destructive;
    final IconData changeIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      margin: EdgeInsets.all(8),
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
        // 1. Leading Icon (Bitcoin 'B')
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Web3Theme.muted, 
            // boxShadow: Web3Theme.shadowNeonCyan, 
          ),
          child: Center(
            child: Image.network(imageUrl!, fit: BoxFit.cover,),
          ),
        ),
        const SizedBox(width: 12),

          // 2. Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                Row(
                  children: [
                    Text(
                      name.length < 14 ? name : "Coin",
                      style: GoogleFonts.inter(
                        color: Web3Theme.foreground,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      symbol,
                      style: GoogleFonts.inter(
                        color: Web3Theme.mutedForeground,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Subtitle (Price)
                Text(
                  "\$${price}",
                  style: GoogleFonts.inter(
                    color: Web3Theme.foreground,
                    fontSize: 18, // Note: Larger than the title
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // 3. Trailing Items (Chip & Star)

          // Percentage Change Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            decoration: BoxDecoration(
              color: changeColor.withOpacity(0.15), // Soft background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(changeIcon, color: changeColor, size: 16),
                const SizedBox(width: 1),
                Text(
                  "${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%",
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

          // Star Icon
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border_outlined,
              color: isFavorite ? Web3Theme.warning : Web3Theme.mutedForeground,
              size: 20,
            ),
            onPressed: onFavoritePressed,
          ),
        ],
      ),
    );
  }
}

