import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/scale_animation.dart';
import '../../../core/animations/fade_animation.dart';
import '../../../core/animations/slide_animation.dart';
import '../../../core/animations/glow_animation.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        final score = provider.score;
        final total = provider.questions.length;
        final percent = total > 0 ? (score / total * 100).toInt() : 0;

        final grade = percent >= 90
            ? 'A+'
            : percent >= 80
                ? 'A'
                : percent >= 70
                    ? 'B'
                    : percent >= 60
                        ? 'C'
                        : 'D';

        final gradeColor = percent >= 70
            ? AppColors.success
            : percent >= 50
                ? AppColors.gold
                : AppColors.danger;

        final message = percent >= 90
            ? 'उत्कृष्ट! तपाईं ठगीबाट पूर्ण सुरक्षित हुनुहुन्छ! 🏆'
            : percent >= 70
                ? 'राम्रो! अझ सिक्नुस् र सुरक्षित रहनुस्! 💪'
                : percent >= 50
                    ? 'ठीकै छ! अझ practice गर्नुस्! 📚'
                    : 'थप सिक्नु जरुरी छ! ठगीबाट सावधान रहनुस्! ⚠️';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: TsAppBar(title: 'Quiz Result'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),

                // Grade circle
                ScaleAnimation(
                  child: GlowAnimation(
                    glowColor: gradeColor,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: gradeColor.withOpacity(0.1),
                        border: Border.all(
                            color: gradeColor.withOpacity(0.5), width: 3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(grade,
                              style: AppTypography.displayLarge.copyWith(
                                  color: gradeColor,
                                  fontSize: 48)),
                          Text('$percent%',
                              style: AppTypography.titleMedium.copyWith(
                                  color: gradeColor)),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                FadeAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Text(message,
                      style: AppTypography.headlineMedium,
                      textAlign: TextAlign.center),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Score cards
                SlideAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Row(
                    children: [
                      _buildScoreCard('✅ सही', '$score', AppColors.success),
                      const SizedBox(width: AppSpacing.sm),
                      _buildScoreCard(
                          '❌ गलत', '${total - score}', AppColors.danger),
                      const SizedBox(width: AppSpacing.sm),
                      _buildScoreCard('📝 जम्मा', '$total', AppColors.accentCyan),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Share badge
                FadeAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                          color: AppColors.gold.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.emoji_events_rounded,
                                color: AppColors.gold, size: 28),
                            const SizedBox(width: 8),
                            Text('Badge मिल्यो!',
                                style: AppTypography.titleLarge.copyWith(
                                    color: AppColors.gold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'म आज ठगीबाट सतर्क भएँ! 🛡️\nScore: $score/$total ($percent%)',
                          style: AppTypography.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.share_rounded,
                                    color: Colors.black, size: 18),
                                const SizedBox(width: 8),
                                Text('Share गर्नुस्',
                                    style: AppTypography.labelLarge.copyWith(
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Buttons
                SlideAnimation(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.resetQuiz();
                          provider.loadQuestions();
                          Navigator.pushReplacementNamed(
                              context, '/quiz-play');
                        },
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.gold,
                            borderRadius:
                                BorderRadius.circular(AppRadius.button),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text('🔄 फेरि खेल्नुस्',
                                style: AppTypography.buttonPrimary.copyWith(
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius:
                                BorderRadius.circular(AppRadius.button),
                            border: Border.all(color: AppColors.borderDark),
                          ),
                          child: Center(
                            child: Text('🏠 होम मा जानुस्',
                                style: AppTypography.buttonPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScoreCard(String label, String value, Color color) {
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
            Text(value,
                style: AppTypography.headlineLarge.copyWith(color: color)),
            Text(label,
                style: AppTypography.labelSmall,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

