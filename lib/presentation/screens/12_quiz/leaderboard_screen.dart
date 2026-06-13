import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../widgets/common/ts_app_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> _leaders = const [
    {'rank': 1, 'name': 'Ram Sharma', 'district': 'काठमाडौं', 'score': 98, 'emoji': '🥇'},
    {'rank': 2, 'name': 'Sita Thapa', 'district': 'पोखरा', 'score': 95, 'emoji': '🥈'},
    {'rank': 3, 'name': 'Hari BK', 'district': 'चितवन', 'score': 92, 'emoji': '🥉'},
    {'rank': 4, 'name': 'Maya Rai', 'district': 'धनकुटा', 'score': 88, 'emoji': '⭐'},
    {'rank': 5, 'name': 'Raju M.', 'district': 'रौतहट', 'score': 87, 'emoji': '⭐'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Leaderboard 🏆'),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _leaders.length,
        itemBuilder: (context, index) {
          final leader = _leaders[index];
          final isTop3 = leader['rank'] as int <= 3;
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isTop3
                  ? AppColors.gold.withOpacity(0.08)
                  : AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: isTop3
                    ? AppColors.gold.withOpacity(0.3)
                    : AppColors.borderDark,
              ),
            ),
            child: Row(
              children: [
                Text(leader['emoji'] as String,
                    style: const TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(leader['name'] as String,
                          style: AppTypography.titleMedium),
                      Text(leader['district'] as String,
                          style: AppTypography.labelSmall),
                    ],
                  ),
                ),
                Text('${leader['score']}%',
                    style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.gold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
