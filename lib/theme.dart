import 'package:flutter/material.dart';
import 'dart:ui'; // Required for ImageFilter.blur


/// This class holds all the color constants, gradients, and shadow definitions.
/// It also provides a pre-configured [ThemeData] object via [darkTheme].
class Web3Theme {
  // Prevent instantiation
  Web3Theme._();

  // Helper function for HSL to Color conversion
  // CSS HSL format: H(0-360), S(0-100%), L(0-100%)
  // Flutter HSLColor format: H(0-360), S(0.0-1.0), L(0.0-1.0)
  static Color _hsl(double h, double s, double l, [double a = 1.0]) {
    return HSLColor.fromAHSL(a, h, s / 100, l / 100).toColor();
  }



  /* Web3 Dark Theme */
  static final Color background = _hsl(220, 40, 6);
  static final Color foreground = _hsl(180, 100, 95);

  static final Color card = _hsl(220, 35, 10);
  static final Color cardForeground = _hsl(180, 100, 95);

  static final Color popover = _hsl(220, 35, 12);
  static final Color popoverForeground = _hsl(180, 100, 95);

  /* Neon Cyan Primary */
  static final Color primary = _hsl(187, 100, 50);
  static final Color primaryForeground = _hsl(220, 40, 6);

  /* Deep Purple Secondary */
  static final Color secondary = _hsl(262, 83, 58);
  static final Color secondaryForeground = _hsl(180, 100, 95);

  static final Color muted = _hsl(220, 30, 15);
  static final Color mutedForeground = _hsl(180, 20, 60);

  /* Electric Accent */
  static final Color accent = _hsl(330, 100, 60);
  static final Color accentForeground = _hsl(220, 40, 6);

  static final Color destructive = _hsl(0, 85, 60);
  static final Color destructiveForeground = _hsl(180, 100, 95);

  static final Color border = _hsl(220, 30, 18);
  static final Color input = _hsl(220, 30, 15);
  static final Color ring = _hsl(187, 100, 50); 

  /* Success/Error States */
  static final Color success = _hsl(142, 76, 36);
  static final Color successForeground = _hsl(180, 100, 95);
  static final Color warning = _hsl(38, 92, 50);
  static final Color warningForeground = _hsl(220, 40, 6);

  /* Glass Effect */
  static final Color glassBg = _hsl(220, 35, 12, 0.7);
  static final Color glassBorder = _hsl(180, 100, 80, 0.1);

  // --- GRADIENTS ---

