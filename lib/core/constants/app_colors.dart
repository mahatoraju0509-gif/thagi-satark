import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background
  static const Color background = Color(0xFF0A0A0A);
  static const Color surfaceDark = Color(0xFF141414);
  static const Color surfaceMedium = Color(0xFF1E1E1E);
  static const Color surfaceLight = Color(0xFF2A2A2A);

  // Primary - Red (Danger/Alert)
  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color primaryRedLight = Color(0xFFE53935);
  static const Color primaryRedDark = Color(0xFF7F0000);
  static const Color primaryRedGlow = Color(0x80B71C1C);

  // Secondary - Cyan (Tech/Trust)
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentCyanLight = Color(0xFF80F4FF);
  static const Color accentCyanGlow = Color(0x4D00E5FF);

  // Cultural - Gold/Saffron (Nepali)
  static const Color gold = Color(0xFFFFD700);
  static const Color saffron = Color(0xFFFF6F00);
  static const Color goldGlow = Color(0x4DFFD700);

  // Status
  static const Color success = Color(0xFF00C853);
  static const Color successLight = Color(0xFF69F0AE);
  static const Color warning = Color(0xFFFF6D00);
  static const Color warningLight = Color(0xFFFFAB40);
  static const Color danger = Color(0xFFD50000);
  static const Color safe = Color(0xFF00BFA5);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textHint = Color(0xFF607D8B);
  static const Color textDisabled = Color(0xFF455A64);

  // Border
  static const Color borderDark = Color(0xFF263238);
  static const Color borderMedium = Color(0xFF37474F);
  static const Color borderRed = Color(0x4DB71C1C);
  static const Color borderCyan = Color(0x4D00E5FF);

  // Severity Colors
  static const Color severityHigh = Color(0xFFD50000);
  static const Color severityMedium = Color(0xFFFF6D00);
  static const Color severityLow = Color(0xFFFFD600);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryRedDark, primaryRed, primaryRedLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [background, surfaceDark, surfaceMedium],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [saffron, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF0D47A1), accentCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [background, Color(0x00000000)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}
