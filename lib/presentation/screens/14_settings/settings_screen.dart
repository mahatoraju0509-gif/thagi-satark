import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_footer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Settings'),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Profile card
                Container(
                  margin: const EdgeInsets.all(AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryRed.withOpacity(0.15), AppColors.background],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryRed.withOpacity(0.15),
                          border: Border.all(color: AppColors.primaryRed.withOpacity(0.4), width: 2),
                        ),
                        child: Image.asset('assets/images/logo.png', width: 40, height: 40, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ठगी सतर्क', style: AppTypography.titleLarge),
                            Text('Nepal\'s #1 Fraud Awareness App',
                                style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.location_on_rounded, color: AppColors.success, size: 12),
                                  const SizedBox(width: 4),
                                  Text(settings.selectedDistrict,
                                      style: AppTypography.labelSmall.copyWith(color: AppColors.success)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Location settings
                _buildSectionHeader('📍 स्थान सेटिङ'),
                _buildSettingTile(
                  icon: Icons.location_on_rounded,
                  color: AppColors.primaryRed,
                  title: 'District Alerts',
                  subtitle: 'आफ्नो जिल्ला छान्नुस् — ${settings.selectedDistrict}',
                  onTap: () => _showDistrictPicker(context, settings),
                ),

                // Notification settings
                _buildSectionHeader('🔔 Notification सेटिङ'),
                _buildSwitchTile(
                  icon: Icons.notifications_rounded,
                  color: AppColors.warning,
                  title: 'Fraud Alerts',
                  subtitle: 'नयाँ fraud alerts को notification',
                  value: settings.notificationsEnabled,
                  onChanged: (v) => settings.setNotifications(v),
                ),
                _buildSwitchTile(
                  icon: Icons.emergency_rounded,
                  color: AppColors.danger,
                  title: 'Emergency Alerts',
                  subtitle: 'अति उच्च जोखिमको तुरुन्त notification',
                  value: settings.emergencyAlertsEnabled,
                  onChanged: (v) => settings.setEmergencyAlerts(v),
                ),

                // App settings
                _buildSectionHeader('⚙️ App सेटिङ'),
                _buildSwitchTile(
                  icon: Icons.dark_mode_rounded,
                  color: AppColors.accentCyan,
                  title: 'Dark Mode',
                  subtitle: 'Dark theme — आँखालाई आरामदायी',
                  value: true,
                  onChanged: (v) {},
                ),
                _buildSwitchTile(
                  icon: Icons.language_rounded,
                  color: AppColors.gold,
                  title: 'नेपाली भाषा',
                  subtitle: 'App को भाषा — नेपाली',
                  value: true,
                  onChanged: (v) {},
                ),
                _buildSwitchTile(
                  icon: Icons.wifi_off_rounded,
                  color: AppColors.success,
                  title: 'Offline Mode',
                  subtitle: 'Internet नभए पनि काम गर्छ',
                  value: true,
                  onChanged: (v) {},
                ),

                // Quick actions
                _buildSectionHeader('🚀 Quick Actions'),
                _buildSettingTile(
                  icon: Icons.quiz_rounded,
                  color: AppColors.accentCyan,
                  title: 'Quiz खेल्नुस्',
                  subtitle: 'Fraud awareness quiz — सिक्नुस् खेल्दै',
                  onTap: () => Navigator.pushNamed(context, '/quiz'),
                ),
                _buildSettingTile(
                  icon: Icons.verified_rounded,
                  color: AppColors.success,
                  title: 'Agency Verify',
                  subtitle: 'Agency registered छ कि छैन check गर्नुस्',
                  onTap: () => Navigator.pushNamed(context, '/verify'),
                ),
                _buildSettingTile(
                  icon: Icons.map_rounded,
                  color: AppColors.warning,
                  title: 'Fraud Map',
                  subtitle: 'जिल्लाअनुसार fraud खतरा हेर्नुस्',
                  onTap: () => Navigator.pushNamed(context, '/fraud-map'),
                ),
                _buildSettingTile(
                  icon: Icons.gavel_rounded,
                  color: AppColors.gold,
                  title: 'Legal Guide',
                  subtitle: 'Nepal का real fraud laws',
                  onTap: () => Navigator.pushNamed(context, '/legal'),
                ),

                // Support
                _buildSectionHeader('💬 सहयोग र जानकारी'),
                _buildSettingTile(
                  icon: Icons.info_rounded,
                  color: AppColors.accentCyan,
                  title: 'App बारे',
                  subtitle: 'Developer info, version, features',
                  onTap: () => Navigator.pushNamed(context, '/about'),
                ),
                _buildSettingTile(
                  icon: Icons.star_rounded,
                  color: AppColors.gold,
                  title: 'App Rate गर्नुस्',
                  subtitle: 'Play Store मा ५ star review दिनुस्',
                  onTap: () => _launchUrl('https://play.google.com/store'),
                ),
                _buildSettingTile(
                  icon: Icons.share_rounded,
                  color: AppColors.success,
                  title: 'App Share गर्नुस्',
                  subtitle: 'परिवार र साथीलाई share गर्नुस्',
                  onTap: () => Share.share(
                    'ठगी सतर्क — Nepal को #1 Fraud Awareness App!\nDownload: https://edupath-ai.vercel.app\n\nआफ्नो परिवारलाई ठगीबाट बचाउनुस्! 🛡️',
                    subject: 'ठगी सतर्क App',
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.bug_report_rounded,
                  color: AppColors.danger,
                  title: 'Bug Report गर्नुस्',
                  subtitle: 'कुनै समस्या भए जानकारी दिनुस्',
                  onTap: () => _launchUrl('https://wa.me/819003669264?text=ठगी सतर्क App मा problem: '),
                ),
                _buildSettingTile(
                  icon: Icons.facebook_rounded,
                  color: AppColors.accentCyan,
                  title: 'Facebook Page',
                  subtitle: 'EduPath AI — fraud awareness content',
                  onTap: () => _launchUrl('https://www.facebook.com/share/18DzpGha4J/?mibextid=wwXIfr'),
                ),
                _buildSettingTile(
                  icon: Icons.web_rounded,
                  color: AppColors.saffron,
                  title: 'Website',
                  subtitle: 'edupath-ai.vercel.app',
                  onTap: () => _launchUrl('https://edupath-ai.vercel.app'),
                ),

                // Emergency contacts
                _buildSectionHeader('🚨 Emergency Contacts'),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      _emergencyRow('Nepal Police', '100', AppColors.danger),
                      _emergencyRow('Cyber Bureau', '1177', AppColors.accentCyan),
                      _emergencyRow('DoFE', '1180', AppColors.primaryRed),
                      _emergencyRow('NRB', '1414', AppColors.gold),
                      _emergencyRow('CIAA', '1113', AppColors.warning),
                      _emergencyRow('महिला आयोग', '1145', AppColors.saffron),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // App info bottom
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', width: 40, height: 40, fit: BoxFit.contain),
                      const SizedBox(height: 8),
                      Text('ठगी सतर्क', style: AppTypography.titleLarge),
                      Text('Version 1.0.0 — 2083 BS', style: AppTypography.labelSmall),
                      const SizedBox(height: 4),
                      Text('नेपालका लागि बनाइएको 🇳🇵',
                          style: AppTypography.labelSmall.copyWith(color: AppColors.gold)),
                      const SizedBox(height: 4),
                      Text('Developed by Raju Mahato, Japan',
                          style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),
                const TsFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _emergencyRow(String name, String number, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.call_rounded, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(name, style: AppTypography.bodyMedium)),
          Text(number, style: AppTypography.titleMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Text(title,
          style: AppTypography.labelLarge.copyWith(color: AppColors.textHint, letterSpacing: 1)),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleMedium),
                  Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryRed,
            activeTrackColor: AppColors.primaryRed.withOpacity(0.3),
            inactiveThumbColor: AppColors.textHint,
            inactiveTrackColor: AppColors.surfaceLight,
          ),
        ],
      ),
    );
  }

  void _showDistrictPicker(BuildContext context, SettingsProvider settings) {
    final districts = [
      'सबै','काठमाडौं','ललितपुर','भक्तपुर','पोखरा','चितवन',
      'रौतहट','बारा','पर्सा','सर्लाही','महोत्तरी','धनुषा',
      'सिराहा','सप्तरी','मोरङ','सुनसरी','झापा','इलाम',
      'ताप्लेजुङ','धनकुटा','भोजपुर','काभ्रे','सिन्धुली',
      'रामेछाप','दोलखा','सोलुखुम्बु','ओखलढुङ्गा','खोटाङ',
      'उदयपुर','गोर्खा','लमजुङ','तनहुँ','कास्की','स्याङ्जा',
      'पर्वत','बाग्लुङ','म्याग्दी','मुस्ताङ','मनाङ',
      'रुपन्देही','कपिलवस्तु','पाल्पा','नवलपुर','गुल्मी',
      'अर्घाखाँची','प्युठान','रोल्पा','दाङ','बाँके','बर्दिया',
      'सुर्खेत','दैलेख','जाजरकोट','डोल्पा','जुम्ला','कालिकोट',
      'मुगु','हुम्ला','बझाङ','बाजुरा','अछाम','डोटी','बैतडी',
      'डडेलधुरा','दार्चुला','कञ्चनपुर','कैलाली','नुवाकोट',
      'रसुवा','धादिङ','मकवानपुर','सिन्धुपाल्चोक',
      'रुकुम पूर्व','रुकुम पश्चिम','सल्यान','पाँचथर',
      'जनकपुर','वीरगञ्ज','बुटवल','हेटौंडा','धरान','भरतपुर',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.primaryRed),
                  const SizedBox(width: 8),
                  Text('जिल्ला छान्नुस्', style: AppTypography.headlineMedium),
                ],
              ),
            ),
            const Divider(color: Colors.white10),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: districts.length,
                itemBuilder: (context, index) {
                  final d = districts[index];
                  final isSelected = settings.selectedDistrict == d;
                  return ListTile(
                    leading: Icon(
                      isSelected ? Icons.location_on_rounded : Icons.location_city_rounded,
                      color: isSelected ? AppColors.primaryRed : AppColors.textHint,
                      size: 20,
                    ),
                    title: Text(d, style: AppTypography.titleMedium.copyWith(
                        color: isSelected ? AppColors.primaryRed : AppColors.textPrimary)),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryRed)
                        : null,
                    onTap: () {
                      settings.setDistrict(d);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
