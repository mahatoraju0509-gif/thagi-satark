import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/map_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';

class FraudMapScreen extends StatelessWidget {
  const FraudMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(
        title: 'ठगी नक्सा',
        showBack: true,
      ),
      body: Consumer<MapProvider>(
        builder: (context, mapProvider, _) {
          return Column(
            children: [
              _buildDisclaimerBanner(),
              _buildStatsRow(mapProvider),
              _buildProvinceFilter(context, mapProvider),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopDistricts(mapProvider),
                      const SizedBox(height: AppSpacing.lg),
                      _buildLegend(context, mapProvider),
                      const SizedBox(height: AppSpacing.md),
                      _buildDistrictGrid(context, mapProvider),
                      if (mapProvider.selectedDistrict != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        _buildDistrictDetail(mapProvider),
                      ],
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 0),
    );
  }

  Widget _buildDisclaimerBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: const Color(0xFF1A1A2E),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              color: AppColors.accentCyan, size: 14),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'तथ्याङ्क अनुमानित हुन् — स्रोत: Nepal Cyber Bureau (अनुमानित)',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.accentCyan,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(MapProvider provider) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.surfaceDark,
      child: Row(
        children: [
          _buildStatItem(
            'जम्मा अनुमानित',
            '${_formatNumber(provider.totalFrauds)}+',
            AppColors.danger,
          ),
          _buildDivider(),
          _buildStatItem(
            'जिल्लाहरू',
            '${provider.allDistricts.length}',
            AppColors.accentCyan,
          ),
          _buildDivider(),
          _buildStatItem(
            'उच्च जोखिम',
            '${provider.allDistricts.where((d) => d.severity == 'critical' || d.severity == 'high').length}',
            AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: AppTypography.headlineMedium.copyWith(color: color)),
          Text(label,
              style: AppTypography.labelSmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.borderDark,
    );
  }

  Widget _buildProvinceFilter(BuildContext context, MapProvider provider) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        itemCount: provider.provinces.length,
        itemBuilder: (context, index) {
          final province = provider.provinces[index];
          final isSelected = provider.selectedProvince == province;
          return GestureDetector(
            onTap: () => context.read<MapProvider>().selectProvince(province),
            child: Container(
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryRed
                    : AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryRed
                      : AppColors.borderDark,
                ),
              ),
              child: Text(
                province,
                style: AppTypography.labelLarge.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopDistricts(MapProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🔴 शीर्ष जोखिम जिल्लाहरू',
            style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ...provider.topDistricts.asMap().entries.map((entry) {
          final i = entry.key;
          final d = entry.value;
          final maxCount = provider.topDistricts.first.fraudCount;
          final ratio = d.fraudCount / maxCount;
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.borderDark),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: i == 0
                        ? AppColors.gold
                        : i == 1
                            ? AppColors.textSecondary
                            : AppColors.warning,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d.name, style: AppTypography.labelLarge),
                          Text(
                            '~${_formatNumber(d.fraudCount)} cases',
                            style: AppTypography.labelSmall.copyWith(
                                color: provider.getSeverityColor(d.severity)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: ratio,
                          backgroundColor: AppColors.borderDark,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              provider.getSeverityColor(d.severity)),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${d.province} • ${d.topFraud}',
                        style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textHint),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLegend(BuildContext context, MapProvider provider) {
    final levels = [
      {'label': 'अति उच्च', 'color': const Color(0xFFB71C1C), 'severity': 'critical'},
      {'label': 'उच्च', 'color': const Color(0xFFE53935), 'severity': 'high'},
      {'label': 'मध्यम', 'color': const Color(0xFFFF9800), 'severity': 'medium'},
      {'label': 'न्यून', 'color': const Color(0xFF4CAF50), 'severity': 'low'},
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('जोखिम स्तर अनुसार filter:',
                  style: AppTypography.labelLarge),
              if (provider.selectedSeverity != null)
                GestureDetector(
                  onTap: () =>
                      context.read<MapProvider>().selectSeverity(null),
                  child: Text(
                    'सबै हेर्नुस्',
                    style: AppTypography.labelSmall.copyWith(
                        color: AppColors.accentCyan),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: levels.map((level) {
              final color = level['color'] as Color;
              final severity = level['severity'] as String;
              final isSelected = provider.selectedSeverity == severity;
              return GestureDetector(
                onTap: () =>
                    context.read<MapProvider>().selectSeverity(severity),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withOpacity(0.25)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: isSelected ? color : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        level['label'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 10,
                          color: isSelected ? color : AppColors.textSecondary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictGrid(BuildContext context, MapProvider provider) {
    final districts = provider.filteredDistricts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${provider.selectedProvince == 'सबै' ? 'सबै' : provider.selectedProvince} जिल्लाहरू (${districts.length})',
          style: AppTypography.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.2,
          ),
          itemCount: districts.length,
          itemBuilder: (context, index) {
            final d = districts[index];
            final isSelected = provider.selectedDistrict?.name == d.name;
            final heatColor = provider.getHeatColor(d.fraudCount);
            return GestureDetector(
              onTap: () => context.read<MapProvider>().selectDistrict(d),
              child: Container(
                decoration: BoxDecoration(
                  color: heatColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: isSelected
                        ? heatColor
                        : heatColor.withOpacity(0.4),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      d.name,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '~${_formatNumber(d.fraudCount)}',
                      style: AppTypography.labelSmall.copyWith(
                        color: heatColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDistrictDetail(MapProvider provider) {
    final d = provider.selectedDistrict!;
    final color = provider.getSeverityColor(d.severity);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.name,
                      style: AppTypography.headlineMedium.copyWith(
                          color: color)),
                  Text(
                    '${d.province} प्रदेश',
                    style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  d.severity == 'critical'
                      ? 'अति उच्च जोखिम'
                      : d.severity == 'high'
                          ? 'उच्च जोखिम'
                          : d.severity == 'medium'
                              ? 'मध्यम जोखिम'
                              : 'न्यून जोखिम',
                  style: AppTypography.labelSmall.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildDetailStat(
                  'अनुमानित घटना',
                  '~${_formatNumber(d.fraudCount)}',
                  color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildDetailStat(
                  'प्रमुख ठगी',
                  d.topFraud,
                  AppColors.accentCyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppColors.textHint, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'स्रोत: Nepal Cyber Bureau (अनुमानित तथ्याङ्क)',
                    style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textHint, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint, fontSize: 10)),
          const SizedBox(height: 2),
          Text(value,
              style: AppTypography.labelLarge.copyWith(color: color)),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}
