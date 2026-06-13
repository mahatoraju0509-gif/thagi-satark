import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/report_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _scammerController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _witnessController = TextEditingController();
  bool _isAnonymous = true;
  int _currentStep = 0;

  final List<Map<String, dynamic>> _fraudTypes = [
    {'label': 'Foreign Employment', 'icon': Icons.flight_rounded, 'color': AppColors.primaryRed},
    {'label': 'Online Shopping', 'icon': Icons.shopping_bag_rounded, 'color': AppColors.warning},
    {'label': 'Cooperative', 'icon': Icons.account_balance_rounded, 'color': AppColors.accentCyan},
    {'label': 'Digital Wallet', 'icon': Icons.account_balance_wallet_rounded, 'color': AppColors.gold},
    {'label': 'Social Media', 'icon': Icons.phone_android_rounded, 'color': AppColors.saffron},
    {'label': 'जग्गा ठगी', 'icon': Icons.home_rounded, 'color': AppColors.success},
    {'label': 'सरकारी जागिर', 'icon': Icons.work_rounded, 'color': AppColors.danger},
    {'label': 'Investment', 'icon': Icons.trending_up_rounded, 'color': AppColors.warning},
    {'label': 'Health Fraud', 'icon': Icons.health_and_safety_rounded, 'color': AppColors.success},
    {'label': 'Education', 'icon': Icons.school_rounded, 'color': AppColors.accentCyan},
    {'label': 'Loan App', 'icon': Icons.phone_android_rounded, 'color': AppColors.danger},
    {'label': 'अन्य', 'icon': Icons.more_horiz_rounded, 'color': AppColors.textSecondary},
  ];

  final List<Map<String, dynamic>> _officialChannels = [
    {'name': 'Nepal Police', 'number': '100', 'desc': 'FIR दर्ता गर्न', 'color': AppColors.danger,
      'icon': Icons.local_police_rounded, 'url': 'https://nepalpolice.gov.np'},
    {'name': 'Cyber Bureau', 'number': '1177', 'desc': 'Online fraud report', 'color': AppColors.accentCyan,
      'icon': Icons.computer_rounded, 'url': 'https://nepalpolice.gov.np'},
    {'name': 'DoFE', 'number': '1180', 'desc': 'Foreign employment fraud', 'color': AppColors.primaryRed,
      'icon': Icons.flight_rounded, 'url': 'https://dofeprovident.gov.np'},
    {'name': 'NRB', 'number': '1414', 'desc': 'Financial fraud', 'color': AppColors.gold,
      'icon': Icons.account_balance_rounded, 'url': 'https://nrb.org.np'},
    {'name': 'CIAA', 'number': '1113', 'desc': 'Corruption report', 'color': AppColors.warning,
      'icon': Icons.report_rounded, 'url': 'https://ciaa.gov.np'},
    {'name': 'महिला आयोग', 'number': '1145', 'desc': 'Women related fraud', 'color': AppColors.saffron,
      'icon': Icons.woman_rounded, 'url': ''},
  ];

  @override
  void dispose() {
    _descController.dispose();
    _locationController.dispose();
    _scammerController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _witnessController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _callNumber(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'ठगी Report गर्नुस्'),
      body: Consumer<ReportProvider>(
        builder: (context, provider, _) {
          if (provider.isSubmitted) return _buildSuccess();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWarningBanner(),
                  const SizedBox(height: AppSpacing.md),
                  _buildStepIndicator(),
                  const SizedBox(height: AppSpacing.md),
                  if (_currentStep == 0) _buildStep1(provider),
                  if (_currentStep == 1) _buildStep2(provider),
                  if (_currentStep == 2) _buildStep3(provider),
                  if (_currentStep == 3) _buildStep4(provider, context),
                  const SizedBox(height: AppSpacing.lg),
                  _buildNavigationButtons(provider, context),
                  const SizedBox(height: AppSpacing.md),
                  _buildOfficialChannels(),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_rounded, color: AppColors.warning, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'यो app internal record हो। Official complaint को लागि Police वा Cyber Bureau मा जानुस्।',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['ठगीको प्रकार', 'विवरण', 'Evidence', 'Submit'];
    return Row(
      children: steps.asMap().entries.map((e) {
        final isDone = e.key < _currentStep;
        final isCurrent = e.key == _currentStep;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.success : isCurrent ? AppColors.primaryRed : AppColors.surfaceDark,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDone ? AppColors.success : isCurrent ? AppColors.primaryRed : AppColors.borderDark,
                        ),
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                            : Text('${e.key + 1}',
                                style: AppTypography.labelSmall.copyWith(
                                    color: isCurrent ? Colors.white : AppColors.textHint)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(e.value,
                        style: AppTypography.labelSmall.copyWith(
                            color: isCurrent ? AppColors.primaryRed : AppColors.textHint,
                            fontSize: 9),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              if (e.key < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 20),
                    color: isDone ? AppColors.success : AppColors.borderDark,
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStep1(ReportProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ठगीको प्रकार छान्नुस्:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.8,
          children: _fraudTypes.map((t) {
            final isSelected = provider.selectedFraudType == t['label'];
            final color = t['color'] as Color;
            return InkWell(
              onTap: () => provider.setFraudType(t['label'] as String),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? color.withOpacity(0.15) : AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: isSelected ? color : AppColors.borderDark, width: isSelected ? 2 : 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(t['icon'] as IconData, color: isSelected ? color : AppColors.textHint, size: 20),
                    const SizedBox(height: 4),
                    Text(t['label'] as String,
                        style: AppTypography.labelSmall.copyWith(
                            color: isSelected ? color : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep2(ReportProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedType(provider),
        const SizedBox(height: AppSpacing.md),

        Text('ठगीको विवरण:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _descController,
          maxLines: 5,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('के भयो? कसरी भयो? सबै विस्तारमा लेख्नुस्...', Icons.description_rounded),
          validator: (v) => v!.isEmpty ? 'विवरण अनिवार्य छ' : null,
        ),
        const SizedBox(height: AppSpacing.md),

        Text('ठगी भएको मिति:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _dateController,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('जस्तै: 2081-02-15', Icons.calendar_today_rounded),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              _dateController.text = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            }
          },
          readOnly: true,
        ),
        const SizedBox(height: AppSpacing.md),

        Text('ठगी भएको स्थान:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _locationController,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('जिल्ला/गाउँपालिका/ठेगाना', Icons.location_on_rounded),
        ),
        const SizedBox(height: AppSpacing.md),

        Text('ठगिएको रकम (अनुमानित):', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('जस्तै: Rs. 50,000', Icons.currency_rupee_rounded),
        ),
      ],
    );
  }

  Widget _buildStep3(ReportProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedType(provider),
        const SizedBox(height: AppSpacing.md),

        Text('ठगको जानकारी (भएसम्म):', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _scammerController,
          maxLines: 3,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('नाम, phone number, Facebook ID, address...', Icons.person_off_rounded),
        ),
        const SizedBox(height: AppSpacing.md),

        Text('साक्षी (Witness) जानकारी:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _witnessController,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: _inputDecoration('साक्षीको नाम र सम्पर्क (optional)', Icons.people_rounded),
        ),
        const SizedBox(height: AppSpacing.md),

        // Evidence tips
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.accentCyan.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.tips_and_updates_rounded, color: AppColors.accentCyan, size: 20),
                  const SizedBox(width: 8),
                  Text('Evidence राख्नु अनिवार्य छ:', style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ...['📱 Chat screenshots save गर्नुस्',
                  '🧾 Payment receipt/transaction ID',
                  '📋 Contract/agreement copy',
                  '🪪 ठगको ID/photo (भएमा)',
                  '🏦 Bank statement',
                  '📞 Call records'].map((tip) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(tip, style: AppTypography.bodyMedium),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4(ReportProvider provider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report Summary:', style: AppTypography.titleLarge.copyWith(color: AppColors.accentCyan)),
              const SizedBox(height: AppSpacing.sm),
              const Divider(color: Colors.white10),
              const SizedBox(height: AppSpacing.sm),
              _summaryRow('ठगीको प्रकार:', provider.selectedFraudType),
              _summaryRow('विवरण:', _descController.text.isEmpty ? 'लेखिएको छैन' : '${_descController.text.substring(0, _descController.text.length > 50 ? 50 : _descController.text.length)}...'),
              _summaryRow('मिति:', _dateController.text.isEmpty ? 'उल्लेख छैन' : _dateController.text),
              _summaryRow('स्थान:', _locationController.text.isEmpty ? 'उल्लेख छैन' : _locationController.text),
              _summaryRow('रकम:', _amountController.text.isEmpty ? 'उल्लेख छैन' : 'Rs. ${_amountController.text}'),
              _summaryRow('ठगको जानकारी:', _scammerController.text.isEmpty ? 'उल्लेख छैन' : _scammerController.text),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Anonymous toggle
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Row(
            children: [
              const Icon(Icons.visibility_off_rounded, color: AppColors.textHint, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Anonymous Report', style: AppTypography.titleMedium),
                    Text('तपाईंको नाम गोप्य रहन्छ', style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                  ],
                ),
              ),
              Switch(
                value: _isAnonymous,
                onChanged: (v) => setState(() => _isAnonymous = v),
                activeColor: AppColors.accentCyan,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Submit button
        InkWell(
          onTap: provider.isSubmitting ? null : () async {
            if (provider.selectedFraudType.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('ठगीको प्रकार छान्नुस्!', style: AppTypography.bodyMedium),
                backgroundColor: AppColors.warning,
              ));
              return;
            }
            if (_descController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('विवरण लेख्नुस्!', style: AppTypography.bodyMedium),
                backgroundColor: AppColors.warning,
              ));
              return;
            }
            await provider.submitReport(
              description: _descController.text,
              isAnonymous: _isAnonymous,
              location: _locationController.text,
              scammerInfo: _scammerController.text,
              amount: _amountController.text,
              date: _dateController.text,
            );
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: provider.isSubmitting ? AppColors.surfaceLight : AppColors.primaryRed,
              borderRadius: BorderRadius.circular(AppRadius.button),
              boxShadow: provider.isSubmitting ? null : [
                BoxShadow(color: AppColors.primaryRed.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 4)),
              ],
            ),
            child: Center(
              child: provider.isSubmitting
                  ? const CircularProgressIndicator(color: AppColors.textPrimary, strokeWidth: 2)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Text('Report पठाउनुस्', style: AppTypography.buttonPrimary),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Text('⚠️ गलत report गर्नु कानुनी अपराध हो',
              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(ReportProvider provider, BuildContext context) {
    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _currentStep--),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Center(child: Text('← पछाडि', style: AppTypography.labelLarge)),
              ),
            ),
          ),
        if (_currentStep > 0) const SizedBox(width: AppSpacing.sm),
        if (_currentStep < 3)
          Expanded(
            child: InkWell(
              onTap: () {
                if (_currentStep == 0 && provider.selectedFraudType.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('ठगीको प्रकार छान्नुस्!', style: AppTypography.bodyMedium),
                    backgroundColor: AppColors.warning,
                  ));
                  return;
                }
                setState(() => _currentStep++);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Center(
                  child: Text('अर्को →',
                      style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOfficialChannels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white10),
        const SizedBox(height: AppSpacing.md),
        Text('Official Complaint Channels:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Text('App report को साथमा यी official channels मा पनि complaint दिनुस्:',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
        const SizedBox(height: AppSpacing.md),
        ..._officialChannels.map((ch) {
          final color = ch['color'] as Color;
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(ch['icon'] as IconData, color: color, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ch['name'] as String, style: AppTypography.titleMedium.copyWith(color: color)),
                      Text(ch['desc'] as String, style: AppTypography.bodyMedium),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _callNumber(ch['number'] as String),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(color: color.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_rounded, color: color, size: 14),
                            const SizedBox(width: 4),
                            Text(ch['number'] as String,
                                style: AppTypography.labelSmall.copyWith(color: color)),
                          ],
                        ),
                      ),
                    ),
                    if ((ch['url'] as String).isNotEmpty) ...[
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () => _launchUrl(ch['url'] as String),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            border: Border.all(color: color.withOpacity(0.4)),
                          ),
                          child: Icon(Icons.open_in_new_rounded, color: color, size: 14),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSelectedType(ReportProvider provider) {
    if (provider.selectedFraudType.isEmpty) return const SizedBox.shrink();
    final type = _fraudTypes.firstWhere((t) => t['label'] == provider.selectedFraudType,
        orElse: () => _fraudTypes.last);
    final color = type['color'] as Color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(type['icon'] as IconData, color: color, size: 16),
          const SizedBox(width: 6),
          Text(provider.selectedFraudType,
              style: AppTypography.labelLarge.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120,
              child: Text(label, style: AppTypography.labelLarge.copyWith(color: AppColors.textHint))),
          Expanded(child: Text(value, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
      prefixIcon: Icon(icon, color: AppColors.textHint, size: 20),
      filled: true,
      fillColor: AppColors.surfaceMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primaryRed, width: 1.5),
      ),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.success, width: 2),
              ),
              child: const Icon(Icons.check_rounded, color: AppColors.success, size: 52),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Report दर्ता भयो!', style: AppTypography.headlineLarge.copyWith(color: AppColors.success)),
            const SizedBox(height: AppSpacing.sm),
            Text('तपाईंको report सफलतापूर्वक दर्ता भयो।\nOfficial complaint को लागि Police वा Cyber Bureau मा पनि जानुस्।',
                style: AppTypography.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xl),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 52, width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
                child: Center(
                  child: Text('Home मा जानुस्',
                      style: AppTypography.buttonPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
