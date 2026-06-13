import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/agency_verify_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedType = 'Manpower';

  final List<Map<String, dynamic>> _types = [
    {'label': 'Manpower', 'icon': Icons.flight_rounded, 'color': AppColors.primaryRed, 'reg': 'DoFE', 'url': 'https://dofeprovident.gov.np', 'hotline': '1180'},
    {'label': 'Cooperative', 'icon': Icons.account_balance_rounded, 'color': AppColors.accentCyan, 'reg': 'DoC', 'url': 'https://doc.gov.np', 'hotline': '01-4229032'},
    {'label': 'Consultancy', 'icon': Icons.school_rounded, 'color': AppColors.gold, 'reg': 'MoE', 'url': 'https://moe.gov.np', 'hotline': '01-4200385'},
    {'label': 'Land Broker', 'icon': Icons.home_rounded, 'color': AppColors.success, 'reg': 'MoLRM', 'url': 'https://molrm.gov.np', 'hotline': '01-4200321'},
    {'label': 'Insurance', 'icon': Icons.security_rounded, 'color': AppColors.saffron, 'reg': 'Beema Samiti', 'url': 'https://ib.gov.np', 'hotline': '01-4229873'},
    {'label': 'Bank/Finance', 'icon': Icons.currency_exchange_rounded, 'color': AppColors.warning, 'reg': 'NRB', 'url': 'https://nrb.org.np', 'hotline': '1414'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AgencyVerifyProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectType(String type) {
    setState(() => _selectedType = type);
  }

  void _doVerify() {
    if (_controller.text.trim().isEmpty) return;
    context.read<AgencyVerifyProvider>().verifyWithType(_controller.text.trim(), _selectedType);
  }

  void _doReset() {
    setState(() => _controller.clear());
    context.read<AgencyVerifyProvider>().reset();
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Map<String, dynamic> get _currentType =>
      _types.firstWhere((t) => t['label'] == _selectedType, orElse: () => _types[0]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'Agency Verify', showBack: false),
      body: Consumer<AgencyVerifyProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: AppSpacing.md),
                _buildTypeSelector(),
                const SizedBox(height: AppSpacing.md),
                _buildQuickLinks(),
                const SizedBox(height: AppSpacing.md),
                _buildSearchBox(provider),
                const SizedBox(height: AppSpacing.md),
                if (provider.state == VerifyState.loading)
                  const Center(child: CircularProgressIndicator(color: AppColors.accentCyan)),
                if (provider.state == VerifyState.result && provider.result != null)
                  _buildResult(provider),
                if (provider.state == VerifyState.notFound)
                  _buildNotFound(provider.searchQuery),
                if (provider.state == VerifyState.idle)
                  _buildBlacklistWarning(provider),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 3),
    );
  }

  Widget _buildHeader() {
    final color = _currentType['color'] as Color;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.withOpacity(0.15), AppColors.background]),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_rounded, color: color, size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Agency Verify गर्नुस्', style: AppTypography.titleLarge),
                Text('Register छ कि छैन — तुरुन्त थाहा पाउनुस्',
                    style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Agency को प्रकार छान्नुस्:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.2,
          children: _types.map((t) {
            final isSelected = _selectedType == t['label'];
            final color = t['color'] as Color;
            return InkWell(
              onTap: () => _selectType(t['label'] as String),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? color.withOpacity(0.15) : AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: isSelected ? color : AppColors.borderDark, width: isSelected ? 2 : 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(t['icon'] as IconData, color: isSelected ? color : AppColors.textHint, size: 18),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        t['label'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected ? color : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    final t = _currentType;
    final color = t['color'] as Color;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_rounded, color: color, size: 18),
              const SizedBox(width: 6),
              Text('${t['label']} — Official Verification',
                  style: AppTypography.titleMedium.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Registered with: ${t['reg']}', style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              // Official Website Button
              Expanded(
                child: InkWell(
                  onTap: () => _launchUrl(t['url'] as String),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.open_in_new_rounded, color: color, size: 16),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text('Official Website',
                              style: AppTypography.labelSmall.copyWith(color: color),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Hotline Button
              Expanded(
                child: InkWell(
                  onTap: () => _launchUrl('tel:${t['hotline']}'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: AppColors.success.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.call_rounded, color: AppColors.success, size: 16),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text('Hotline: ${t['hotline']}',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.success),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox(AgencyVerifyProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Agency को नाम वा License No. लेख्नुस्:', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'जस्तै: Nepal Manpower, DoFE-1234/078...',
                  hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.surfaceMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _doVerify(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            InkWell(
              onTap: _doVerify,
              child: Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: (_currentType['color'] as Color),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: provider.state == VerifyState.loading
                    ? const Padding(padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.search_rounded, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResult(AgencyVerifyProvider provider) {
    final r = provider.result!;
    final color = r.isBlacklisted ? AppColors.danger : r.isRegistered ? AppColors.success : AppColors.warning;
    final icon = r.isBlacklisted ? Icons.dangerous_rounded : r.isRegistered ? Icons.verified_rounded : Icons.warning_amber_rounded;
    final message = r.isBlacklisted ? '🚫 BLACKLIST — कारोबार नगर्नुस्!' : r.isRegistered ? '✅ Registered — विश्वसनीय' : '⚠️ Registered छैन!';

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 60),
              const SizedBox(height: AppSpacing.sm),
              Text(message, style: AppTypography.headlineMedium.copyWith(color: color), textAlign: TextAlign.center),

              if (r.isBlacklisted && r.blacklistReason != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.report_rounded, color: AppColors.danger, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text('कारण: ${r.blacklistReason!}',
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.danger))),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.md),
              const Divider(color: Colors.white10),
              const SizedBox(height: AppSpacing.sm),

              _row('नाम:', r.nameNp, color),
              _row('Name:', r.nameEn, color),
              _row('प्रकार:', r.type, color),
              _row('License No:', r.licenseNumber, color),
              _row('Registered with:', r.registeredWith, color),
              _row('ठेगाना:', r.address, color),
              _row('Phone:', r.phone, color),
              if (r.established.isNotEmpty) _row('Established:', r.established, color),

              // Type-specific details
              if (r.destinations.isNotEmpty) _row('Destinations:', r.destinations.join(', '), color),
              if (r.workersSent.isNotEmpty) _row('Workers Sent:', r.workersSent, color),
              if (r.totalMembers.isNotEmpty) _row('Total Members:', r.totalMembers, color),
              if (r.totalSavings.isNotEmpty) _row('Total Savings:', r.totalSavings, color),
              if (r.countries.isNotEmpty) _row('Countries:', r.countries.join(', '), color),
              if (r.successRate.isNotEmpty) _row('Success Rate:', r.successRate, color),
              if (r.totalPolicies.isNotEmpty) _row('Total Policies:', r.totalPolicies, color),
              if (r.claimRatio.isNotEmpty) _row('Claim Ratio:', r.claimRatio, color),
              if (r.branches.isNotEmpty) _row('Branches:', r.branches, color),
              if (r.atms.isNotEmpty) _row('ATMs:', r.atms, color),
              if (r.transactions.isNotEmpty) _row('Transactions:', r.transactions, color),
              if (r.areasCovered.isNotEmpty) _row('Areas Covered:', r.areasCovered.join(', '), color),

              // Website link
              if (r.website.isNotEmpty && !r.isBlacklisted) ...[
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: () => _launchUrl(r.website),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.open_in_new_rounded, color: color, size: 18),
                        const SizedBox(width: 6),
                        Text('Official Website: ${r.website}',
                            style: AppTypography.labelLarge.copyWith(color: color)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _doReset,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Center(child: Text('फेरि खोज्नुस्', style: AppTypography.labelLarge)),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/report'),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryRed,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Center(
                    child: Text('Report गर्नुस्',
                        style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotFound(String query) {
    final t = _currentType;
    final color = t['color'] as Color;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.warning.withOpacity(0.4), width: 2),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, color: AppColors.warning, size: 52),
          const SizedBox(height: AppSpacing.md),
          Text('"$query" भेटिएन',
              style: AppTypography.titleLarge.copyWith(color: AppColors.warning),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text('हाम्रो database मा छैन।\nOfficial site मा directly verify गर्नुस्:',
              style: AppTypography.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),

          // Official verify link
          InkWell(
            onTap: () => _launchUrl(t['url'] as String),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: color.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_in_new_rounded, color: color, size: 18),
                  const SizedBox(width: 6),
                  Text('${t['reg']} — ${t['url']}',
                      style: AppTypography.labelLarge.copyWith(color: color)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Hotline
          InkWell(
            onTap: () => _launchUrl('tel:${t['hotline']}'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.call_rounded, color: AppColors.success, size: 18),
                  const SizedBox(width: 6),
                  Text('Hotline: ${t['hotline']}',
                      style: AppTypography.labelLarge.copyWith(color: AppColors.success)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.danger.withOpacity(0.3)),
            ),
            child: Text('⚠️ Database मा नभएको agency लाई advance पैसा नदिनुस्!',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.danger),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: AppSpacing.md),

          InkWell(
            onTap: _doReset,
            child: Container(
              height: 44, width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Center(child: Text('फेरि खोज्नुस्', style: AppTypography.labelLarge)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlacklistWarning(AgencyVerifyProvider provider) {
    final blacklisted = provider.blacklistedAgencies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning box
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.danger.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.danger.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 24),
                  const SizedBox(width: 8),
                  Text('Blacklisted Agencies — सावधान!',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('यी agencies ले ठगी गरेको प्रमाण छ। कुनै पनि कारोबार नगर्नुस्!',
                  style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              ...blacklisted.where((a) => a.type == _selectedType).map((a) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.danger.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.block_rounded, color: AppColors.danger, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.nameNp, style: AppTypography.labelLarge.copyWith(color: AppColors.danger)),
                          if (a.blacklistReason != null)
                            Text(a.blacklistReason!,
                                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // How to verify tips
        Text('कसरी verify गर्ने?', style: AppTypography.headlineMedium),
        const SizedBox(height: AppSpacing.sm),
        ..._types.map((t) => Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: (t['color'] as Color).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(t['icon'] as IconData, color: t['color'] as Color, size: 22),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['label'] as String,
                        style: AppTypography.titleMedium.copyWith(color: t['color'] as Color)),
                    Text('${t['reg']} | Hotline: ${t['hotline']}',
                        style: AppTypography.bodyMedium),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _launchUrl(t['url'] as String),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (t['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: (t['color'] as Color).withOpacity(0.4)),
                  ),
                  child: Text('Website',
                      style: AppTypography.labelSmall.copyWith(color: t['color'] as Color)),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _row(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130,
              child: Text(label, style: AppTypography.labelLarge.copyWith(color: AppColors.textHint))),
          Expanded(child: Text(value, style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}
