import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/animations/fade_animation.dart';
import '../../../core/animations/slide_animation.dart';
import '../../../core/animations/pulse_animation.dart';
import '../../providers/fraud_provider.dart';
import '../../providers/alert_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';
import '../../widgets/common/ts_footer.dart';
import '../../widgets/common/ts_loading.dart';
import '../../widgets/cards/fraud_category_card.dart';
import '../../widgets/cards/alert_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FraudProvider>().loadFrauds();
      context.read<AlertProvider>().loadDummyAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(
        title: 'ठगी सतर्क',
        showBack: false,
        showLogo: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search_rounded, color: AppColors.textPrimary),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.alerts),
            icon: Stack(
              children: [
                const Icon(Icons.notifications_rounded, color: AppColors.textPrimary),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Consumer<AlertProvider>(
                    builder: (context, alerts, _) {
                      if (alerts.unreadCount == 0) return const SizedBox.shrink();
                      return Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlertBanner(),
            FadeAnimation(
              delay: const Duration(milliseconds: 100),
              child: _buildAiCheckerHero(),
            ),
            const SizedBox(height: AppSpacing.lg),
            SlideAnimation(
              delay: const Duration(milliseconds: 200),
              child: _buildStatsRow(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildFraudCategories(),
            const SizedBox(height: AppSpacing.lg),
            _buildQuickActions(),
            const SizedBox(height: AppSpacing.lg),
            _buildRecentAlerts(),
            const SizedBox(height: AppSpacing.lg),
            const FadeAnimation(
              delay: Duration(milliseconds: 500),
              child: TsFooter(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 0),
    );
  }

  Widget _buildAlertBanner() {
    return Consumer<AlertProvider>(
      builder: (context, alertProvider, _) {
        if (alertProvider.alerts.isEmpty) return const SizedBox.shrink();
        final latest = alertProvider.alerts.first;
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.alerts),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            color: AppColors.danger.withOpacity(0.15),
            child: Row(
              children: [
                PulseAnimation(
                  child: const Icon(Icons.warning_amber_rounded,
                      color: AppColors.danger, size: 18),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    latest.titleNp,
                    style: AppTypography.labelLarge.copyWith(
                        color: AppColors.danger),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.danger, size: 14),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAiCheckerHero() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.aiChecker),
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7F0000), AppColors.primaryRed, Color(0xFFE53935)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: AppShadows.glowRed,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text('AI Powered ✨',
                        style: AppTypography.labelSmall.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('यो ठगी हो?',
                      style: AppTypography.displayMedium.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('आफ्नो situation लेख्नुस् — AI ले तुरुन्त बताउँछ',
                      style: AppTypography.bodyMedium.copyWith(color: Colors.white70)),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text('जाँच गर्नुस् →',
                        style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primaryRed, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.psychology_rounded, color: Colors.white, size: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _buildStatCard('३०+', 'ठगी प्रकार', AppColors.primaryRed),
          const SizedBox(width: AppSpacing.sm),
          _buildStatCard('७७', 'जिल्ला cover', AppColors.accentCyan),
          const SizedBox(width: AppSpacing.sm),
          _buildStatCard('१००%', 'Nepali', AppColors.gold),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTypography.headlineMedium.copyWith(color: color)),
            Text(label,
                style: AppTypography.labelSmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFraudCategories() {
    return Consumer<FraudProvider>(
      builder: (context, fraudProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ठगीका प्रकारहरू', style: AppTypography.headlineMedium),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.encyclopedia),
                    child: Text('सबै हेर्नुस्',
                        style: AppTypography.labelLarge.copyWith(
                            color: AppColors.accentCyan)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            fraudProvider.isLoading
                ? const TsLoading()
                : fraudProvider.error.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Text(
                            fraudProvider.error,
                            style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.warning),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: fraudProvider.frauds.length,
                          itemBuilder: (context, index) {
                            final fraud = fraudProvider.frauds[index];
                            return FraudCategoryCard(
                              fraud: fraud,
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.fraudDetail,
                                arguments: fraud,
                              ),
                            );
                          },
                        ),
                      ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.verified_user_rounded, 'label': 'Agency\nVerify', 'color': AppColors.accentCyan, 'route': AppRoutes.verify},
      {'icon': Icons.map_rounded, 'label': 'Fraud\nMap', 'color': AppColors.gold, 'route': AppRoutes.fraudMap},
      {'icon': Icons.gavel_rounded, 'label': 'Legal\nGuide', 'color': AppColors.success, 'route': AppRoutes.legal},
      {'icon': Icons.phone_rounded, 'label': 'Helplines', 'color': AppColors.primaryRed, 'route': AppRoutes.helplines},
      {'icon': Icons.report_rounded, 'label': 'Report\nठगी', 'color': AppColors.warning, 'route': AppRoutes.report},
      {'icon': Icons.quiz_rounded, 'label': 'Daily\nQuiz', 'color': AppColors.saffron, 'route': AppRoutes.quizHome},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: AppTypography.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.2,
            children: actions.map((a) => _buildQuickActionItem(a)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, action['route'] as String),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: (action['color'] as Color).withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              action['icon'] as IconData,
              color: action['color'] as Color,
              size: 32,
            ),
            const SizedBox(height: 6),
            Text(
              action['label'] as String,
              style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAlerts() {
    return Consumer<AlertProvider>(
      builder: (context, alertProvider, _) {
        if (alertProvider.alerts.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ताजा सतर्कता', style: AppTypography.headlineMedium),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.alerts),
                    child: Text('सबै हेर्नुस्',
                        style: AppTypography.labelLarge.copyWith(
                            color: AppColors.accentCyan)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ...alertProvider.alerts.take(2).map(
                    (alert) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AlertCard(
                        title: alert.titleNp,
                        description: alert.descriptionNp,
                        district: alert.district,
                        severity: alert.severity,
                        timeAgo: _timeAgo(alert.createdAt),
                        isRead: alert.isRead,
                        onTap: () {
                          alertProvider.markAsRead(alert.id);
                          Navigator.pushNamed(context, AppRoutes.alertDetail);
                        },
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} मिनेट अघि';
    if (diff.inHours < 24) return '${diff.inHours} घण्टा अघि';
    return '${diff.inDays} दिन अघि';
  }
}
