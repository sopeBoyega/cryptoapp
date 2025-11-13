import 'package:cryptoapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isPositive;
  final bool isPriceInfo;

  const InfoCard({
    Key? key,
    required this.title,
    required this.value,
    this.isPriceInfo = true,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine colors and icon based on the 'isPositive' flag
    final Color valueColor =
        isPositive ? Web3Theme.success : Web3Theme.destructive;
    final Color iconBgColor = valueColor.withOpacity(0.15);
    final IconData iconData =
        isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      margin: EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Web3Theme.card,
        borderRadius: Web3Theme.borderRadius,
        border: Border.all(color: Web3Theme.border.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Left Column: Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (e.g., "24h Change")
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Web3Theme.mutedForeground,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                // Value (e.g., "+2.34%")
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Web3Theme.foreground,
                    fontSize: 22, // Larger font size for emphasis
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // 2. Right Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isPriceInfo ? iconBgColor : const Color.fromARGB(147, 68, 147, 212) ,
              shape: BoxShape.circle,
            ),
            child: isPriceInfo ?  Icon(
              iconData,
              color: valueColor,
              size: 24,
            ) : Icon(
              iconData,
              color: const Color.fromARGB(255, 79, 167, 240),
              size: 24,
            ) ,
          ),
        ],
      ),
    );
  }
}