  /// --gradient-primary: linear-gradient(135deg, hsl(187 100% 50%), hsl(262 83% 58%));
  /// 135deg in CSS is from top-left to bottom-right.
  static  LinearGradient gradientPrimary = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// --gradient-card: linear-gradient(135deg, hsl(220 35% 10% / 0.6), hsl(220 35% 12% / 0.8));
  static final LinearGradient gradientCard = LinearGradient(
    colors: [card.withOpacity(0.6), popover.withOpacity(0.8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// --gradient-glow: radial-gradient(circle at 50% 0%, hsl(187 100% 50% / 0.15), transparent 70%);
  static final RadialGradient gradientGlow = RadialGradient(
    center: const Alignment(0.0, -1.0), // 50% 0%
    colors: [primary.withOpacity(0.15), Colors.transparent],
    stops: const [0.0, 0.7], // 0% and 70%
  );

  // --- SHADOWS ---

  /// --shadow-neon-cyan: 0 0 20px hsl(187 100% 50% / 0.3), 0 0 40px hsl(187 100% 50% / 0.1);
  static final List<BoxShadow> shadowNeonCyan = [
    BoxShadow(
      color: primary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: primary.withOpacity(0.1),
      blurRadius: 40,
      spreadRadius: 0,
    ),
  ];

  /// --shadow-neon-purple: 0 0 20px hsl(262 83% 58% / 0.3), 0 0 40px hsl(262 83% 58% / 0.1);
  static final List<BoxShadow> shadowNeonPurple = [
    BoxShadow(
      color: secondary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: secondary.withOpacity(0.1),
      blurRadius: 40,
      spreadRadius: 0,
    ),
  ];

  /// --shadow-glow: 0 4px 24px hsl(187 100% 50% / 0.1);
  static final List<BoxShadow> shadowGlow = [
    BoxShadow(
      color: primary.withOpacity(0.1),
      blurRadius: 24,
      offset: const Offset(0, 4),
    ),
  ];

  // --- DECORATIONS (for convenience) ---

  /// A decoration for a 'glow-cyan' container.
  static BoxDecoration get glowCyanDecoration => BoxDecoration(
        boxShadow: shadowNeonCyan,
      );

  /// A decoration for a 'glow-purple' container.
  static BoxDecoration get glowPurpleDecoration => BoxDecoration(
        boxShadow: shadowNeonPurple,
      );

  /// A decoration for a 'gradient-primary' container.
  static BoxDecoration get gradientPrimaryDecoration => BoxDecoration(
        gradient: gradientPrimary,
      );

  /// --radius: 1rem; (Assuming 1rem = 16.0)
  static final double radius = 16.0;
  static final BorderRadius borderRadius = BorderRadius.circular(radius);

  /// Provides the [BoxDecoration] for a glass card, *without* the blur filter.
  /// To get the full glass effect, wrap your child in:
  ///
  /// ```dart
  /// ClipRRect(
  ///   borderRadius: Web3Theme.borderRadius,
  ///   child: BackdropFilter(
  ///     filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
  ///     child: Container(
  ///       decoration: Web3Theme.glassCardDecoration,
  ///       child: YourContent(),
  ///     ),
  ///   ),
  /// )
  /// ```
  static final BoxDecoration glassCardDecoration = BoxDecoration(
    color: glassBg,
    border: Border.all(color: glassBorder, width: 1.0),
    borderRadius: borderRadius,
  );

  // --- FLUTTER THEME DATA ---

  /// The main dark theme [ThemeData] for the app.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
   // Example font, replace with your app's font
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    cardColor: card,
    dividerColor: border,
    hintColor: mutedForeground,
    dialogBackgroundColor: popover,

    // The new ColorScheme, mapped from your variables
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: primaryForeground,
      secondary: secondary,
      onSecondary: secondaryForeground,
      error: destructive,
      onError: destructiveForeground,
      background: background,
      onBackground: foreground,
      surface: card, // Use 'card' for surface
      onSurface: cardForeground, // Use 'cardForeground' for onSurface
      tertiary: accent, // Mapped 'accent' to 'tertiary'
      onTertiary: accentForeground,
      surfaceVariant: popover, // Mapped 'popover'
      onSurfaceVariant: popoverForeground,
      outline: border,
      shadow: shadowGlow.first.color.withOpacity(1.0),
      inverseSurface: foreground,
      onInverseSurface: background,
      primaryContainer: primary.withOpacity(0.2), // Generated
      onPrimaryContainer: primary, // Generated
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(color: foreground),
      displayMedium: TextStyle(color: foreground),
      displaySmall: TextStyle(color: foreground),
      headlineLarge: TextStyle(color: foreground),
      headlineMedium: TextStyle(color: foreground),
      headlineSmall: TextStyle(color: foreground),
      titleLarge: TextStyle(color: foreground),
      titleMedium: TextStyle(color: foreground),
      titleSmall: TextStyle(color: foreground),
      bodyLarge: TextStyle(color: foreground),
      bodyMedium: TextStyle(color: mutedForeground),
      bodySmall: TextStyle(color: mutedForeground.withOpacity(0.8)),
      labelLarge: TextStyle(color: primary, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(color: mutedForeground),
      labelSmall: TextStyle(color: mutedForeground),
    ),

    // Component Themes
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: foreground,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: shadowGlow.first.color,
      iconTheme: IconThemeData(color: foreground),
      actionsIconTheme: IconThemeData(color: mutedForeground),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: input,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      hintStyle: TextStyle(color: mutedForeground),
      labelStyle: TextStyle(color: mutedForeground),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: ring, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: destructive, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: destructive, width: 2.0),
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary.withOpacity(0.3),
      selectionHandleColor: primary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: primaryForeground,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: border),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: popover,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: border),
      ),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: popover,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: border),
      ),
      elevation: 8.0,
      textStyle: TextStyle(color: popoverForeground),
    ),
  );
}