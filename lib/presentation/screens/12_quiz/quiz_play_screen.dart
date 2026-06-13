import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/fade_animation.dart';
import '../../../core/animations/scale_animation.dart';
import '../../../core/animations/slide_animation.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class QuizPlayScreen extends StatefulWidget {
  const QuizPlayScreen({super.key});

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _questionController;
  late Animation<double> _progressAnimation;
  late Animation<double> _questionFade;
  late Animation<Offset> _questionSlide;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _questionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _progressController, curve: Curves.easeInOut),
    );
    _questionFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _questionController, curve: Curves.easeOut),
    );
    _questionSlide = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _questionController, curve: Curves.elasticOut));

    _questionController.forward();
  }

  void _animateToNext() {
    _questionController.reset();
    _questionController.forward();
    _progressController.forward(from: 0);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        if (provider.questions.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: TsAppBar(title: 'Quiz'),
            body: const Center(
              child: CircularProgressIndicator(color: AppColors.gold),
            ),
          );
        }

        if (provider.isComplete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/quiz-result');
          });
        }

        final question = provider.currentQuestion!;
        final total = provider.questions.length;
        final current = provider.currentIndex + 1;
        final progress = current / total;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: TsAppBar(
            title: 'Quiz $current/$total',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    'Score: ${provider.score}',
                    style: AppTypography.titleMedium.copyWith(
                        color: AppColors.gold),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                // Progress bar
                FadeAnimation(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('प्रश्न $current / $total',
                              style: AppTypography.labelLarge),
                          Text('${(progress * 100).toInt()}%',
                              style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.gold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.surfaceLight,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress > 0.7
                                    ? AppColors.success
                                    : progress > 0.4
                                        ? AppColors.gold
                                        : AppColors.primaryRed,
                              ),
                              minHeight: 8,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Question card
                Expanded(
                  child: SlideTransition(
                    position: _questionSlide,
                    child: FadeTransition(
                      opacity: _questionFade,
                      child: Column(
                        children: [
                          // Question
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.surfaceDark,
                                  AppColors.surfaceMedium,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                              border: Border.all(
                                  color: AppColors.gold.withOpacity(0.3),
                                  width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: AppColors.gold.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    question.fraudType.toUpperCase(),
                                    style: AppTypography.labelSmall.copyWith(
                                        color: AppColors.gold,
                                        letterSpacing: 1),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  question.questionNp,
                                  style: AppTypography.titleLarge.copyWith(
                                      height: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          // Options
                          ...question.optionsNp.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final option = entry.value;
                            final isSelected = provider.selectedAnswer == idx;
                            final isAnswered = provider.answered;
                            final isCorrect = idx == question.correctIndex;

                            Color borderColor = AppColors.borderDark;
                            Color bgColor = AppColors.surfaceDark;
                            Color textColor = AppColors.textPrimary;
                            IconData? trailingIcon;

                            if (isAnswered) {
                              if (isCorrect) {
                                borderColor = AppColors.success;
                                bgColor = AppColors.success.withOpacity(0.1);
                                textColor = AppColors.success;
                                trailingIcon = Icons.check_circle_rounded;
                              } else if (isSelected && !isCorrect) {
                                borderColor = AppColors.danger;
                                bgColor = AppColors.danger.withOpacity(0.1);
                                textColor = AppColors.danger;
                                trailingIcon = Icons.cancel_rounded;
                              }
                            } else if (isSelected) {
                              borderColor = AppColors.gold;
                              bgColor = AppColors.gold.withOpacity(0.1);
                            }

                            return ScaleAnimation(
                              delay: Duration(milliseconds: idx * 60),
                              child: GestureDetector(
                                onTap: () => provider.selectAnswer(idx),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.only(
                                      bottom: AppSpacing.sm),
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.md),
                                    border: Border.all(
                                        color: borderColor, width: 1.5),
                                    boxShadow: isAnswered && isCorrect
                                        ? [
                                            BoxShadow(
                                              color: AppColors.success
                                                  .withOpacity(0.2),
                                              blurRadius: 12,
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: borderColor.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: borderColor.withOpacity(0.5)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ['A', 'B', 'C', 'D'][idx],
                                            style: AppTypography.labelLarge
                                                .copyWith(
                                                    color: borderColor,
                                                    fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Expanded(
                                        child: Text(option,
                                            style:
                                                AppTypography.bodyMedium.copyWith(
                                                    color: textColor)),
                                      ),
                                      if (trailingIcon != null)
                                        Icon(trailingIcon,
                                            color: isCorrect
                                                ? AppColors.success
                                                : AppColors.danger,
                                            size: 22),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          // Explanation + Next
                          if (provider.answered) ...[
                            const SizedBox(height: AppSpacing.md),
                            FadeAnimation(
                              child: Container(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: AppColors.accentCyan.withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.md),
                                  border: Border.all(
                                      color: AppColors.accentCyan
                                          .withOpacity(0.3)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.lightbulb_rounded,
                                        color: AppColors.accentCyan, size: 20),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        question.explanationNp,
                                        style: AppTypography.bodyMedium.copyWith(
                                            color: AppColors.textPrimary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            GestureDetector(
                              onTap: () {
                                provider.nextQuestion();
                                _animateToNext();
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
                                  child: Text(
                                    provider.currentIndex <
                                            provider.questions.length - 1
                                        ? 'अर्को प्रश्न →'
                                        : 'Result हेर्नुस् 🎉',
                                    style: AppTypography.buttonPrimary.copyWith(
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
