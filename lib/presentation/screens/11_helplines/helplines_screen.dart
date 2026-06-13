import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';
import '../../widgets/common/ts_footer.dart';

class HelplinesScreen extends StatefulWidget {
  const HelplinesScreen({super.key});

  @override
  State<HelplinesScreen> createState() => _HelplinesScreenState();
}

class _HelplinesScreenState extends State<HelplinesScreen> {
  String _selectedCategory = 'सबै';

  final List<Map<String, dynamic>> _categories = [
    {'label': 'सबै', 'icon': Icons.apps_rounded, 'color': AppColors.textPrimary},
    {'label': 'Emergency', 'icon': Icons.emergency_rounded, 'color': AppColors.danger},
    {'label': 'Employment', 'icon': Icons.flight_rounded, 'color': AppColors.primaryRed},
    {'label': 'Financial', 'icon': Icons.account_balance_rounded, 'color': AppColors.gold},
    {'label': 'Cyber', 'icon': Icons.computer_rounded, 'color': AppColors.accentCyan},
    {'label': 'Women', 'icon': Icons.woman_rounded, 'color': AppColors.saffron},
    {'label': 'Health', 'icon': Icons.health_and_safety_rounded, 'color': AppColors.success},
    {'label': 'Legal', 'icon': Icons.gavel_rounded, 'color': AppColors.warning},
    {'label': 'Government', 'icon': Icons.account_balance_rounded, 'color': AppColors.textSecondary},
  ];

