import 'package:flutter/material.dart';
import 'package:cryptoapp/theme.dart';

/// A circular widget with the primary gradient and cyan glow,
/// containing a centered icon.
class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key? key,
    this.icon = Icons.account_balance_wallet, // Placeholder for <Wallet />
    this.iconSize = 24.0,
    this.containerSize = 48.0,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final double containerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,  // w-12 (48px)
      height: containerSize, // h-12 (48px)
      decoration: BoxDecoration(
        shape: BoxShape.circle, // rounded-full
        gradient: Web3Theme.gradientPrimary, // bg-gradient-primary
        boxShadow: Web3Theme.shadowNeonCyan, // glow-cyan
      ),
      // flex items-center justify-center
      child: Icon(
        icon,
        size: iconSize, // w-6 h-6 (24px)
        color: Web3Theme.primaryForeground, // text-primary-foreground
      ),
    );
  }
}

