import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/scale_animation.dart';
import '../../../core/animations/fade_animation.dart';
import '../../providers/report_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Report पठाइयो'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleAnimation(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success.withOpacity(0.1),
                    border: Border.all(
                        color: AppColors.success.withOpacity(0.4), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withOpacity(0.3),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded,
                      color: AppColors.success, size: 64),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FadeAnimation(
                delay: const Duration(milliseconds: 300),
                child: Text('✅ Report पठाइयो!',
                    style: AppTypography.displayMedium,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: AppSpacing.md),
              FadeAnimation(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  'धन्यवाद! तपाईंको report ले अरू हजारौं नेपालीहरूलाई ठगीबाट बचाउन मद्दत गर्छ।',
                  style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FadeAnimation(
                delay: const Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.verified_rounded,
                          AppColors.accentCyan, 'Report verified हुँदैछ'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.people_rounded,
                          AppColors.gold, 'Community लाई alert जान्छ'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.security_rounded,
                          AppColors.success, 'Database मा add हुन्छ'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FadeAnimation(
                delay: const Duration(milliseconds: 600),
                child: GestureDetector(
                  onTap: () {
                    context.read<ReportProvider>().reset();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed,
                      borderRadius:
                          BorderRadius.circular(AppRadius.button),
                    ),
                    child: Center(
                      child: Text('होम मा फिर्ता जानुस्',
                          style: AppTypography.buttonPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: AppSpacing.sm),
        Text(text,
            style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary)),
      ],
    );
  }
}
