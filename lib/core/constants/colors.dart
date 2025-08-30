// lib/core/constants/colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  // static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryContainer = Color(0xFFDBEAFE);

  // Secondary Colors
  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryDark = Color(0xFF475569);
  static const Color secondaryLight = Color(0xFF94A3B8);
  static const Color secondaryContainer = Color(0xFFF1F5F9);

  // Accent Colors
  static const Color accent = Color(0xFF8B5CF6);
  static const Color accentDark = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFFA78BFA);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successDark = Color(0xFF059669);
  static const Color successLight = Color(0xFF34D399);
  static const Color successContainer = Color(0xFFD1FAE5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningContainer = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorContainer = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF06B6D4);
  static const Color infoDark = Color(0xFF0891B2);
  static const Color infoLight = Color(0xFF22D3EE);
  static const Color infoContainer = Color(0xFFCFFAFE);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF0F172A);
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onSurfaceVariant = Color(0xFF64748B);
  static const Color onError = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF334155);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFF94A3B8);

  // Border Colors
  static const Color borderPrimary = Color(0xFFE2E8F0);
  static const Color borderSecondary = Color(0xFFCBD5E1);
  static const Color borderFocus = Color(0xFF2563EB);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Overlay Colors
  static const Color overlay = Color(0x66000000);
  static const Color scrim = Color(0x52000000);

  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
  );

  static const Gradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF64748B), Color(0xFF475569)],
  );

  static const Gradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color google = Color(0xFFDB4437);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color linkedin = Color(0xFF0A66C2);

  // Additional Utility Colors
  static const blue = Color(0xFF1E88E5);
  static const primary = Color(0xFF1E88E5);
  static const green = Color(0xFF3ED15F);
  static const white = Color(0xFFFFFFFF);
  static const whiteBackground = Color(0xFFF6F6F6);
  static const black = Color(0xFF121212);
  // static const accent = Color(0xFFEF4848);
  static const greyBack = Color(0xFFF6F6F6);

  // Material Color for theming
  static MaterialColor primarySwatch = MaterialColor(primary.value, {
    50: Color(0xFFEFF6FF),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFBFDBFE),
    300: Color(0xFF93C5FD),
    400: Color(0xFF60A5FA),
    500: primary,
    600: Color(0xFF2563EB),
    700: Color(0xFF1D4ED8),
    800: Color(0xFF1E40AF),
    900: Color(0xFF1E3A8A),
  });

  // Dark Theme Colors (optional - if you support dark mode)
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);
  static const Color darkOnBackground = Color(0xFFF1F5F9);
  static const Color darkOnSurface = Color(0xFFF1F5F9);
  static const Color darkBorder = Color(0xFF475569);

  // Helper methods
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color, {bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';

  // Opacity variants
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Common color combinations
  static Color get shimmerBase => Colors.grey.shade300;
  static Color get shimmerHighlight => Colors.grey.shade100;

  static Color get divider => borderPrimary;
  static Color get disabled => textDisabled;

  // Semantic colors for specific use cases
  static Color get buttonPrimary => primary;
  static Color get buttonSecondary => surface;
  static Color get buttonDisabled => textDisabled;

  static Color get cardBackground => surface;
  static Color get cardShadow => shadowLight;

  static Color get inputBackground => surface;
  static Color get inputBorder => borderPrimary;
  static Color get inputFocusBorder => borderFocus;
  static Color get inputErrorBorder => error;

  static Color get chipBackground => surfaceVariant;
  static Color get chipSelectedBackground => primaryContainer;

  static Color get progressBackground => surfaceVariant;
  static Color get progressValue => primary;
}

// Extension for easy color access
extension ColorExtension on Color {
  Color get lighten => withOpacity(0.7);
  Color get darken => withOpacity(0.3);
  Color get extraLight => withOpacity(0.1);

  Color withBrightness(double factor) {
    assert(factor >= 0 && factor <= 2);
    return Color.fromARGB(
      alpha,
      (red * factor).clamp(0, 255).toInt(),
      (green * factor).clamp(0, 255).toInt(),
      (blue * factor).clamp(0, 255).toInt(),
    );
  }
}
