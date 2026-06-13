import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/alert_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_footer.dart';
import '../../../data/models/alert_model.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedDistrict = 'सबै';

  final List<String> _districts = [
    'सबै', 'काठमाडौं', 'रौतहट', 'सप्तरी', 'पोखरा',
    'चितवन', 'धनुषा', 'मोरङ', 'सुनसरी', 'रुपन्देही',
  ];

  final List<Map<String, dynamic>> _filters = [
    {'label': 'सबै', 'color': AppColors.textPrimary, 'icon': Icons.apps_rounded},
    {'label': 'उच्च', 'color': AppColors.danger, 'icon': Icons.warning_rounded},
    {'label': 'मध्यम', 'color': AppColors.warning, 'icon': Icons.info_rounded},
    {'label': 'investment', 'color': AppColors.gold, 'icon': Icons.trending_up_rounded},
    {'label': 'employment', 'color': AppColors.primaryRed, 'icon': Icons.flight_rounded},
    {'label': 'digital', 'color': AppColors.accentCyan, 'icon': Icons.computer_rounded},
    {'label': 'cooperative', 'color': AppColors.accentCyan, 'icon': Icons.account_balance_rounded},
    {'label': 'property', 'color': AppColors.success, 'icon': Icons.home_rounded},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertProvider>().loadDummyAlerts();
    });
  }

  Future<void> _callNumber(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'critical': return AppColors.danger;
      case 'high': return AppColors.primaryRed;
      case 'medium': return AppColors.warning;
      default: return AppColors.success;
    }
  }

  String _getSeverityLabel(String severity) {
    switch (severity) {
      case 'critical': return '🔴 अति उच्च';
      case 'high': return '🟠 उच्च';
      case 'medium': return '🟡 मध्यम';
      default: return '🟢 कम';
    }
  }

  IconData _getFraudIcon(String type) {
    switch (type) {
      case 'investment': return Icons.trending_up_rounded;
      case 'employment': return Icons.flight_rounded;
      case 'digital': return Icons.computer_rounded;
      case 'cooperative': return Icons.account_balance_rounded;
      case 'property': return Icons.home_rounded;
      case 'education': return Icons.school_rounded;
      case 'health': return Icons.health_and_safety_rounded;
      case 'financial': return Icons.currency_rupee_rounded;
      case 'government': return Icons.work_rounded;
      case 'social': return Icons.people_rounded;
      default: return Icons.warning_rounded;
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} मिनेट अघि';
    if (diff.inHours < 24) return '${diff.inHours} घण्टा अघि';
    return '${diff.inDays} दिन अघि';
  }

  List<AlertModel> _getFilteredByDistrict(List<AlertModel> alerts) {
    if (_selectedDistrict == 'सबै') return alerts;
    return alerts.where((a) => a.district == _selectedDistrict || a.district == 'सबै').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Fraud Alerts', showBack: false),
      body: Consumer<AlertProvider>(
        builder: (context, provider, _) {
          final filtered = _getFilteredByDistrict(provider.alerts);
          final unread = filtered.where((a) => !a.isRead).length;

          return Column(
            children: [
              // Unread banner
              if (unread > 0)
                Container(
                  margin: const EdgeInsets.all(AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.danger.withOpacity(0.2), AppColors.danger.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.danger.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                        child: Text('$unread', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text('$unread वटा नयाँ alerts छन् — हेर्नुस्!',
                            style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                      ),
                      GestureDetector(
                        onTap: () => provider.markAllAsRead(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            border: Border.all(color: AppColors.danger.withOpacity(0.4)),
                          ),
                          child: Text('सबै पढ्नुस्',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.danger)),
                        ),
                      ),
                    ],
                  ),
                ),

              // Severity filter
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  itemCount: _filters.length,
                  itemBuilder: (context, i) {
                    final f = _filters[i];
                    final isSelected = provider.selectedFilter == f['label'];
                    final color = f['color'] as Color;
                    return GestureDetector(
                      onTap: () => provider.setFilter(f['label'] as String),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? color.withOpacity(0.15) : AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: isSelected ? color : AppColors.borderDark),
                        ),
                        child: Row(
                          children: [
                            Icon(f['icon'] as IconData, color: isSelected ? color : AppColors.textHint, size: 14),
                            const SizedBox(width: 4),
                            Text(f['label'] as String,
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

              // District filter
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  itemCount: _districts.length,
                  itemBuilder: (context, i) {
                    final isSelected = _selectedDistrict == _districts[i];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDistrict = _districts[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accentCyan.withOpacity(0.15) : AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: isSelected ? AppColors.accentCyan : AppColors.borderDark),
                        ),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.location_on_rounded, color: AppColors.accentCyan, size: 12),
                            if (isSelected) const SizedBox(width: 2),
                            Text(_districts[i],
                                style: AppTypography.labelSmall.copyWith(
                                    color: isSelected ? AppColors.accentCyan : AppColors.textSecondary,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Alerts list
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 64),
                            const SizedBox(height: AppSpacing.md),
                            Text('यस क्षेत्रमा कुनै alert छैन!',
                                style: AppTypography.titleLarge.copyWith(color: AppColors.success)),
                            Text('सुरक्षित रहनुस्!', style: AppTypography.bodyMedium),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        itemCount: filtered.length + 1,
                        itemBuilder: (context, i) {
                          if (i == filtered.length) return const TsFooter();
                          final alert = filtered[i];
                          return _buildAlertCard(alert, provider);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAlertCard(AlertModel alert, AlertProvider provider) {
    final color = _getSeverityColor(alert.severity);
    final isUnread = !alert.isRead;

    return GestureDetector(
      onTap: () {
        provider.markAsRead(alert.id);
        _showAlertDetail(alert);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isUnread ? color.withOpacity(0.06) : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isUnread ? color.withOpacity(0.5) : AppColors.borderDark,
            width: isUnread ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(_getFraudIcon(alert.fraudType), color: color, size: 22),
              ),
              const SizedBox(width: AppSpacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(_getSeverityLabel(alert.severity),
                              style: AppTypography.labelSmall.copyWith(color: color, fontSize: 9)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accentCyan.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 9, color: AppColors.accentCyan),
                              const SizedBox(width: 2),
                              Text(alert.district,
                                  style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.accentCyan, fontSize: 9)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (isUnread)
                          Container(
                            width: 8, height: 8,
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(alert.titleNp,
                        style: AppTypography.titleMedium.copyWith(
                            color: isUnread ? AppColors.textPrimary : AppColors.textSecondary,
                            fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(alert.descriptionNp,
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 12, color: AppColors.textHint),
                        const SizedBox(width: 4),
                        Text(_timeAgo(alert.createdAt),
                            style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                        const Spacer(),
                        Text('थप हेर्नुस् →',
                            style: AppTypography.labelSmall.copyWith(color: color)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDetail(AlertModel alert) {
    final color = _getSeverityColor(alert.severity);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, controller) => SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Severity badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Text(_getSeverityLabel(alert.severity),
                        style: AppTypography.labelLarge.copyWith(color: color)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accentCyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 14, color: AppColors.accentCyan),
                        const SizedBox(width: 4),
                        Text(alert.district,
                            style: AppTypography.labelLarge.copyWith(color: AppColors.accentCyan)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(alert.titleNp, style: AppTypography.headlineMedium),
              const SizedBox(height: AppSpacing.sm),

              // Time
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(_timeAgo(alert.createdAt),
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Description
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(alert.descriptionNp,
                    style: AppTypography.bodyMedium.copyWith(height: 1.7)),
              ),
              const SizedBox(height: AppSpacing.md),

              // Prevention tips
              Text('बच्ने तरिका:', style: AppTypography.titleMedium.copyWith(color: AppColors.success)),
              const SizedBox(height: AppSpacing.sm),
              ...(_getPreventionTips(alert.fraudType)).map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(tip, style: AppTypography.bodyMedium)),
                  ],
                ),
              )),
              const SizedBox(height: AppSpacing.md),

              // Action buttons
              Text('तुरुन्त सम्पर्क:', style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
              const SizedBox(height: AppSpacing.sm),
              ...(_getHelplines(alert.fraudType)).map((h) => GestureDetector(
                onTap: () => _callNumber(h['number']!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.call_rounded, color: AppColors.danger, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(h['name']!, style: AppTypography.titleMedium),
                            Text(h['number']!,
                                style: AppTypography.labelLarge.copyWith(color: AppColors.danger)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.danger,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text('Call', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              )),

              const SizedBox(height: AppSpacing.md),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/report'),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primaryRed,
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.report_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text('यस्तो ठगी भयो? Report गर्नुस्!',
                            style: AppTypography.buttonPrimary),
                      ],
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

  List<String> _getPreventionTips(String type) {
    switch (type) {
      case 'investment':
        return ['Guaranteed return भन्ने कहिल्यै trust नगर्नुस्', 'NRB registered institution मात्र', 'SEBON: sebon.gov.np मा verify गर्नुस्'];
      case 'employment':
        return ['DoFE: dofeprovident.gov.np मा agency verify गर्नुस्', 'Advance fee कहिल्यै नदिनुस्', 'Contract sign गर्नु अघि ध्यानले पढ्नुस्'];
      case 'digital':
        return ['OTP कसैलाई नदिनुस्', 'QR scan = send — receive होइन', 'Unknown links click नगर्नुस्'];
      case 'cooperative':
        return ['DoC: doc.gov.np मा registration verify गर्नुस्', '20%+ monthly interest = Ponzi scheme', 'पैसा राख्नु अघि audit report माग्नुस्'];
      case 'property':
        return ['Naapi मा lalpurja verify गर्नुस्', 'Payment bank transfer मात्र', 'Lawyer राख्नुस्'];
      default:
        return ['Verify गर्नुस् — Trust गर्नु अघि', 'Official channels मार्फत मात्र', 'शंका लागे Police: 100 मा call गर्नुस्'];
    }
  }

  List<Map<String, String>> _getHelplines(String type) {
    switch (type) {
      case 'employment':
        return [{'name': 'DoFE Hotline', 'number': '1180'}, {'name': 'Nepal Police', 'number': '100'}];
      case 'digital':
        return [{'name': 'Cyber Bureau', 'number': '1177'}, {'name': 'Nepal Police', 'number': '100'}];
      case 'investment':
      case 'cooperative':
        return [{'name': 'NRB', 'number': '1414'}, {'name': 'Nepal Police', 'number': '100'}];
      case 'property':
        return [{'name': 'Nepal Police', 'number': '100'}, {'name': 'Legal Aid', 'number': '01-4221740'}];
      default:
        return [{'name': 'Nepal Police', 'number': '100'}, {'name': 'Cyber Bureau', 'number': '1177'}];
    }
  }
}
