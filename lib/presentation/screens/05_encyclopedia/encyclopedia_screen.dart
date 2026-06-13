import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/animations/stagger_animation.dart';
import '../../../core/animations/fade_animation.dart';
import '../../providers/fraud_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';
import '../../widgets/common/ts_loading.dart';
import '../../widgets/cards/fraud_category_card.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'label': 'सबै', 'value': 'सबै', 'color': AppColors.textPrimary},
    {'label': '🔴 उच्च', 'value': 'high', 'color': AppColors.severityHigh},
    {'label': '🟠 मध्यम', 'value': 'medium', 'color': AppColors.severityMedium},
    {'label': '💼 जागिर', 'value': 'employment', 'color': AppColors.accentCyan},
    {'label': '🌐 Online', 'value': 'online', 'color': AppColors.gold},
    {'label': '💰 Investment', 'value': 'investment', 'color': AppColors.success},
    {'label': '🏘️ Local', 'value': 'local', 'color': AppColors.saffron},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FraudProvider>().loadFrauds();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(
        title: 'ठगी पुस्तिका',
        showBack: false,
      ),
      body: Column(
        children: [
          // Search bar
          FadeAnimation(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                controller: _searchController,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                onChanged: (value) {
                  context.read<FraudProvider>().search(value);
                },
                decoration: InputDecoration(
                  hintText: 'ठगी खोज्नुस्...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textHint,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            context.read<FraudProvider>().search('');
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColors.textHint,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.surfaceMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // Category filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return Consumer<FraudProvider>(
                  builder: (context, provider, _) {
                    final isSelected =
                        provider.selectedCategory == cat['value'];
                    return GestureDetector(
                      onTap: () => provider.filterByCategory(
                          cat['value'] as String),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (cat['color'] as Color).withOpacity(0.2)
                              : AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isSelected
                                ? cat['color'] as Color
                                : AppColors.borderDark,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          cat['label'] as String,
                          style: AppTypography.labelLarge.copyWith(
                            color: isSelected
                                ? cat['color'] as Color
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Fraud list
          Expanded(
            child: Consumer<FraudProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) return const TsLoading();
                if (provider.filtered.isEmpty) {
                  return TsEmptyView(
                    message: 'कुनै ठगी भेटिएन',
                    icon: Icons.search_off_rounded,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.filtered.length,
                  itemBuilder: (context, index) {
                    final fraud = provider.filtered[index];
                    return FadeAnimation(
                      delay: Duration(milliseconds: index * 50),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.fraudDetail,
                          arguments: fraud,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            border: Border.all(
                              color: _getSeverityColor(fraud.severity)
                                  .withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Icon
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: _getSeverityColor(fraud.severity)
                                      .withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.md),
                                ),
                                child: Icon(
                                  _getFraudIcon(fraud.id),
                                  color: _getSeverityColor(fraud.severity),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fraud.titleNp,
                                      style: AppTypography.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      fraud.descriptionNp,
                                      style: AppTypography.bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getSeverityColor(
                                                    fraud.severity)
                                                .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Text(
                                            _getSeverityLabel(
                                                fraud.severity),
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                              color: _getSeverityColor(
                                                  fraud.severity),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${fraud.reportCount} cases',
                                          style: AppTypography.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: AppColors.textHint,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 2),
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
      case 'medium': return '🟠 मध्यम';
      default: return '🟡 कम';
    }
  }

  IconData _getFraudIcon(String id) {
    switch (id) {
      case '001': return Icons.flight_rounded;
      case '002': return Icons.work_rounded;
      case '003': return Icons.shopping_bag_rounded;
      case '004': return Icons.account_balance_rounded;
      case '005': return Icons.self_improvement_rounded;
      default: return Icons.warning_rounded;
    }
  }
}
