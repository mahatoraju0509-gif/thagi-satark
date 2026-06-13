import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../widgets/common/ts_app_bar.dart';

class LegalDetailScreen extends StatelessWidget {
  const LegalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'कानुनी विवरण'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gavel_rounded,
              size: 80,
              color: AppColors.success,
            ),
            const SizedBox(height: 24),
            Text(
              'कानुनी विवरण',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon...',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
