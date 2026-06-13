import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/fade_animation.dart';
import '../../../core/animations/slide_animation.dart';
import '../../../data/models/alert_model.dart';
import '../../widgets/common/ts_app_bar.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alert = ModalRoute.of(context)?.settings.arguments as AlertModel?;

    if (alert == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: TsAppBar(title: 'सतर्कता विवरण'),
        body: const Center(child: Text('Data भेटिएन')),
      );
    }

    final color = _getSeverityColor(alert.severity);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'सतर्कता विवरण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            FadeAnimation(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                      color: color.withOpacity(0.4), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            _getSeverityLabel(alert.severity),
                            style: AppTypography.labelSmall.copyWith(
                                color: color),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _timeAgo(alert.createdAt),
                          style: AppTypography.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(alert.titleNp,
                        style: AppTypography.headlineMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Text(alert.descriptionNp,
                        style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Details
            SlideAnimation(
              delay: const Duration(milliseconds: 100),
              child: _buildDetailCard(
                icon: Icons.location_on_rounded,
                color: color,
                title: 'जिल्ला',
                content: alert.district,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            SlideAnimation(
              delay: const Duration(milliseconds: 200),
              child: _buildDetailCard(
                icon: Icons.category_rounded,
                color: AppColors.accentCyan,
                title: 'ठगीको प्रकार',
                content: alert.fraudType,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // What to do
            SlideAnimation(
              delay: const Duration(milliseconds: 300),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                      color: AppColors.success.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield_rounded,
                            color: AppColors.success, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Text('अब के गर्ने?',
                            style: AppTypography.titleMedium.copyWith(
                                color: AppColors.success)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildActionItem('सावधान रहनुस् र परिवारलाई पनि जानकारी दिनुस्'),
                    _buildActionItem('Unknown call/message मा respond नगर्नुस्'),
                    _buildActionItem('Advance पैसा नदिनुस्'),
                    _buildActionItem('थप जानकारीको लागि Cyber Bureau: 9851286770'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Share button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryRed.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text('परिवारलाई share गर्नुस्',
                        style: AppTypography.buttonPrimary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required Color color,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textHint)),
              Text(content,
                  style: AppTypography.titleMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.success, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'high': return AppColors.severityHigh;
      case 'medium': return AppColors.severityMedium;
      default: return AppColors.severityLow;
    }
  }

  String _getSeverityLabel(String severity) {
    switch (severity) {
      case 'high': return '🔴 उच्च जोखिम';
      case 'medium': return '🟠 मध्यम जोखिम';
      default: return '🟡 कम जोखिम';
    }
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} मिनेट अघि';
    if (diff.inHours < 24) return '${diff.inHours} घण्टा अघि';
    return '${diff.inDays} दिन अघि';
  }
}