  final List<Map<String, dynamic>> _helplines = [
    // Emergency
    {'category': 'Emergency', 'color': AppColors.danger, 'icon': Icons.emergency_rounded,
      'name': 'Nepal Police', 'number': '100', 'desc': '२४ घण्टा Emergency service', 'isEmergency': true},
    {'category': 'Emergency', 'color': AppColors.danger, 'icon': Icons.local_hospital_rounded,
      'name': 'Ambulance', 'number': '102', 'desc': 'Medical Emergency', 'isEmergency': true},
    {'category': 'Emergency', 'color': AppColors.danger, 'icon': Icons.fire_truck_rounded,
      'name': 'Fire Brigade', 'number': '101', 'desc': 'Fire Emergency', 'isEmergency': true},
    {'category': 'Emergency', 'color': AppColors.danger, 'icon': Icons.security_rounded,
      'name': 'Armed Police Force', 'number': '103', 'desc': 'Security Emergency', 'isEmergency': true},

    // Employment
    {'category': 'Employment', 'color': AppColors.primaryRed, 'icon': Icons.flight_rounded,
      'name': 'DoFE Hotline', 'number': '1180', 'desc': 'Foreign Employment — Toll Free', 'isEmergency': false},
    {'category': 'Employment', 'color': AppColors.primaryRed, 'icon': Icons.work_rounded,
      'name': 'DoFE Office', 'number': '01-4991000', 'desc': 'Department of Foreign Employment', 'isEmergency': false},
    {'category': 'Employment', 'color': AppColors.primaryRed, 'icon': Icons.support_agent_rounded,
      'name': 'Labour Ministry', 'number': '01-4729099', 'desc': 'Ministry of Labour', 'isEmergency': false},
    {'category': 'Employment', 'color': AppColors.primaryRed, 'icon': Icons.people_rounded,
      'name': 'ILO Nepal', 'number': '01-5523200', 'desc': 'International Labour Organization', 'isEmergency': false},

    // Financial
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.account_balance_rounded,
      'name': 'NRB Hotline', 'number': '1414', 'desc': 'Nepal Rastra Bank — Toll Free', 'isEmergency': false},
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.savings_rounded,
      'name': 'Beema Samiti', 'number': '01-4229873', 'desc': 'Insurance Board Nepal', 'isEmergency': false},
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.trending_up_rounded,
      'name': 'SEBON', 'number': '01-4412013', 'desc': 'Securities Board Nepal', 'isEmergency': false},
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.groups_rounded,
      'name': 'DoC', 'number': '01-4229032', 'desc': 'Department of Cooperatives', 'isEmergency': false},
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.phone_rounded,
      'name': 'eSewa', 'number': '16600172222', 'desc': 'eSewa Customer Care', 'isEmergency': false},
    {'category': 'Financial', 'color': AppColors.gold, 'icon': Icons.phone_rounded,
      'name': 'Khalti', 'number': '16600185001', 'desc': 'Khalti Customer Care', 'isEmergency': false},

    // Cyber
    {'category': 'Cyber', 'color': AppColors.accentCyan, 'icon': Icons.computer_rounded,
      'name': 'Cyber Bureau', 'number': '1177', 'desc': 'Cyber Crime — Toll Free', 'isEmergency': true},
    {'category': 'Cyber', 'color': AppColors.accentCyan, 'icon': Icons.shield_rounded,
      'name': 'Cyber Bureau Office', 'number': '01-4461839', 'desc': 'Nepal Police Cyber Bureau', 'isEmergency': false},
    {'category': 'Cyber', 'color': AppColors.accentCyan, 'icon': Icons.report_rounded,
      'name': 'CIB Nepal', 'number': '01-4412548', 'desc': 'Criminal Investigation Bureau', 'isEmergency': false},

    // Women
    {'category': 'Women', 'color': AppColors.saffron, 'icon': Icons.woman_rounded,
      'name': 'महिला आयोग', 'number': '1145', 'desc': 'Women Commission — Toll Free', 'isEmergency': true},
    {'category': 'Women', 'color': AppColors.saffron, 'icon': Icons.child_care_rounded,
      'name': 'Child Helpline', 'number': '1098', 'desc': 'Child Protection — Toll Free', 'isEmergency': true},
    {'category': 'Women', 'color': AppColors.saffron, 'icon': Icons.family_restroom_rounded,
      'name': 'THB Hotline', 'number': '1800-01-8899', 'desc': 'Human Trafficking — Toll Free', 'isEmergency': true},
    {'category': 'Women', 'color': AppColors.saffron, 'icon': Icons.home_rounded,
      'name': 'Maiti Nepal', 'number': '01-4271871', 'desc': 'Anti-Trafficking Organization', 'isEmergency': false},
    {'category': 'Women', 'color': AppColors.saffron, 'icon': Icons.support_rounded,
      'name': 'WOREC Nepal', 'number': '01-4371839', 'desc': 'Women Rights Organization', 'isEmergency': false},

    // Health
    {'category': 'Health', 'color': AppColors.success, 'icon': Icons.psychology_rounded,
      'name': 'Mental Health', 'number': '1166', 'desc': 'Mental Health Helpline — Toll Free', 'isEmergency': true},
    {'category': 'Health', 'color': AppColors.success, 'icon': Icons.medication_rounded,
      'name': 'DDA Hotline', 'number': '1800-01-8899', 'desc': 'Drug Administration', 'isEmergency': false},
    {'category': 'Health', 'color': AppColors.success, 'icon': Icons.local_hospital_rounded,
      'name': 'Bir Hospital', 'number': '01-4221119', 'desc': 'Government Hospital', 'isEmergency': false},
    {'category': 'Health', 'color': AppColors.success, 'icon': Icons.bloodtype_rounded,
      'name': 'Nepal Red Cross', 'number': '01-4270650', 'desc': 'Blood Bank & Emergency', 'isEmergency': false},

    // Legal
    {'category': 'Legal', 'color': AppColors.warning, 'icon': Icons.gavel_rounded,
      'name': 'Nepal Bar Association', 'number': '01-4221740', 'desc': 'Free Legal Aid', 'isEmergency': false},
    {'category': 'Legal', 'color': AppColors.warning, 'icon': Icons.balance_rounded,
      'name': 'Legal Aid Committee', 'number': '01-4262698', 'desc': 'District Legal Aid', 'isEmergency': false},
    {'category': 'Legal', 'color': AppColors.warning, 'icon': Icons.account_balance_rounded,
      'name': 'Supreme Court', 'number': '01-4664480', 'desc': 'Supreme Court Nepal', 'isEmergency': false},
    {'category': 'Legal', 'color': AppColors.warning, 'icon': Icons.diversity_3_rounded,
      'name': 'NHRC', 'number': '01-4200160', 'desc': 'Human Rights Commission', 'isEmergency': false},

    // Government
    {'category': 'Government', 'color': AppColors.textSecondary, 'icon': Icons.report_problem_rounded,
      'name': 'CIAA', 'number': '1113', 'desc': 'Anti-Corruption — Toll Free', 'isEmergency': false},
    {'category': 'Government', 'color': AppColors.textSecondary, 'icon': Icons.how_to_vote_rounded,
      'name': 'Election Commission', 'number': '01-4770680', 'desc': 'Election Fraud Report', 'isEmergency': false},
    {'category': 'Government', 'color': AppColors.textSecondary, 'icon': Icons.electric_bolt_rounded,
      'name': 'NEA', 'number': '1199', 'desc': 'Nepal Electricity Authority', 'isEmergency': false},
    {'category': 'Government', 'color': AppColors.textSecondary, 'icon': Icons.local_gas_station_rounded,
      'name': 'NOC', 'number': '01-4279622', 'desc': 'Nepal Oil Corporation', 'isEmergency': false},
  ];

  Future<void> _callNumber(String number) async {
    final clean = number.replaceAll('-', '').replaceAll(' ', '');
    final uri = Uri.parse('tel:$clean');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  List<Map<String, dynamic>> get _filtered {
    if (_selectedCategory == 'सबै') return _helplines;
    return _helplines.where((h) => h['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Helplines', showBack: false),
      body: Column(
        children: [
          // SOS Banner
          Container(
            margin: const EdgeInsets.all(AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.danger.withOpacity(0.3), AppColors.danger.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.danger.withOpacity(0.5), width: 2),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.sos_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Emergency मा तुरुन्त call गर्नुस्!',
                          style: AppTypography.titleLarge.copyWith(color: AppColors.danger)),
                      Text('Nepal Police: 100 | Cyber Bureau: 1177',
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _callNumber('100'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text('100', style: AppTypography.titleLarge.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),

          // Category filter
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final isSelected = _selectedCategory == cat['label'];
                final color = cat['color'] as Color;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['label'] as String),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withOpacity(0.15) : AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: isSelected ? color : AppColors.borderDark),
                    ),
                    child: Row(
                      children: [
                        Icon(cat['icon'] as IconData, color: isSelected ? color : AppColors.textHint, size: 14),
                        const SizedBox(width: 4),
                        Text(cat['label'] as String,
                            style: AppTypography.labelSmall.copyWith(
                                color: isSelected ? color : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Helplines list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _filtered.length + 1,
              itemBuilder: (context, i) {
                if (i == _filtered.length) return const TsFooter();
                final h = _filtered[i];
                final color = h['color'] as Color;
                final isEmergency = h['isEmergency'] as bool;

                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isEmergency ? color.withOpacity(0.08) : AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: isEmergency ? color.withOpacity(0.4) : AppColors.borderDark,
                      width: isEmergency ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
                    leading: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(h['icon'] as IconData, color: color, size: 22),
                    ),
                    title: Row(
                      children: [
                        Text(h['name'] as String,
                            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary)),
                        if (isEmergency) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text('Emergency',
                                style: AppTypography.labelSmall.copyWith(color: color, fontSize: 9)),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(h['desc'] as String,
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                    trailing: GestureDetector(
                      onTap: () => _callNumber(h['number'] as String),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.call_rounded, color: Colors.white, size: 16),
                            Text(h['number'] as String,
                                style: AppTypography.labelSmall.copyWith(
                                    color: Colors.white, fontSize: 10),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 4),
    );
  }
}
