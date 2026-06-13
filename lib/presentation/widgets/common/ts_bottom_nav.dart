import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_routes.dart';

class TsBottomNav extends StatelessWidget {
  final int currentIndex;

  const TsBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        boxShadow: AppShadows.bottomNav,
        border: const Border(
          top: BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryRed,
        unselectedItemColor: AppColors.textHint,
        selectedLabelStyle: AppTypography.labelSmall.copyWith(
          color: AppColors.primaryRed,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.labelSmall,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'होम'),
          BottomNavigationBarItem(
              icon: Icon(Icons.psychology_rounded), label: 'AI'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: 'पुस्तिका'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user_rounded), label: 'Verify'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_rounded), label: 'थप'),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.aiChecker);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.encyclopedia);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.verify);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.settings);
        break;
    }
  }
}
