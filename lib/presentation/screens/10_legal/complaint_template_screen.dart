import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../widgets/common/ts_app_bar.dart';

class ComplaintTemplateScreen extends StatelessWidget {
  const ComplaintTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Complaint Template'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_rounded,
              size: 80,
              color: AppColors.accentCyan,
            ),
            const SizedBox(height: 24),
            Text(
              'Complaint Template',
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
