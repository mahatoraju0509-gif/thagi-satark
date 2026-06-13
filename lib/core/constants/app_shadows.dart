import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x99000000),
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glowRed = [
    BoxShadow(
      color: AppColors.primaryRedGlow,
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> glowCyan = [
    BoxShadow(
      color: AppColors.accentCyanGlow,
      blurRadius: 15,
      spreadRadius: 1,
    ),
  ];

  static const List<BoxShadow> glowGold = [
    BoxShadow(
      color: AppColors.goldGlow,
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> button = [
    BoxShadow(
      color: AppColors.primaryRedGlow,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Color(0x99000000),
      blurRadius: 24,
      offset: Offset(0, -4),
    ),
  ];
}
