import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Both fonts via Google Fonts
  static TextStyle get _nepali => GoogleFonts.notoSansDevanagari();
  static TextStyle get _english => GoogleFonts.poppins();

  // Display
  static TextStyle get displayLarge => GoogleFonts.notoSansDevanagari(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => GoogleFonts.notoSansDevanagari(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Headline
  static TextStyle get headlineLarge => GoogleFonts.notoSansDevanagari(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get headlineMedium => GoogleFonts.notoSansDevanagari(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Title
  static TextStyle get titleLarge => GoogleFonts.notoSansDevanagari(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get titleMedium => GoogleFonts.notoSansDevanagari(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.notoSansDevanagari(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.notoSansDevanagari(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  // Label
  static TextStyle get labelLarge => GoogleFonts.notoSansDevanagari(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get labelSmall => GoogleFonts.notoSansDevanagari(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.4,
  );

  // English styles (Poppins)
  static TextStyle get englishDisplayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get englishHeadline => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get englishTitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get englishBody => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get englishLabel => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );

  // Special
  static TextStyle get appLogoNepali => GoogleFonts.notoSansDevanagari(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );

  static TextStyle get appLogoEnglish => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.accentCyan,
    letterSpacing: 3.0,
  );

  static TextStyle get alertText => GoogleFonts.notoSansDevanagari(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.danger,
    height: 1.5,
  );

  static TextStyle get successText => GoogleFonts.notoSansDevanagari(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
    height: 1.5,
  );

  static TextStyle get highlightText => GoogleFonts.notoSansDevanagari(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
    height: 1.5,
  );

  static TextStyle get redFlagText => GoogleFonts.notoSansDevanagari(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryRedLight,
    height: 1.6,
  );

  static TextStyle get disclaimerText => GoogleFonts.notoSansDevanagari(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.6,
    fontStyle: FontStyle.italic,
  );

  static TextStyle get buttonPrimary => GoogleFonts.notoSansDevanagari(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get buttonEnglish => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
}
