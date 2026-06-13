import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/fraud_model.dart';

class FraudCategoryCard extends StatelessWidget {
  final FraudModel fraud;
  final VoidCallback onTap;

  const FraudCategoryCard({
    super.key,
    required this.fraud,
    required this.onTap,
  });

  static const List<Color> _cardColors = [
    Color(0xFFB71C1C), // deep red
    Color(0xFF1565C0), // deep blue
    Color(0xFF2E7D32), // deep green
    Color(0xFFE65100), // deep orange
    Color(0xFF6A1B9A), // deep purple
    Color(0xFF00695C), // deep teal
    Color(0xFF558B2F), // deep light green
    Color(0xFF4527A0), // deep indigo
    Color(0xFF00838F), // deep cyan
    Color(0xFFC62828), // red
    Color(0xFF1976D2), // blue
    Color(0xFF388E3C), // green
    Color(0xFFF57C00), // orange
    Color(0xFF7B1FA2), // purple
    Color(0xFF00796B), // teal
    Color(0xFF283593), // indigo
    Color(0xFF0277BD), // light blue
    Color(0xFF2E7D32), // green
    Color(0xFFAD1457), // pink
    Color(0xFF4E342E), // brown
    Color(0xFF37474F), // blue grey
    Color(0xFF6D4C41), // brown
    Color(0xFF1B5E20), // green
    Color(0xFF880E4F), // pink
    Color(0xFF0D47A1), // blue
    Color(0xFF33691E), // light green
    Color(0xFF4A148C), // purple
    Color(0xFF006064), // cyan
    Color(0xFFBF360C), // deep orange
    Color(0xFF01579B), // light blue
  ];

  Color get _cardColor {
    final index = int.tryParse(fraud.id.replaceAll('fraud_', '')) ?? 1;
    return _cardColors[(index - 1) % _cardColors.length];
  }

  IconData get _fraudIcon {
    switch (fraud.category) {
      case 'employment': return Icons.flight_rounded;
      case 'digital': return Icons.computer_rounded;
      case 'financial': return Icons.account_balance_rounded;
      case 'property': return Icons.home_rounded;
      case 'social': return Icons.people_rounded;
      case 'health': return Icons.health_and_safety_rounded;
      case 'education': return Icons.school_rounded;
      case 'crime': return Icons.gavel_rounded;
      case 'government': return Icons.account_balance_rounded;
      case 'transport': return Icons.directions_car_rounded;
      default: return Icons.warning_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _cardColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background circle decoration
            Positioned(
              top: -15, right: -15,
              child: Container(
                width: 70, height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -20, left: -10,
              child: Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                     width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(_fraudIcon, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 6),
                  // Title
                  Text(
                    fraud.titleNp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Cases
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${fraud.reportCount} cases',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
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
  }
}

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final String district;
  final String severity;
  final String timeAgo;
  final bool isRead;
  final VoidCallback onTap;

  const AlertCard({
    super.key,
    required this.title,
    required this.description,
    required this.district,
    required this.severity,
    required this.timeAgo,
    required this.isRead,
    required this.onTap,
  });

  Color get _severityColor {
    switch (severity) {
      case 'critical': return AppColors.danger;
      case 'high': return AppColors.primaryRed;
      case 'medium': return AppColors.warning;
      default: return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isRead ? AppColors.borderDark : _severityColor.withOpacity(0.4),
            width: isRead ? 1 : 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10, height: 10,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: _severityColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: AppTypography.titleMedium.copyWith(
                      color: isRead ? AppColors.textSecondary : AppColors.textPrimary,
                    ),
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(description,
                    style: AppTypography.bodyMedium,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 12, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Text(district, style: AppTypography.labelSmall),
                      const Spacer(),
                      Text(timeAgo, style: AppTypography.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
