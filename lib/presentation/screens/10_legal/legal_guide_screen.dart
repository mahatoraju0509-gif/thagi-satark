import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_footer.dart';

class LegalGuideScreen extends StatefulWidget {
  const LegalGuideScreen({super.key});

  @override
  State<LegalGuideScreen> createState() => _LegalGuideScreenState();
}

class _LegalGuideScreenState extends State<LegalGuideScreen> {
  String _selectedFraud = 'Foreign Employment';
  int? _expandedIndex;

  final List<Map<String, dynamic>> _fraudTypes = [
    {'label': 'Foreign Employment', 'icon': Icons.flight_rounded, 'color': AppColors.primaryRed},
    {'label': 'Online Fraud', 'icon': Icons.computer_rounded, 'color': AppColors.accentCyan},
    {'label': 'Cooperative', 'icon': Icons.account_balance_rounded, 'color': AppColors.gold},
    {'label': 'जग्गा ठगी', 'icon': Icons.home_rounded, 'color': AppColors.success},
    {'label': 'सरकारी जागिर', 'icon': Icons.work_rounded, 'color': AppColors.saffron},
    {'label': 'Investment', 'icon': Icons.trending_up_rounded, 'color': AppColors.warning},
  ];

  final Map<String, Map<String, dynamic>> _legalData = {
    'Foreign Employment': {
      'color': AppColors.primaryRed,
      'icon': Icons.flight_rounded,
      'mainLaw': 'वैदेशिक रोजगार ऐन, २०६४',
      'punishment': '५ वर्षसम्म कैद र Rs.50,000 देखि Rs.2,00,000 सम्म जरिवाना',
      'sections': [
        {'title': 'दफा ३५ — Advance fee माग्न निषेध', 'detail': 'कुनै पनि Manpower agency ले काम दिनुअघि पैसा माग्न पाउँदैन। यसो गर्नु कानुन विरुद्ध हो।'},
        {'title': 'दफा ३६ — Fake contract', 'detail': 'Nepal मा देखाएको भन्दा फरक काम/तलब दिनु अपराध। Destination country मा फरक contract देखाएमा agent जिम्मेवार।'},
        {'title': 'दफा ४२ — सजाय', 'detail': 'ठगी गर्ने agent लाई ५ वर्षसम्म कैद र Rs.2 lakh सम्म जरिवाना। License खारेज।'},
        {'title': 'दफा ५३ — Compensation', 'detail': 'पीडितले DoFE मार्फत compensation माग्न पाउँछ। Foreign Employment Welfare Fund बाट सहयोग।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Evidence collect गर्नुस्', 'color': AppColors.warning, 'icon': Icons.save_rounded,
          'desc': 'ठगसँगको सबै chat, payment receipt, contract, phone number screenshot गरेर save गर्नुस्।',
          'docs': ['Payment receipt (original)', 'Chat screenshot', 'Contract copy', 'Agent को ID/photo', 'Bank transaction proof']},
        {'step': 2, 'title': 'DoFE मा complaint', 'color': AppColors.accentCyan, 'icon': Icons.business_rounded,
          'desc': 'Department of Foreign Employment मा तुरुन्त complaint दर्ता गर्नुस्। Hotline: 1180',
          'office': 'DoFE, Tahachal, Kathmandu', 'phone': '1180 / 01-4991000', 'website': 'https://dofeprovident.gov.np',
          'docs': ['Written complaint', 'ID photocopy', 'Evidence documents', 'Payment receipts']},
        {'step': 3, 'title': 'Nepal Police FIR', 'color': AppColors.danger, 'icon': Icons.local_police_rounded,
          'desc': 'नजिकको District Police Office मा FIR दर्ता गर्नुस्। Cyber Bureau मा पनि complaint गर्नुस्।',
          'office': 'नजिकको District Police Office', 'phone': '100', 'website': 'https://nepalpolice.gov.np',
          'docs': ['FIR form', 'Citizenship copy', 'All evidence', 'Witness info']},
        {'step': 4, 'title': 'Legal Aid लिनुस्', 'color': AppColors.success, 'icon': Icons.gavel_rounded,
          'desc': 'District Legal Aid Committee बाट निःशुल्क legal help पाइन्छ। Nepal Bar Association: 01-4221740',
          'office': 'District Legal Aid Committee', 'phone': '01-4221740', 'website': 'https://nepalbar.org.np',
          'docs': ['Case details', 'All evidence copies']},
        {'step': 5, 'title': 'Court मा case', 'color': AppColors.gold, 'icon': Icons.account_balance_rounded,
          'desc': 'District Court मा criminal case file गर्नुस्। Compensation को civil case पनि file गर्न सकिन्छ।',
          'office': 'District Court', 'phone': '01-4262698',
          'docs': ['FIR copy', 'DoFE complaint copy', 'All evidence', 'Lawyer']},
      ],
      'helplines': [
        {'name': 'DoFE Hotline', 'number': '1180', 'color': AppColors.primaryRed},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.danger},
        {'name': 'Legal Aid', 'number': '01-4221740', 'color': AppColors.success},
        {'name': 'Welfare Fund', 'number': '01-4991000', 'color': AppColors.gold},
      ],
    },
    'Online Fraud': {
      'color': AppColors.accentCyan,
      'icon': Icons.computer_rounded,
      'mainLaw': 'Electronic Transaction Act, २०६३ + Criminal Code, २०७४',
      'punishment': '५ वर्षसम्म कैद र Rs.1,00,000 सम्म जरिवाना',
      'sections': [
        {'title': 'ETA दफा ४४ — Computer fraud', 'detail': 'Computer/internet मार्फत ठगी गर्नु ५ वर्षसम्म कैद। Data theft, unauthorized access पनि included।'},
        {'title': 'ETA दफा ४७ — Cyber crime', 'detail': 'Phishing, hacking, identity theft — सबै ETA अन्तर्गत। Electronic evidence court मा valid।'},
        {'title': 'Criminal Code दफा ३४२ — Cheating', 'detail': 'Online shopping fraud, fake investment — Criminal Code अन्तर्गत ठगी। Rs.1 lakh सम्म क्षतिपूर्ति।'},
        {'title': 'दफा ४८ — Sextortion', 'detail': 'Intimate photos/videos leak गर्ने threat दिनु — ५ वर्षसम्म कैद। Cyber Bureau: 1177 मा तुरुन्त report।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Evidence preserve गर्नुस्', 'color': AppColors.warning, 'icon': Icons.screenshot_rounded,
          'desc': 'सबै screenshots, URLs, transaction IDs, phone numbers save गर्नुस्। Delete नगर्नुस्।',
          'docs': ['Screenshots (timestamped)', 'Transaction ID', 'URLs', 'Phone/email records']},
        {'step': 2, 'title': 'Cyber Bureau complaint', 'color': AppColors.accentCyan, 'icon': Icons.security_rounded,
          'desc': 'Nepal Cyber Bureau मा online वा phone मार्फत complaint दर्ता गर्नुस्।',
          'office': 'Cyber Bureau, Kathmandu', 'phone': '1177', 'website': 'https://cybercrime.gov.np',
          'docs': ['Online complaint form', 'Screenshots', 'Transaction proof']},
        {'step': 3, 'title': 'Bank/Wallet notify गर्नुस्', 'color': AppColors.danger, 'icon': Icons.account_balance_rounded,
          'desc': 'तुरुन्त bank/eSewa/Khalti मा call गरेर transaction dispute गर्नुस्। जति चाँडो उति राम्रो।',
          'phone': 'eSewa: 16600172222 | Khalti: 16600185001',
          'docs': ['Transaction ID', 'Account details']},
        {'step': 4, 'title': 'Police FIR', 'color': AppColors.primaryRed, 'icon': Icons.local_police_rounded,
          'desc': 'नजिकको प्रहरी कार्यालयमा FIR दर्ता गर्नुस्। Digital evidence print गरेर लैजानुस्।',
          'office': 'नजिकको Police Office', 'phone': '100',
          'docs': ['FIR form', 'Citizenship', 'All printed evidence']},
        {'step': 5, 'title': 'Court case', 'color': AppColors.gold, 'icon': Icons.gavel_rounded,
          'desc': 'District Court मा ETA अन्तर्गत case file गर्नुस्। Cyber lawyer राख्नुस्।',
          'phone': '01-4221740 (Legal Aid)',
          'docs': ['FIR copy', 'Cyber Bureau complaint', 'All evidence', 'Cyber lawyer']},
      ],
      'helplines': [
        {'name': 'Cyber Bureau', 'number': '1177', 'color': AppColors.accentCyan},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.danger},
        {'name': 'eSewa', 'number': '16600172222', 'color': AppColors.success},
        {'name': 'Khalti', 'number': '16600185001', 'color': AppColors.gold},
      ],
    },
    'Cooperative': {
      'color': AppColors.gold,
      'icon': Icons.account_balance_rounded,
      'mainLaw': 'सहकारी ऐन, २०७४ + Criminal Code, २०७४',
      'punishment': '७ वर्षसम्म कैद र सम्पत्ति जफत',
      'sections': [
        {'title': 'सहकारी ऐन दफा ९१ — Fraud', 'detail': 'Members को पैसा हिनामिना गर्नु ७ वर्षसम्म कैद र सम्पत्ति जफत।'},
        {'title': 'दफा ९५ — False accounts', 'detail': 'Fake financial records राख्नु — criminal offense। Board members व्यक्तिगत रूपमा जिम्मेवार।'},
        {'title': 'Criminal Code दफा ३४५ — Misappropriation', 'detail': 'Public fund misuse — कैद र जरिवाना। CIAA मा पनि complaint गर्न सकिन्छ।'},
        {'title': 'Department of Cooperatives oversight', 'detail': 'DoC ले cooperative audit गर्छ। Irregularity देखिएमा DoC मा complaint दिनुस्।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Passbook/documents secure गर्नुस्', 'color': AppColors.warning, 'icon': Icons.book_rounded,
          'desc': 'Passbook, deposit slips, member certificate, share certificate — सबै secure राख्नुस्।',
          'docs': ['Passbook', 'Deposit receipts', 'Member certificate', 'Share certificate']},
        {'step': 2, 'title': 'DoC मा complaint', 'color': AppColors.gold, 'icon': Icons.business_rounded,
          'desc': 'Department of Cooperatives मा written complaint दिनुस्।',
          'office': 'DoC, Kathmandu', 'phone': '01-4229032', 'website': 'https://doc.gov.np',
          'docs': ['Written complaint', 'All deposit proofs', 'Member ID']},
        {'step': 3, 'title': 'CIAA मा report', 'color': AppColors.danger, 'icon': Icons.report_rounded,
          'desc': 'Corruption भएको छ भने CIAA: 1113 मा report गर्नुस्।',
          'office': 'CIAA, Kathmandu', 'phone': '1113', 'website': 'https://ciaa.gov.np',
          'docs': ['Evidence of corruption', 'Financial records']},
        {'step': 4, 'title': 'Police FIR + Court', 'color': AppColors.primaryRed, 'icon': Icons.local_police_rounded,
          'desc': 'प्रहरीमा FIR दर्ता गरेर District Court मा civil + criminal case file गर्नुस्।',
          'phone': '100', 'docs': ['All documents', 'FIR', 'Lawyer']},
      ],
      'helplines': [
        {'name': 'DoC', 'number': '01-4229032', 'color': AppColors.gold},
        {'name': 'CIAA', 'number': '1113', 'color': AppColors.danger},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.primaryRed},
        {'name': 'NRB', 'number': '1414', 'color': AppColors.accentCyan},
      ],
    },
    'जग्गा ठगी': {
      'color': AppColors.success,
      'icon': Icons.home_rounded,
      'mainLaw': 'Muluki Criminal Code, २०७४ + Land Act, २०२१',
      'punishment': '१० वर्षसम्म कैद र क्षतिपूर्ति',
      'sections': [
        {'title': 'Criminal Code दफा ३४६ — Property fraud', 'detail': 'Fake lalpurja प्रयोग गरेर जग्गा बेच्नु — १० वर्षसम्म कैद। Forgery को अलग case।'},
        {'title': 'Land Act — Unauthorized sale', 'detail': 'अरूको जग्गा बेच्नु — criminal offense। Malpot मा complaint दिनुस्।'},
        {'title': 'Criminal Code दफा २३२ — Forgery', 'detail': 'Fake lalpurja, fake stamp — ५ वर्षसम्म कैद। Forgery को separate charge।'},
        {'title': 'Property freeze order', 'detail': 'Court बाट disputed property freeze गराउन सकिन्छ। Tुरुन्त lawyer राख्नुस्।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Naapi मा verify गर्नुस्', 'color': AppColors.success, 'icon': Icons.map_rounded,
          'desc': 'Naapi कार्यालयमा lalpurja authentic छ कि verify गर्नुस्। निःशुल्क सेवा।',
          'office': 'Naapi, Survey Department', 'phone': '01-4521720', 'website': 'https://naapi.gov.np',
          'docs': ['Lalpurja copy', 'Plot number']},
        {'step': 2, 'title': 'Malpot मा complaint', 'color': AppColors.gold, 'icon': Icons.business_rounded,
          'desc': 'Land Revenue Office (Malpot) मा ownership dispute complaint दर्ता गर्नुस्।',
          'office': 'नजिकको Malpot कार्यालय', 'phone': '01-4200321',
          'docs': ['Ownership documents', 'Payment proof', 'Complaint letter']},
        {'step': 3, 'title': 'Police FIR दर्ता', 'color': AppColors.danger, 'icon': Icons.local_police_rounded,
          'desc': 'नजिकको प्रहरीमा FIR दर्ता गर्नुस्। Property freeze को लागि Court order माग्नुस्।',
          'phone': '100', 'docs': ['All land documents', 'Payment receipts', 'FIR form']},
        {'step': 4, 'title': 'District Court — Property freeze', 'color': AppColors.accentCyan, 'icon': Icons.gavel_rounded,
          'desc': 'Court बाट disputed property freeze गराउनुस् — अर्कोले बेच्न नसकोस्। Tुरुन्त lawyer राख्नुस्।',
          'phone': '01-4221740 (Legal Aid)', 'docs': ['FIR copy', 'Land documents', 'Lawyer']},
      ],
      'helplines': [
        {'name': 'Naapi', 'number': '01-4521720', 'color': AppColors.success},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.danger},
        {'name': 'Legal Aid', 'number': '01-4221740', 'color': AppColors.accentCyan},
        {'name': 'CIAA', 'number': '1113', 'color': AppColors.gold},
      ],
    },
    'सरकारी जागिर': {
      'color': AppColors.saffron,
      'icon': Icons.work_rounded,
      'mainLaw': 'Criminal Code, २०७४ + CIAA Act, २०४८',
      'punishment': '३ वर्षसम्म कैद र जरिवाना',
      'sections': [
        {'title': 'Criminal Code दफा ३४२ — Fraud', 'detail': 'Fake government job offer दिएर पैसा लिनु — ३ वर्षसम्म कैद।'},
        {'title': 'CIAA Act — Bribery', 'detail': 'Job दिलाउँछु भनेर पैसा लिनु = bribery। CIAA: 1113 मा report गर्नुस्।'},
        {'title': 'PSC Act — Impersonation', 'detail': 'PSC exam मा अर्काको ठाउँमा बस्नु — criminal offense। PSC ले FIR गर्छ।'},
        {'title': 'दफा ३४४ — Fake documents', 'detail': 'Fake educational certificates, fake experience letters — forgery charge।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Evidence save गर्नुस्', 'color': AppColors.warning, 'icon': Icons.save_rounded,
          'desc': 'Agent/broker सँगको chat, payment receipt, fake offer letter — सबै save गर्नुस्।',
          'docs': ['Payment receipts', 'Chat screenshots', 'Fake offer letter', 'Agent ID']},
        {'step': 2, 'title': 'PSC मा report', 'color': AppColors.saffron, 'icon': Icons.business_rounded,
          'desc': 'Public Service Commission मा complaint दर्ता गर्नुस्।',
          'office': 'PSC, Anamnagar, Kathmandu', 'phone': '01-4770680', 'website': 'https://psc.gov.np',
          'docs': ['Complaint letter', 'All evidence']},
        {'step': 3, 'title': 'CIAA मा complaint', 'color': AppColors.danger, 'icon': Icons.report_rounded,
          'desc': 'Bribery भएको छ भने CIAA: 1113 मा तुरुन्त report गर्नुस्। Anonymous complaint पनि हुन्छ।',
          'office': 'CIAA, Kathmandu', 'phone': '1113', 'website': 'https://ciaa.gov.np',
          'docs': ['Evidence of bribery', 'Amount paid proof']},
        {'step': 4, 'title': 'Police FIR + Court', 'color': AppColors.primaryRed, 'icon': Icons.local_police_rounded,
          'desc': 'नजिकको प्रहरीमा FIR दर्ता गरेर legal action लिनुस्।',
          'phone': '100', 'docs': ['All evidence', 'FIR form', 'Lawyer']},
      ],
      'helplines': [
        {'name': 'CIAA', 'number': '1113', 'color': AppColors.danger},
        {'name': 'PSC', 'number': '01-4770680', 'color': AppColors.saffron},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.primaryRed},
        {'name': 'Legal Aid', 'number': '01-4221740', 'color': AppColors.success},
      ],
    },
    'Investment': {
      'color': AppColors.warning,
      'icon': Icons.trending_up_rounded,
      'mainLaw': 'Securities Act, २०६३ + Criminal Code, २०७४',
      'punishment': '१० वर्षसम्म कैद र सम्पत्ति जफत',
      'sections': [
        {'title': 'Securities Act दफा ९१ — Ponzi scheme', 'detail': 'Fake investment scheme चलाउनु — १० वर्षसम्म कैद र सम्पत्ति जफत।'},
        {'title': 'Criminal Code दफा ३४२ — Investment fraud', 'detail': 'Guaranteed return को नाममा ठग्नु — criminal offense। SEBON मा report।'},
        {'title': 'NRB Act — Unlicensed financial services', 'detail': 'NRB license नभई financial services दिनु illegal। NRB: 1414 मा report।'},
        {'title': 'MLM Prohibition', 'detail': 'Pyramid scheme चलाउनु Nepal मा illegal। Police मा FIR गर्नुस्।'},
      ],
      'steps': [
        {'step': 1, 'title': 'Evidence collect गर्नुस्', 'color': AppColors.warning, 'icon': Icons.save_rounded,
          'desc': 'Investment contract, receipts, promises (screenshots), agent details — सबै save गर्नुस्।',
          'docs': ['Investment contract', 'Payment receipts', 'Promised return documents', 'Agent details']},
        {'step': 2, 'title': 'NRB मा complaint', 'color': AppColors.accentCyan, 'icon': Icons.account_balance_rounded,
          'desc': 'Nepal Rastra Bank मा financial fraud complaint दर्ता गर्नुस्।',
          'office': 'NRB, Baluwatar, Kathmandu', 'phone': '1414', 'website': 'https://nrb.org.np',
          'docs': ['Written complaint', 'All financial evidence']},
        {'step': 3, 'title': 'SEBON मा report', 'color': AppColors.gold, 'icon': Icons.bar_chart_rounded,
          'desc': 'Stock/securities related fraud भएमा SEBON मा report गर्नुस्।',
          'office': 'SEBON, Kathmandu', 'phone': '01-4412013', 'website': 'https://sebon.gov.np',
          'docs': ['Investment documents', 'Securities proof']},
        {'step': 4, 'title': 'Police FIR + Court', 'color': AppColors.danger, 'icon': Icons.local_police_rounded,
          'desc': 'CIB (Criminal Investigation Bureau) मा complaint गर्नुस्। Class action lawsuit सम्भव।',
          'phone': '100 / CIB: 01-4412548', 'docs': ['All evidence', 'FIR form', 'Lawyer']},
      ],
      'helplines': [
        {'name': 'NRB', 'number': '1414', 'color': AppColors.accentCyan},
        {'name': 'SEBON', 'number': '01-4412013', 'color': AppColors.gold},
        {'name': 'Nepal Police', 'number': '100', 'color': AppColors.danger},
        {'name': 'CIAA', 'number': '1113', 'color': AppColors.warning},
      ],
    },
  };

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _callNumber(String number) async {
    final clean = number.split('/').first.trim().replaceAll('-', '').replaceAll(' ', '');
    final uri = Uri.parse('tel:$clean');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final data = _legalData[_selectedFraud]!;
    final color = data['color'] as Color;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'कानुनी सहयोग', showBack: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type selector
            Container(
              color: AppColors.surfaceDark,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: _fraudTypes.map((t) {
                    final isSelected = _selectedFraud == t['label'];
                    final c = t['color'] as Color;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedFraud = t['label'] as String;
                        _expandedIndex = null;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? c.withOpacity(0.15) : AppColors.background,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: isSelected ? c : AppColors.borderDark, width: isSelected ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Icon(t['icon'] as IconData, color: isSelected ? c : AppColors.textHint, size: 16),
                            const SizedBox(width: 6),
                            Text(t['label'] as String,
                                style: AppTypography.labelSmall.copyWith(
                                    color: isSelected ? c : AppColors.textSecondary,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Law card
                  Container(
                    width: double.infinity,
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
                          children: [
                            Icon(data['icon'] as IconData, color: color, size: 28),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('लागू हुने कानुन:', style: AppTypography.labelLarge.copyWith(color: AppColors.textHint)),
                                  Text(data['mainLaw'] as String, style: AppTypography.titleMedium.copyWith(color: color)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.gavel_rounded, color: AppColors.danger, size: 18),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text('सजाय: ${data['punishment']}',
                                    style: AppTypography.bodyMedium.copyWith(color: AppColors.danger)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Law sections accordion
                  Text('कानुनी धाराहरू:', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ...(data['sections'] as List<Map<String, dynamic>>).asMap().entries.map((e) {
                    final isExpanded = _expandedIndex == e.key;
                    return GestureDetector(
                      onTap: () => setState(() => _expandedIndex = isExpanded ? null : e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isExpanded ? color.withOpacity(0.08) : AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: isExpanded ? color.withOpacity(0.5) : AppColors.borderDark),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Row(
                                children: [
                                  Icon(Icons.gavel_rounded, color: isExpanded ? color : AppColors.textHint, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(e.value['title'] as String,
                                        style: AppTypography.titleMedium.copyWith(
                                            color: isExpanded ? color : AppColors.textPrimary)),
                                  ),
                                  AnimatedRotation(
                                    turns: isExpanded ? 0.5 : 0,
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(Icons.keyboard_arrow_down_rounded,
                                        color: isExpanded ? color : AppColors.textHint),
                                  ),
                                ],
                              ),
                            ),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(AppRadius.sm),
                                    border: Border.all(color: color.withOpacity(0.2)),
                                  ),
                                  child: Text(e.value['detail'] as String,
                                      style: AppTypography.bodyMedium.copyWith(height: 1.6)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: AppSpacing.md),

                  // Steps
                  Text('के गर्ने? — Step by Step:', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ...(data['steps'] as List<Map<String, dynamic>>).map((step) => _buildStepCard(step, color)),

                  const SizedBox(height: AppSpacing.md),

                  // Helplines
                  Text('तुरुन्त सम्पर्क:', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.5,
                    children: (data['helplines'] as List<Map<String, dynamic>>).map((h) {
                      final hColor = h['color'] as Color;
                      return GestureDetector(
                        onTap: () => _callNumber(h['number'] as String),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 8),
                          decoration: BoxDecoration(
                            color: hColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border: Border.all(color: hColor.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.call_rounded, color: hColor, size: 18),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(h['name'] as String,
                                        style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
                                        overflow: TextOverflow.ellipsis),
                                    Text(h['number'] as String,
                                        style: AppTypography.labelLarge.copyWith(color: hColor),
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppSpacing.md),
                  const TsFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(Map<String, dynamic> step, Color mainColor) {
    final color = step['color'] as Color;
    final docs = step['docs'] as List<String>?;
    final phone = step['phone'] as String?;
    final office = step['office'] as String?;
    final website = step['website'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.5)),
                ),
                child: Center(
                  child: Text('${step['step']}',
                      style: AppTypography.titleMedium.copyWith(color: color)),
                ),
              ),
              Container(width: 2, height: 16, color: color.withOpacity(0.3)),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(step['icon'] as IconData, color: color, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(step['title'] as String,
                            style: AppTypography.titleMedium.copyWith(color: color)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(step['desc'] as String, style: AppTypography.bodyMedium),
                  if (office != null) ...[
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Expanded(child: Text(office, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary))),
                    ]),
                  ],
                  if (phone != null) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _callNumber(phone),
                      child: Row(children: [
                        const Icon(Icons.call_rounded, size: 14, color: AppColors.accentCyan),
                        const SizedBox(width: 4),
                        Text(phone, style: AppTypography.labelSmall.copyWith(color: AppColors.accentCyan)),
                      ]),
                    ),
                  ],
                  if (website != null) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _launchUrl(website),
                      child: Row(children: [
                        const Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text(website.replaceAll('https://', ''),
                            style: AppTypography.labelSmall.copyWith(color: AppColors.gold)),
                      ]),
                    ),
                  ],
                  if (docs != null && docs.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: color.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('📋 आवश्यक documents:',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                          const SizedBox(height: 4),
                          ...docs.map((d) => Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Row(children: [
                              Icon(Icons.check_circle_rounded, size: 12, color: color),
                              const SizedBox(width: 4),
                              Expanded(child: Text(d, style: AppTypography.labelSmall)),
                            ]),
                          )),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
