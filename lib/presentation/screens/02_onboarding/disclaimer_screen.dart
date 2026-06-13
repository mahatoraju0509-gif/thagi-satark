import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/animation_durations.dart';
import '../../../core/animations/animation_curves.dart';
import '../../../core/animations/scale_animation.dart';
import '../../providers/settings_provider.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen>
    with SingleTickerProviderStateMixin {
  bool _accepted = false;
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: AnimationDurations.fast,
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: AnimationCurves.standard),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _proceed() async {
    if (!_accepted) return;
    await _buttonController.forward();
    await _buttonController.reverse();
    if (mounted) {
      context.read<SettingsProvider>().acceptDisclaimer();
      context.read<SettingsProvider>().completeOnboarding();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),

              // Logo + Title
              Image.asset('assets/images/logo.png', width: 80, height: 80, fit: BoxFit.contain),
              const SizedBox(height: AppSpacing.sm),
              Text('ठगी सतर्क',
                  style: AppTypography.headlineLarge.copyWith(color: AppColors.primaryRed)),
              Text('Nepal\'s #1 Fraud Awareness App',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),

              const SizedBox(height: AppSpacing.lg),

              // Trust badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _trustBadge('100% Free', Icons.money_off_rounded, AppColors.success),
                  const SizedBox(width: 8),
                  _trustBadge('Offline', Icons.wifi_off_rounded, AppColors.accentCyan),
                  const SizedBox(width: 8),
                  _trustBadge('Nepal Made', Icons.flag_rounded, AppColors.primaryRed),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // App purpose — highly trusted section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.success.withOpacity(0.4), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.verified_rounded, color: AppColors.success, size: 22),
                      const SizedBox(width: 8),
                      Text('यो App किन बनाइयो?',
                          style: AppTypography.titleLarge.copyWith(color: AppColors.success)),
                    ]),
                    const SizedBox(height: AppSpacing.sm),
                    _purposeItem('🛡️', 'Nepal मा बढ्दो fraud बाट नागरिकलाई बचाउन'),
                    _purposeItem('📚', '३०+ ठगीका प्रकार — विस्तृत जानकारी निःशुल्क'),
                    _purposeItem('🤖', 'AI मार्फत fraud detect गर्न सहयोग'),
                    _purposeItem('📍', 'District-wise fraud map — सतर्क रहनुस्'),
                    _purposeItem('⚖️', 'Nepal का real laws — कानुनी हक थाहा पाउनुस्'),
                    _purposeItem('🆓', 'सम्पूर्ण सेवा — निःशुल्क, सदाको लागि'),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Developer trust
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/images/raju.jpg', fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => const Icon(Icons.person_rounded, color: AppColors.gold)),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Raju Mahato',
                              style: AppTypography.titleMedium.copyWith(color: AppColors.gold)),
                          Text('KCG Student, Kyoto Japan',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                          Text('Yamunamai-1, Rautahat, Nepal',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                          const SizedBox(height: 4),
                          Text('"Nepal लाई fraud-free बनाउने सपना"',
                              style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Important note
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.info_rounded, color: AppColors.warning, size: 18),
                      const SizedBox(width: 6),
                      Text('जान्नु आवश्यक:', style: AppTypography.titleMedium.copyWith(color: AppColors.warning)),
                    ]),
                    const SizedBox(height: AppSpacing.sm),
                    _noteItem(Icons.check_circle_rounded, AppColors.success, 'यो app जनसचेतनाको लागि मात्र हो'),
                    _noteItem(Icons.check_circle_rounded, AppColors.success, 'सबै जानकारी educational purpose को लागि'),
                    _noteItem(Icons.info_rounded, AppColors.warning, 'Official complaint को लागि Nepal Police वा सम्बन्धित निकायमा जानुस्'),
                    _noteItem(Icons.info_rounded, AppColors.warning, 'ठूलो निर्णय गर्नु अघि expert सँग परामर्श गर्नुस्'),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Checkbox
              GestureDetector(
                onTap: () => setState(() => _accepted = !_accepted),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: _accepted ? AppColors.primaryRed.withOpacity(0.08) : AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                        color: _accepted ? AppColors.primaryRed : AppColors.borderDark,
                        width: _accepted ? 1.5 : 1),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: AnimationDurations.fast,
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          color: _accepted ? AppColors.primaryRed : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _accepted ? AppColors.primaryRed : AppColors.borderMedium,
                              width: 2),
                        ),
                        child: _accepted
                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'मैले माथिका सबै कुरा बुझें र सहमत छु।',
                          style: AppTypography.bodyMedium.copyWith(
                              color: _accepted ? AppColors.textPrimary : AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Proceed button
              ScaleTransition(
                scale: _buttonScale,
                child: GestureDetector(
                  onTap: _proceed,
                  child: AnimatedContainer(
                    duration: AnimationDurations.fast,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: _accepted ? AppColors.primaryRed : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(AppRadius.button),
                      boxShadow: _accepted ? [
                        BoxShadow(color: AppColors.primaryRed.withOpacity(0.4),
                            blurRadius: 20, offset: const Offset(0, 6)),
                      ] : null,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png', width: 24, height: 24, fit: BoxFit.contain),
                          const SizedBox(width: 8),
                          Text('मैले बुझें, सुरु गरौं',
                              style: AppTypography.buttonPrimary.copyWith(
                                  color: _accepted ? AppColors.textPrimary : AppColors.textHint)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trustBadge(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
      ]),
    );
  }

  Widget _purposeItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: AppTypography.bodyMedium)),
      ]),
    );
  }

  Widget _noteItem(IconData icon, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}
