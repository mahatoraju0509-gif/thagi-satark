import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../widgets/common/ts_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'App बारे', showBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryRed.withOpacity(0.2), AppColors.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  // App logo
                  Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryRed.withOpacity(0.5), width: 2),
                    ),
                    child: Image.asset('assets/images/logo.png', width: 90, height: 90, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('ठगी सतर्क', style: AppTypography.headlineLarge.copyWith(color: AppColors.primaryRed)),
                  Text('Nepal\'s First AI Fraud Awareness App',
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accentCyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
                    ),
                    child: Text('Version 1.0.0 — 2083 BS',
                        style: AppTypography.labelLarge.copyWith(color: AppColors.accentCyan)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Mission
                  _buildSection(
                    icon: Icons.flag_rounded,
                    color: AppColors.primaryRed,
                    title: 'हाम्रो उद्देश्य',
                    content: 'नेपालका प्रत्येक नागरिकलाई ठगीबाट सुरक्षित राख्नु। डिजिटल जागरण मार्फत fraud awareness फैलाउनु र Nepal लाई fraud-free बनाउनु।',
                  ),

                  // Vision
                  _buildSection(
                    icon: Icons.visibility_rounded,
                    color: AppColors.accentCyan,
                    title: 'हाम्रो दृष्टिकोण',
                    content: 'एक यस्तो Nepal जहाँ कुनै पनि नागरिक ठगिँदैन। Technology र Awareness को संयोजनले fraud-free समाज निर्माण।',
                  ),

                  // Features
                  _buildSection(
                    icon: Icons.stars_rounded,
                    color: AppColors.gold,
                    title: 'App का विशेषताहरू',
                    content: null,
                    widget: Column(
                      children: [
                        _featureRow(Icons.book_rounded, AppColors.primaryRed, '३० प्रकारका ठगी — विस्तृत जानकारी'),
                        _featureRow(Icons.quiz_rounded, AppColors.accentCyan, '१०००+ Quiz Questions — सिक्नुस् खेल्दै'),
                        _featureRow(Icons.verified_rounded, AppColors.success, 'Agency Verify — Registered छ कि छैन'),
                        _featureRow(Icons.map_rounded, AppColors.warning, 'Fraud Map — जिल्लाअनुसार खतरा'),
                        _featureRow(Icons.gavel_rounded, AppColors.gold, 'Legal Guide — Nepal का real laws'),
                        _featureRow(Icons.call_rounded, AppColors.danger, '३०+ Helplines — एकै ठाउँमा'),
                        _featureRow(Icons.report_rounded, AppColors.saffron, 'Report System — ठगी report गर्नुस्'),
                        _featureRow(Icons.notifications_rounded, AppColors.accentCyan, 'Real-time Alerts — सचेत रहनुस्'),
                        _featureRow(Icons.smart_toy_rounded, AppColors.success, 'AI Checker — Gemini powered'),
                        _featureRow(Icons.wifi_off_rounded, AppColors.primaryRed, '100% Offline — Internet नचाहिने'),
                      ],
                    ),
                  ),

                  // Developer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.gold.withOpacity(0.1), AppColors.background],
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.code_rounded, color: AppColors.gold, size: 20),
                            const SizedBox(width: 8),
                            Text('निर्माता', style: AppTypography.titleLarge.copyWith(color: AppColors.gold)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            // Developer photo
                            Container(
                              width: 80, height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 2),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/raju.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stack) => Container(
                                    color: AppColors.surfaceDark,
                                    child: const Icon(Icons.person_rounded, color: AppColors.gold, size: 40),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Raju Mahato', style: AppTypography.headlineMedium.copyWith(color: AppColors.gold)),
                                  Text('Founder & Developer', style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                                  const SizedBox(height: 4),
                                  Text('KCG Student, Kyoto Japan', style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                                  const SizedBox(height: 4),
Text('📱 +81 090-3669-4264', style: AppTypography.labelSmall.copyWith(color: AppColors.success)),
                                  Text('Yamunamai-1 (Jetharahiya), Rautahat, Nepal', style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '"Nepal को प्रत्येक नागरिकलाई ठगीबाट बचाउने सपनाले यो app बनाएको हो। Technology को सदुपयोगले हामी fraud-free Nepal बनाउन सक्छौं।"',
                          style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontStyle: FontStyle.italic,
                              height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        // Social links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton('EduPath AI', Icons.school_rounded, AppColors.accentCyan,
                                'https://edupath-ai.vercel.app'),
                            const SizedBox(width: AppSpacing.sm),
                            _socialButton('WhatsApp', Icons.chat_rounded, AppColors.success, 'https://wa.me/819003669264'),
                    _socialButton('Facebook', Icons.facebook_rounded, AppColors.accentCyan,
                                'https://www.facebook.com/share/18DzpGha4J/?mibextid=wwXIfr'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Stats
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.bar_chart_rounded, color: AppColors.accentCyan, size: 20),
                          const SizedBox(width: 8),
                          Text('App Statistics', style: AppTypography.titleLarge.copyWith(color: AppColors.accentCyan)),
                        ]),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Expanded(child: _statBox('३०+', 'Fraud Types', AppColors.primaryRed)),
                            const SizedBox(width: 8),
                            Expanded(child: _statBox('१०००+', 'Quiz Questions', AppColors.accentCyan)),
                            const SizedBox(width: 8),
                            Expanded(child: _statBox('३०+', 'Helplines', AppColors.success)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: _statBox('७७', 'Districts', AppColors.gold)),
                            const SizedBox(width: 8),
                            Expanded(child: _statBox('१०+', 'Legal Laws', AppColors.warning)),
                            const SizedBox(width: 8),
                            Expanded(child: _statBox('100%', 'Offline', AppColors.saffron)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Platform
                  _buildSection(
                    icon: Icons.apps_rounded,
                    color: AppColors.saffron,
                    title: 'Platform',
                    content: null,
                    widget: Column(
                      children: [
                        _platformRow(Icons.android_rounded, AppColors.success, 'Android App', 'Google Play Store मा Available'),
                        _platformRow(Icons.web_rounded, AppColors.accentCyan, 'Web App', 'edupath-ai.vercel.app'),
                        _platformRow(Icons.school_rounded, AppColors.gold, 'EduPath AI', 'Nepal\'s Study Abroad Platform'),
                      ],
                    ),
                  ),

                  // Disclaimer
                  Container(
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
                          Text('Disclaimer', style: AppTypography.titleMedium.copyWith(color: AppColors.warning)),
                        ]),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'यो app educational र awareness purpose को लागि बनाइएको हो। Official complaint को लागि Nepal Police, Cyber Bureau, र सम्बन्धित सरकारी निकायमा जानुस्।',
                          style: AppTypography.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Copyright
                  Center(
                    child: Column(
                      children: [
                        Text('© 2083 BS — ठगी सतर्क',
                            style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                        Text('Made with ❤️ for Nepal',
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primaryRed)),
                        const SizedBox(height: 4),
                        Text('Developed by Raju Mahato, Japan',
                            style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color color,
    required String title,
    String? content,
    Widget? widget,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: AppTypography.titleLarge.copyWith(color: color)),
          ]),
          const SizedBox(height: AppSpacing.sm),
          if (content != null)
            Text(content, style: AppTypography.bodyMedium.copyWith(height: 1.6)),
          if (widget != null) widget,
        ],
      ),
    );
  }

  Widget _featureRow(IconData icon, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTypography.bodyMedium)),
      ]),
    );
  }

  Widget _platformRow(IconData icon, Color color, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.titleMedium.copyWith(color: color)),
              Text(desc, style: AppTypography.bodyMedium),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _socialButton(String label, IconData icon, Color color, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: AppTypography.labelLarge.copyWith(color: color)),
        ]),
      ),
    );
  }

  Widget _statBox(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: AppTypography.headlineMedium.copyWith(color: color)),
          Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
