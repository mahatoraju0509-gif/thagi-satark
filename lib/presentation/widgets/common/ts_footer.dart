import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';

class TsFooter extends StatelessWidget {
  const TsFooter({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gold.withOpacity(0.08), AppColors.background],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Developer photo + info
          Row(
            children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/raju.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      color: AppColors.surfaceDark,
                      child: const Icon(Icons.person_rounded, color: AppColors.gold, size: 32),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Raju Mahato',
                        style: AppTypography.titleLarge.copyWith(color: AppColors.gold)),
                    Text('Founder & Developer',
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                    Text('KCG Student, Kyoto Japan',
                        style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),
          const Divider(color: Colors.white10),
          const SizedBox(height: AppSpacing.sm),

          // Quote
          Text(
            '"Nepal को प्रत्येक नागरिकलाई ठगीबाट बचाउने सपनाले यो app बनाएको हो।"',
            style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontStyle: FontStyle.italic,
                height: 1.6),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.md),

          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialBtn('Website', Icons.web_rounded, AppColors.accentCyan,
                  'https://rajumahato.it.com'),
              const SizedBox(width: 8),
              _socialBtn('WhatsApp', Icons.chat_rounded, AppColors.success,
                  'https://wa.me/819003669264'),
              const SizedBox(width: 8),
              _socialBtn('Facebook', Icons.facebook_rounded, AppColors.accentCyan,
                  'https://www.facebook.com/share/18DzpGha4J/?mibextid=wwXIfr'),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Copyright
          Text('\u00a9 2083 BS \u2014 \u0920\u0917\u0940 \u0938\u0924\u0930\u094d\u0915 | \u0938\u092c\u0948 \u0905\u0927\u093f\u0915\u093e\u0930 \u0938\u0941\u0930\u0915\u094d\u0937\u093f\u0924',
              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
          const SizedBox(height: 4),
          Text('Made with \u2764\ufe0f for Nepal',
              style: AppTypography.labelSmall.copyWith(color: AppColors.gold)),
        ],
      ),
    );
  }

  Widget _socialBtn(String label, IconData icon, Color color, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
