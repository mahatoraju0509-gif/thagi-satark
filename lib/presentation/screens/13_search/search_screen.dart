import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/fraud_provider.dart';
import '../../providers/search_provider.dart';
import '../../widgets/common/ts_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<Map<String, dynamic>> _quickSearches = [
    {'label': 'Manpower ठगी', 'icon': Icons.flight_rounded, 'color': AppColors.primaryRed},
    {'label': 'Online Fraud', 'icon': Icons.computer_rounded, 'color': AppColors.accentCyan},
    {'label': 'Cooperative', 'icon': Icons.account_balance_rounded, 'color': AppColors.gold},
    {'label': 'Investment', 'icon': Icons.trending_up_rounded, 'color': AppColors.warning},
    {'label': 'जग्गा ठगी', 'icon': Icons.home_rounded, 'color': AppColors.success},
    {'label': 'Loan App', 'icon': Icons.phone_android_rounded, 'color': AppColors.danger},
    {'label': 'OTP Fraud', 'icon': Icons.lock_rounded, 'color': AppColors.accentCyan},
    {'label': 'Sextortion', 'icon': Icons.warning_rounded, 'color': AppColors.danger},
    {'label': 'Fake Job', 'icon': Icons.work_rounded, 'color': AppColors.saffron},
    {'label': 'QR Fraud', 'icon': Icons.qr_code_rounded, 'color': AppColors.gold},
  ];

  final List<Map<String, dynamic>> _helplineSearch = [
    {'name': 'Nepal Police', 'number': '100', 'color': AppColors.danger},
    {'name': 'Cyber Bureau', 'number': '1177', 'color': AppColors.accentCyan},
    {'name': 'DoFE', 'number': '1180', 'color': AppColors.primaryRed},
    {'name': 'NRB', 'number': '1414', 'color': AppColors.gold},
    {'name': 'CIAA', 'number': '1113', 'color': AppColors.warning},
    {'name': 'महिला आयोग', 'number': '1145', 'color': AppColors.saffron},
    {'name': 'Mental Health', 'number': '1166', 'color': AppColors.success},
    {'name': 'Child Helpline', 'number': '1098', 'color': AppColors.accentCyan},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      context.read<FraudProvider>().loadFrauds();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _doSearch(String query) async {
  final fraudProvider = context.read<FraudProvider>();
  if (fraudProvider.frauds.isEmpty) {
    await fraudProvider.loadFrauds();
  }
  final frauds = fraudProvider.frauds;
  context.read<SearchProvider>().search(query, frauds);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(title: 'खोज्नुस्', showBack: true),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'ठगी खोज्नुस्... (नेपाली वा English)',
                      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded, color: AppColors.textHint),
                              onPressed: () {
                                _controller.clear();
                                context.read<SearchProvider>().clearSearch();
                              },
                            )
                          : null,
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
                    ),
                    onChanged: (v) {
                    
                      _doSearch(v);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Consumer2<SearchProvider, FraudProvider>(
              builder: (context, search, fraud, _) {
                if (search.isSearching && _controller.text.isNotEmpty) {
                  return _buildResults(search, fraud);
                }
                return _buildHome(search);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHome(SearchProvider search) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (search.recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('हालैका खोजहरू:', style: AppTypography.titleMedium),
                TextButton(
                  onPressed: () => search.clearRecentSearches(),
                  child: Text('सफा गर्नुस्',
                      style: AppTypography.labelSmall.copyWith(color: AppColors.danger)),
                ),
              ],
            ),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: search.recentSearches.map((s) => GestureDetector(
                onTap: () => _doSearch(s),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.history_rounded, size: 14, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Text(s, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Quick searches
          Text('छिटो खोज्नुस्:', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _quickSearches.map((q) {
              final color = q['color'] as Color;
              return GestureDetector(
                onTap: () => _doSearch(q['label'] as String),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(q['icon'] as IconData, color: color, size: 16),
                      const SizedBox(width: 6),
                      Text(q['label'] as String,
                          style: AppTypography.labelSmall.copyWith(color: color)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Helplines quick access
          Text('Helplines:', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
            children: _helplineSearch.map((h) {
              final color = h['color'] as Color;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.call_rounded, color: color, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(h['name'] as String,
                              style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
                              overflow: TextOverflow.ellipsis),
                          Text(h['number'] as String,
                              style: AppTypography.labelLarge.copyWith(color: color),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Tips
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accentCyan.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.tips_and_updates_rounded, color: AppColors.accentCyan, size: 18),
                  const SizedBox(width: 6),
                  Text('खोज tips:', style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                ]),
                const SizedBox(height: AppSpacing.sm),
                ...[
                  'नेपाली वा English दुवैमा खोज्न सकिन्छ',
                  'Fraud type, helpline, law सबै खोज्न मिल्छ',
                  'जस्तै: "dofe", "1177", "cooperative" type गर्नुस्',
                ].map((t) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(children: [
                    const Icon(Icons.circle, size: 6, color: AppColors.accentCyan),
                    const SizedBox(width: 6),
                    Expanded(child: Text(t, style: AppTypography.bodyMedium)),
                  ]),
                )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildResults(SearchProvider search, FraudProvider fraud) {
    final results = search.results;

    // Also search helplines
    final helplineResults = _helplineSearch.where((h) =>
        (h['name'] as String).toLowerCase().contains(_controller.text.toLowerCase()) ||
        (h['number'] as String).contains(_controller.text)).toList();

    if (results.isEmpty && helplineResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded, color: AppColors.textHint, size: 64),
            const SizedBox(height: AppSpacing.md),
            Text('"${_controller.text}" भेटिएन',
                style: AppTypography.titleLarge.copyWith(color: AppColors.textHint)),
            const SizedBox(height: AppSpacing.sm),
            Text('अर्को keyword try गर्नुस्', style: AppTypography.bodyMedium),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      children: [
        if (results.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text('${results.length} fraud types भेटियो:',
                style: AppTypography.titleMedium.copyWith(color: AppColors.textHint)),
          ),
          ...results.map((f) {
            final color = _getSeverityColor(f.severity);
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/fraud-detail', arguments: f),
              child: Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(_getCategoryIcon(f.category), color: color, size: 22),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.titleNp, style: AppTypography.titleMedium),
                          Text(f.titleEn, style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
                          const SizedBox(height: 4),
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(_getSeverityLabel(f.severity),
                                  style: AppTypography.labelSmall.copyWith(color: color, fontSize: 9)),
                            ),
                            const SizedBox(width: 6),
                            Text('${f.reportCount} cases',
                                style: AppTypography.labelSmall.copyWith(color: AppColors.textHint)),
                          ]),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textHint, size: 16),
                  ],
                ),
              ),
            );
          }),
        ],

        if (helplineResults.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
            child: Text('Helplines:', style: AppTypography.titleMedium.copyWith(color: AppColors.textHint)),
          ),
          ...helplineResults.map((h) {
            final color = h['color'] as Color;
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
                  Icon(Icons.call_rounded, color: color, size: 22),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(h['name'] as String, style: AppTypography.titleMedium.copyWith(color: color)),
                        Text(h['number'] as String, style: AppTypography.labelLarge.copyWith(color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text('Call', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            );
          }),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'employment': return Icons.flight_rounded;
      case 'digital': return Icons.computer_rounded;
      case 'financial': return Icons.account_balance_rounded;
      case 'property': return Icons.home_rounded;
      case 'social': return Icons.people_rounded;
      case 'health': return Icons.health_and_safety_rounded;
      case 'education': return Icons.school_rounded;
      case 'crime': return Icons.gavel_rounded;
      default: return Icons.warning_rounded;
    }
  }
}
