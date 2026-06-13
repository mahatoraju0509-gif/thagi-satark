import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/slide_animation.dart';
import '../../../data/models/fraud_model.dart';
import '../../../data/local/datasources/fraud_detail_data.dart';
import '../../widgets/common/ts_footer.dart';
import 'widgets/expandable_item.dart';

class FraudDetailScreen extends StatefulWidget {
  const FraudDetailScreen({super.key});

  @override
  State<FraudDetailScreen> createState() => _FraudDetailScreenState();
}

class _FraudDetailScreenState extends State<FraudDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'के हो?', 'कसरी?', 'किन?', 'Red Flags',
    'बच्ने', 'भयो भने?', 'Case', 'Data', 'Verify', 'कानुन',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'critical': return const Color(0xFFB71C1C);
      case 'high': return AppColors.danger;
      case 'medium': return AppColors.warning;
      default: return AppColors.success;
    }
  }

  String _getSeverityLabel(String severity) {
    switch (severity) {
      case 'critical': return '🔴 अति उच्च जोखिम';
      case 'high': return '🔴 उच्च जोखिम';
      case 'medium': return '🟠 मध्यम जोखिम';
      default: return '🟡 कम जोखिम';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'employment': return Icons.work_rounded;
      case 'digital': return Icons.phone_android_rounded;
      case 'financial': return Icons.account_balance_rounded;
      case 'property': return Icons.home_rounded;
      case 'social': return Icons.people_rounded;
      case 'health': return Icons.health_and_safety_rounded;
      case 'education': return Icons.school_rounded;
      case 'crime': return Icons.gavel_rounded;
      case 'transport': return Icons.directions_car_rounded;
      default: return Icons.warning_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fraud = ModalRoute.of(context)?.settings.arguments as FraudModel?;
    if (fraud == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(child: Text('Data भेटिएन')),
      );
    }

    final layerContent = FraudDetailData.getContent(fraud.id);
    final severityColor = _getSeverityColor(fraud.severity);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [severityColor.withOpacity(0.4), AppColors.background],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_rounded, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 52, height: 52,
                          decoration: BoxDecoration(
                            color: severityColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border: Border.all(color: severityColor.withOpacity(0.4)),
                          ),
                          child: Icon(_getCategoryIcon(fraud.category), color: severityColor, size: 28),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: severityColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: severityColor.withOpacity(0.4)),
                              ),
                              child: Text(_getSeverityLabel(fraud.severity),
                                  style: AppTypography.labelSmall.copyWith(color: severityColor)),
                            ),
                            const SizedBox(height: 4),
                            Text('${fraud.reportCount} cases reported',
                                style: AppTypography.labelSmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(fraud.titleNp, style: AppTypography.headlineLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(fraud.titleEn,
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: severityColor,
                    unselectedLabelColor: AppColors.textHint,
                    indicatorColor: severityColor,
                    dividerColor: AppColors.borderDark,
                    indicatorWeight: 3,
                    tabAlignment: TabAlignment.start,
                    labelStyle: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w700),
                    unselectedLabelStyle: AppTypography.labelSmall,
                    tabs: _tabs.map((t) => Tab(text: t)).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWhatIsIt(fraud),
                _buildHowItHappens(fraud, layerContent),
                _buildPsychology(fraud, layerContent),
                _buildRedFlags(fraud),
                _buildPrevention(fraud, layerContent),
                _buildRecovery(fraud),
                _buildRealCase(fraud, layerContent),
                _buildStatistics(fraud),
                _buildVerifyTools(fraud, layerContent),
                _buildLaws(fraud, layerContent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 1 — के हो?
  // ═══════════════════════════════════════
  Widget _buildWhatIsIt(FraudModel fraud) {
    final items = [
      {'icon': Icons.info_rounded, 'color': AppColors.accentCyan, 'title': 'परिभाषा', 'detail': fraud.descriptionNp},
      {'icon': Icons.people_rounded, 'color': AppColors.gold, 'title': 'को गर्छ?', 'detail': 'ठगहरू सामान्यतः चिनजानका व्यक्ति, fake agent, वा online platform मार्फत ${fraud.titleNp} गर्छन्। विश्वास जितेपछि trap मा फसाउँछन्।'},
      {'icon': Icons.location_on_rounded, 'color': AppColors.saffron, 'title': 'कहाँ हुन्छ?', 'detail': 'नेपालका सबै ७७ जिल्लामा यो ठगी हुन्छ। शहरी क्षेत्र, ग्रामीण क्षेत्र, र online — सबैतिर। ${fraud.reportCount}+ cases officially report भइसकेका छन्।'},
      {'icon': Icons.people_alt_rounded, 'color': AppColors.warning, 'title': 'को target हुन्छ?', 'detail': 'आर्थिक रूपले कमजोर, बेरोजगार युवा, र जानकारीको अभाव भएका व्यक्तिहरू बढी target हुन्छन्।'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          ...items.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value['title'] as String,
            detail: e.value['detail'] as String,
            color: e.value['color'] as Color,
            leadingIcon: e.value['icon'] as IconData,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 2 — कसरी हुन्छ?
  // ═══════════════════════════════════════
  Widget _buildHowItHappens(FraudModel fraud, FraudLayerContent content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.route_rounded, color: AppColors.primaryRed, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('ठगले यसरी trap मा फसाउँछ — हरेक step थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.primaryRed)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...content.howItHappens.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value.replaceFirst(RegExp(r'^Step \d+ — '), ''),
            detail: _getHowItHappensDetail(e.value),
            color: AppColors.primaryRed,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  String _getHowItHappensDetail(String step) {
    // Step title नै detail को रूपमा देखाउँछौं — थप context सहित
    final clean = step.replaceFirst(RegExp(r'^Step \d+ — '), '');
    return '$clean\n\nयो stage मा सतर्क रहनुस्। Verify नगरी कुनै कदम नचाल्नुस्।';
  }

  // ═══════════════════════════════════════
  // Layer 3 — किन फस्छन्?
  // ═══════════════════════════════════════
  Widget _buildPsychology(FraudModel fraud, FraudLayerContent content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.psychology_rounded, color: AppColors.warning, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('ठगले मानिसको कमजोरी target गर्छ — थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.warning)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...content.psychologyReasons.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value.split(' — ').first,
            detail: e.value.contains(' — ')
                ? '${e.value.split(' — ').last}\n\nयो psychological trigger बाट बच्न — कुनै पनि निर्णय गर्नु अघि परिवार र साथीसँग सल्लाह गर्नुस्।'
                : '${e.value}\n\nयो trap बाट बच्न सचेत रहनुस्।',
            color: AppColors.warning,
            leadingIcon: Icons.warning_amber_rounded,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 4 — Red Flags
  // ═══════════════════════════════════════
  Widget _buildRedFlags(FraudModel fraud) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.danger.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 28),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('यी signs देखिए तुरुन्त सावधान हुनुस्! थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...fraud.redFlags.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value,
            detail: '🚩 "${e.value}" — यो एउटा clear red flag हो।\n\nयो sign देखिए:\n• तुरुन्त रोक्नुस्\n• Verify गर्नुस्\n• परिवारलाई सूचित गर्नुस्\n• पैसा नदिनुस्',
            color: AppColors.danger,
            leadingIcon: Icons.flag_rounded,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 5 — बच्ने तरिका
  // ═══════════════════════════════════════
  Widget _buildPrevention(FraudModel fraud, FraudLayerContent content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_rounded, color: AppColors.success, size: 28),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('यी कदमहरू चाल्नुस् — प्रत्येक थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.success)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (content.preventionDetails.isNotEmpty)
            ...content.preventionDetails.asMap().entries.map((e) => ExpandableItem(
              index: e.key + 1,
              title: e.value.step,
              detail: e.value.detail,
              color: AppColors.success,
              leadingIcon: Icons.check_circle_rounded,
            ))
          else
            ...fraud.preventionSteps.asMap().entries.map((e) => ExpandableItem(
              index: e.key + 1,
              title: e.value,
              detail: '${e.value}\n\nयो कदम चाल्दा तपाईं ${fraud.titleNp} बाट सुरक्षित रहन सक्नुहुन्छ।',
              color: AppColors.success,
            )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 6 — ठगी भयो भने?
  // ═══════════════════════════════════════
  Widget _buildRecovery(FraudModel fraud) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accentCyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.emergency_rounded, color: AppColors.accentCyan, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('ठगी भइसक्यो? घबराउनु हुँदैन — प्रत्येक step थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...fraud.recoverySteps.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value,
            detail: _getRecoveryDetail(e.value, fraud),
            color: AppColors.accentCyan,
            leadingIcon: Icons.task_alt_rounded,
          )),
          const SizedBox(height: AppSpacing.md),
          // Helpline cards — clickable
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.danger.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.phone_rounded, color: AppColors.danger, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text('📞 तुरुन्त call गर्नुस्:',
                        style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...fraud.helplineNumbers.map((n) => GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse('tel:$n');
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: AppColors.danger.withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.call_rounded, color: AppColors.danger, size: 22),
                        const SizedBox(width: AppSpacing.sm),
                        Text(n, style: AppTypography.titleLarge.copyWith(color: AppColors.danger)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.danger,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Text('Call', style: AppTypography.labelSmall.copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  String _getRecoveryDetail(String step, FraudModel fraud) {
    if (step.toLowerCase().contains('dofे') || step.toLowerCase().contains('dofe')) {
      return '$step\n\n📍 DoFE कार्यालय: Kathmandu, Traineeship Road\n📞 Hotline: 1180 (Toll-free)\n🌐 Website: dofeprovident.gov.np\n\nसबै documents (receipt, contract, ID) लिएर जानुस्।';
    } else if (step.toLowerCase().contains('प्रहरी') || step.toLowerCase().contains('police')) {
      return '$step\n\n📞 Nepal Police: 100\n📍 नजिकको District Police Office मा जानुस्\n\nFIR दर्ता गर्दा लाग्ने documents:\n• तपाईंको ID (Citizenship)\n• Transaction proof (receipt, screenshot)\n• ठगको नाम/नम्बर/ठेगाना\n• सबै evidence';
    } else if (step.toLowerCase().contains('cyber') || step.toLowerCase().contains('1177')) {
      return '$step\n\n📞 Cyber Bureau: 1177\n🌐 cyberbureaunepal.gov.np\n\nOnline complaint गर्न सकिन्छ। सबै screenshot र evidence पहिले save गर्नुस्।';
    } else if (step.toLowerCase().contains('bank') || step.toLowerCase().contains('बैंक')) {
      return '$step\n\n⚡ यो सबैभन्दा urgent काम हो — जति चाँडो गर्नुहुन्छ, उति बढी chance छ पैसा फिर्ता हुने।\n\nCard को पछाडि लेखिएको number मा call गर्नुस् वा nearest branch मा जानुस्।';
    } else if (step.toLowerCase().contains('कागजात') || step.toLowerCase().contains('documents')) {
      return '$step\n\nराख्नुपर्ने documents:\n• Transaction receipt\n• Chat/message screenshots\n• Call records\n• Contract/agreement\n• ठगको ID/photo (भएमा)\n• Bank statement\n\nOriginal documents safe place मा राख्नुस्, copies बनाउनुस्।';
    } else if (step.toLowerCase().contains('nrb') || step.toLowerCase().contains('1414')) {
      return '$step\n\n📞 NRB: 1414\n🌐 nrb.org.np\n\nFinancial fraud को लागि NRB मा complaint दिनुस्। Transaction details र bank statements लिएर जानुस्।';
    }
    return '$step\n\nयो कदम तुरुन्त चाल्नुस्। जति ढिलो गर्नुहुन्छ, उति कम chance छ justice पाउने।\n\nसबै evidence सुरक्षित राख्नुस् र परिवारको सहयोग लिनुस्।';
  }

  // ═══════════════════════════════════════
  // Layer 7 — Real Case
  // ═══════════════════════════════════════
  Widget _buildRealCase(FraudModel fraud, FraudLayerContent content) {
    final c = content.realCase;
    final caseItems = [
      {
        'title': '👤 पीडितको परिचय',
        'detail': c.victimProfile,
        'color': AppColors.saffron,
      },
      {
        'title': '📖 के भयो? (पूरा घटना)',
        'detail': c.story,
        'color': AppColors.accentCyan,
      },
      {
        'title': '💸 कति नोक्सान भयो?',
        'detail': '${c.amountLost}\n\nयो सिर्फ आर्थिक नोक्सान हो। मानसिक trauma र सामाजिक प्रतिष्ठाको नोक्सान अझ बढी हुन सक्छ।',
        'color': AppColors.danger,
      },
      {
        'title': '💡 के सिके? (Important lesson)',
        'detail': c.lesson,
        'color': AppColors.success,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.saffron.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.saffron.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.history_edu_rounded, color: AppColors.saffron, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('वास्तविक घटना — प्रत्येक section थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.saffron)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...caseItems.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value['title'] as String,
            detail: e.value['detail'] as String,
            color: e.value['color'] as Color,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 8 — Statistics/Data
  // ═══════════════════════════════════════
  Widget _buildStatistics(FraudModel fraud) {
    final dataItems = [
      {
        'title': '📊 Reported Cases — ${fraud.reportCount}+',
        'detail': '${fraud.reportCount}+ cases officially report भइसकेका छन्।\n\nवास्तविक संख्या धेरै बढी हुन सक्छ — धेरै victims लाज वा डरले report गर्दैनन्।\n\n⚠️ स्रोत: Nepal Police Annual Report (अनुमानित)',
        'color': AppColors.danger,
      },
      {
        'title': '🗺️ Geographic Coverage — ७७ जिल्ला',
        'detail': 'नेपालका सबै ७७ जिल्लामा यो ठगी हुन्छ।\n\nशहरी क्षेत्र (काठमाडौं, पोखरा, भरतपुर) मा बढी online fraud हुन्छ।\nग्रामीण क्षेत्रमा employment र land fraud बढी हुन्छ।',
        'color': AppColors.accentCyan,
      },
      {
        'title': '⚠️ जोखिम स्तर — ${fraud.severity == 'critical' ? 'अति उच्च' : fraud.severity == 'high' ? 'उच्च' : 'मध्यम'}',
        'detail': 'यो fraud को severity level "${fraud.severity}" छ।\n\nयसको मतलब:\n• पीडितको औसत नोक्सान ठूलो छ\n• Recovery गर्न गाह्रो छ\n• Prevention नै सबैभन्दा राम्रो उपाय हो',
        'color': AppColors.warning,
      },
      {
        'title': '📈 बढ्दो Trend',
        'detail': 'Digital payment र online activity बढेसँगै ${fraud.titleNp} पनि बढ्दैछ।\n\nNRB र Nepal Police को data अनुसार cyber fraud cases हरेक वर्ष बढ्दैछन्।\n\nAwareness नै सबैभन्दा ठूलो weapon हो।',
        'color': AppColors.success,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accentCyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bar_chart_rounded, color: AppColors.accentCyan, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('तथ्याङ्क — प्रत्येक section थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...dataItems.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value['title'] as String,
            detail: e.value['detail'] as String,
            color: e.value['color'] as Color,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 9 — Verify Tools
  // ═══════════════════════════════════════
  Widget _buildVerifyTools(FraudModel fraud, FraudLayerContent content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accentCyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_rounded, color: AppColors.accentCyan, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('Verify गर्ने official sources — थिचेर details हेर्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...content.verifyTools.asMap().entries.map((e) {
            final tool = e.value;
            return ExpandableItem(
              index: e.key + 1,
              title: tool.name,
              detail: '${tool.description}\n\n🔗 ${tool.url}\n\nयहाँ जाएर verify गर्न सकिन्छ। Official source मात्र trust गर्नुस्।',
              color: AppColors.accentCyan,
              leadingIcon: Icons.open_in_new_rounded,
              detailWidget: _buildVerifyToolDetail(tool),
            );
          }),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  Widget _buildVerifyToolDetail(VerifyToolData tool) {
    return Container(
      margin: const EdgeInsets.only(left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.accentCyan.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tool.description, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: () async {
              String url = tool.url;
              if (RegExp(r'^\d').hasMatch(url.replaceAll('-', '').replaceAll(' ', ''))) {
                url = 'tel:${url.replaceAll(' ', '')}';
              } else if (!url.startsWith('http')) {
                url = 'https://$url';
              }
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.accentCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.accentCyan.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    RegExp(r'^\d').hasMatch(tool.url.replaceAll('-', ''))
                        ? Icons.call_rounded
                        : Icons.open_in_new_rounded,
                    color: AppColors.accentCyan, size: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    RegExp(r'^\d').hasMatch(tool.url.replaceAll('-', ''))
                        ? '${tool.url} मा Call गर्नुस्'
                        : '${tool.url} मा जानुस्',
                    style: AppTypography.labelLarge.copyWith(color: AppColors.accentCyan),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Layer 10 — कानुन
  // ═══════════════════════════════════════
  Widget _buildLaws(FraudModel fraud, FraudLayerContent content) {
    final law = content.lawDetails;
    final lawItems = [
      {
        'title': '⚖️ लागू हुने कानुन',
        'detail': '${law.mainLaw}\n\nयो कानुन अन्तर्गत ठगी गर्नेलाई कारबाही हुन्छ।',
        'color': AppColors.gold,
      },
      {
        'title': '🔒 ठगीलाई सजाय',
        'detail': '${law.punishment}\n\nनेपाल कानुन अनुसार यो ठगी गर्नेलाई कठोर सजाय छ। Justice पाउन हिम्मत गरेर report गर्नुस्।',
        'color': AppColors.danger,
      },
      {
        'title': '✅ तपाईंको अधिकार',
        'detail': law.yourRights.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n\n'),
        'color': AppColors.accentCyan,
      },
      {
        'title': '📋 Complaint गर्ने Process',
        'detail': law.complaintProcess.asMap().entries.map((e) => 'Step ${e.key + 1}: ${e.value}').join('\n\n'),
        'color': AppColors.success,
      },
      {
        'title': '🆓 निःशुल्क Legal Aid',
        'detail': 'पैसा नभए पनि कानुनी सहायता पाउन सकिन्छ:\n\n• District Legal Aid Committee — हरेक जिल्लामा\n• Nepal Bar Association: 01-4221740\n• Government Advocate Office\n• Women Legal Aid: 01-4268316\n\nन्याय सबैको अधिकार हो — पैसा नभए पनि।',
        'color': AppColors.saffron,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.gavel_rounded, color: AppColors.gold, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text('कानुनी जानकारी — प्रत्येक section थिच्नुस्:',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.gold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...lawItems.asMap().entries.map((e) => ExpandableItem(
            index: e.key + 1,
            title: e.value['title'] as String,
            detail: e.value['detail'] as String,
            color: e.value['color'] as Color,
          )),
          const SizedBox(height: AppSpacing.md),
          _buildConclusionCard(fraud.conclusionNp),
          const SizedBox(height: AppSpacing.md),
          const TsFooter(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // Helper Widgets
  // ═══════════════════════════════════════
  Widget _buildConclusionCard(String conclusion) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryRed.withOpacity(0.15),
            AppColors.primaryRedDark.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_rounded, color: AppColors.gold, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('निचोड', style: AppTypography.titleMedium.copyWith(color: AppColors.gold)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(conclusion, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
