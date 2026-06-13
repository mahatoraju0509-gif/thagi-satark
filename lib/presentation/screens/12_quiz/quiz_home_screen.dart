import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/fade_animation.dart';
import '../../../core/animations/slide_animation.dart';
import '../../../core/animations/scale_animation.dart';
import '../../../core/animations/pulse_animation.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Daily Quiz'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Hero
            FadeAnimation(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.saffron.withOpacity(0.2),
                      AppColors.gold.withOpacity(0.1),
                      AppColors.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                      color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    PulseAnimation(
                      glowColor: AppColors.gold,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gold.withOpacity(0.15),
                          border: Border.all(
                              color: AppColors.gold.withOpacity(0.4),
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.quiz_rounded,
                            color: AppColors.gold, size: 52),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text('दैनिक सुरक्षा Quiz',
                        style: AppTypography.displayMedium,
                        textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'खेल्नुस् र ठगीबाट बच्न सिक्नुस्!\nप्रत्येक दिन नयाँ questions।',
                      style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Stats row
            SlideAnimation(
              delay: const Duration(milliseconds: 100),
              child: Row(
                children: [
                  _buildStatCard('🎯', '1000+', 'Questions', AppColors.accentCyan),
                  const SizedBox(width: AppSpacing.sm),
                  _buildStatCard('🔥', '0', 'Streak', AppColors.saffron),
                  const SizedBox(width: AppSpacing.sm),
                  _buildStatCard('⭐', '0', 'Score', AppColors.gold),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Categories
            SlideAnimation(
              delay: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category छान्नुस्:',
                      style: AppTypography.headlineMedium),
                  const SizedBox(height: AppSpacing.md),
                  ...[
                    {'label': 'सबै ठगी', 'icon': Icons.all_inclusive_rounded, 'color': AppColors.primaryRed, 'count': '50+'},
                    {'label': 'Foreign Employment', 'icon': Icons.flight_rounded, 'color': AppColors.accentCyan, 'count': '20+'},
                    {'label': 'Online Fraud', 'icon': Icons.computer_rounded, 'color': AppColors.gold, 'count': '20+'},
                    {'label': 'Investment', 'icon': Icons.trending_up_rounded, 'color': AppColors.success, 'count': '10+'},
                  ].map((cat) => GestureDetector(
                    onTap: () {
                      context.read<QuizProvider>().loadQuestions();
                      Navigator.pushNamed(context, '/quiz-play');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                            color: (cat['color'] as Color).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: (cat['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Icon(cat['icon'] as IconData,
                                color: cat['color'] as Color, size: 24),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cat['label'] as String,
                                    style: AppTypography.titleMedium),
                                Text('${cat['count']} questions',
                                    style: AppTypography.labelSmall),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: (cat['color'] as Color).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text('खेल्नुस्',
                                style: AppTypography.labelLarge.copyWith(
                                    color: cat['color'] as Color)),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(value,
                style: AppTypography.headlineMedium.copyWith(color: color)),
            Text(label, style: AppTypography.labelSmall),
          ],
        ),
      ),
    );
  }
}
