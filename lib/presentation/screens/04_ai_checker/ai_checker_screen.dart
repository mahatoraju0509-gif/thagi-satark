import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../providers/ai_checker_provider.dart';
import '../../widgets/common/ts_app_bar.dart';
import '../../widgets/common/ts_bottom_nav.dart';

class AiCheckerScreen extends StatefulWidget {
  const AiCheckerScreen({super.key});

  @override
  State<AiCheckerScreen> createState() => _AiCheckerScreenState();
}

class _AiCheckerScreenState extends State<AiCheckerScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _callNumber(String number) async {
    final clean = number.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$clean');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TsAppBar(
        title: 'AI \u0920\u0917\u0940 Checker',
        showBack: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AiCheckerProvider>().reset();
              _controller.clear();
            },
            icon: const Icon(Icons.refresh_rounded, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Consumer<AiCheckerProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      // Offline AI Notice
                      _buildOfflineNotice(),
                      const SizedBox(height: AppSpacing.md),

                      // State content
                      if (provider.state == AiCheckerState.idle)
                        _buildIdleView()
                      else if (provider.state == AiCheckerState.loading)
                        _buildLoadingView()
                      else if (provider.state == AiCheckerState.error)
                        _buildErrorView(provider)
                      else
                        _buildResultView(provider),
                    ],
                  ),
                ),
              ),
              _buildInputArea(provider),
            ],
          );
        },
      ),
      bottomNavigationBar: const TsBottomNav(currentIndex: 1),
    );
  }

  Widget _buildOfflineNotice() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accentCyan.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.accentCyan, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('100% Offline AI',
                    style: AppTypography.titleMedium.copyWith(color: AppColors.accentCyan)),
                Text(
                  '\u0027ChatGPT/Gemini \u091c\u0938\u094d\u0924\u094b advanced \u0939\u094b\u0907\u0928 \u2014 \u0924\u0930 Nepal \u0915\u094b fraud patterns \u092e\u093e specifically trained \u091b\u094d\u0964 100% Free, Fast, Offline!',
                  style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdleView() {
    final examples = [
      '\u092e\u0932\u093e\u0908 Qatar \u092e\u093e job \u0926\u093f\u0932\u093e\u0909\u0928\u094d\u091b\u0941 \u092d\u0928\u094d\u0926\u0948 agency \u0932\u0947 Rs.1.5 lakh advance \u092e\u093e\u0917\u094d\u092f\u094b',
      'Facebook \u092e\u093e iPhone 15 Rs.30,000 \u092e\u093e \u092c\u0947\u091a\u094d\u091b\u0941 \u092d\u0928\u094d\u092f\u094b, advance \u092e\u093e\u0917\u094d\u092f\u094b',
      'Telegram group \u092e\u093e daily 5% profit \u0926\u093f\u0928\u094d\u091b\u0941 \u092d\u0928\u094d\u0926\u0948 invest \u0917\u0930\u094d\u0928 \u092d\u0928\u094d\u092f\u094b',
      'Bank \u092c\u093e\u091f call \u0906\u092f\u094b, OTP \u0926\u093f\u0928\u0941\u0938\u094d \u092d\u0928\u094d\u092f\u094b',
      '\u0938\u0939\u0915\u093e\u0930\u0940\u092e\u093e Rs.50,000 \u0930\u093e\u0916\u0947\u0902, 20% \u092e\u093e\u0938\u093f\u0915 \u092c\u094d\u092f\u093e\u091c \u092d\u0928\u094d\u091b\u0928\u094d',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryRed.withOpacity(0.2), AppColors.background],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Image.asset('assets/images/logo.png',
                      width: 70, height: 70, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('\u092f\u094b \u0920\u0917\u0940 \u0939\u094b?',
                  style: AppTypography.headlineLarge.copyWith(color: AppColors.primaryRed)),
              Text('\u0906\u092b\u094d\u0928\u094b situation \u0928\u0947\u092a\u093e\u0932\u0940\u092e\u093e \u0932\u0947\u0916\u094d\u0928\u0941\u0938\u094d \u2014 AI \u0932\u0947 \u0924\u0941\u0930\u0928\u094d\u0924 \u092c\u0924\u093e\u0909\u0902\u091b',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
                  textAlign: TextAlign.center),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),
        Text('\u0909\u0926\u093e\u0939\u0930\u0923 \u0917\u0930\u094d\u0928\u0941\u0938\u094d:',
            style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.sm),

        ...examples.map((e) => GestureDetector(
          onTap: () {
            _controller.text = e;
            context.read<AiCheckerProvider>().checkFraud(e);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.borderDark),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_rounded, color: AppColors.gold, size: 16),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(e,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 12, color: AppColors.textHint),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildLoadingView() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryRed.withOpacity(0.5), width: 2),
                ),
                child: Image.asset('assets/images/logo.png',
                    width: 60, height: 60, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('\u0935\u093f\u0936\u094d\u0932\u0947\u0937\u0923 \u0917\u0930\u094d\u0926\u0948\u091b...',
              style: AppTypography.titleLarge.copyWith(color: AppColors.primaryRed)),
          const SizedBox(height: AppSpacing.sm),
          Text('Nepal fraud patterns \u0938\u0902\u0917 match \u0917\u0930\u094d\u0926\u0948\u091b',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textHint)),
          const SizedBox(height: AppSpacing.lg),
          LinearProgressIndicator(
            backgroundColor: AppColors.surfaceLight,
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryRed),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(AiCheckerProvider provider) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.danger.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_rounded, color: AppColors.danger, size: 48),
          const SizedBox(height: AppSpacing.md),
          Text(provider.errorMessage,
              style: AppTypography.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: () => provider.reset(),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryRed),
            child: Text('\u092a\u0941\u0928\u0903 \u092a\u094d\u0930\u092f\u093e\u0938',
                style: AppTypography.buttonPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildResultView(AiCheckerProvider provider) {
    final result = provider.result!;
    final isHighRisk = result.isFraud;
    final riskColor = result.severity == 'critical'
        ? AppColors.danger
        : result.severity == 'high'
            ? AppColors.primaryRed
            : result.severity == 'medium'
                ? AppColors.warning
                : AppColors.success;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Result banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [riskColor.withOpacity(0.2), riskColor.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: riskColor.withOpacity(0.5), width: 2),
          ),
          child: Column(
            children: [
              Icon(
                isHighRisk ? Icons.warning_rounded : Icons.check_circle_rounded,
                color: riskColor,
                size: 52,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                isHighRisk ? '\u0938\u0924\u0930\u094d\u0915! \u0920\u0917\u0940\u0915\u094b \u0938\u0902\u0915\u0947\u0924!' : '\u0920\u0917\u0940\u0915\u094b \u0938\u094d\u092a\u0937\u094d\u091f \u0938\u0902\u0915\u0947\u0924 \u091b\u0948\u0928',
                style: AppTypography.headlineLarge.copyWith(color: riskColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(result.resultNp,
                  style: AppTypography.bodyMedium.copyWith(height: 1.6),
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.md),

              // Risk meter
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\u091c\u094b\u0916\u093f\u092e \u0938\u094d\u0924\u0930:',
                          style: AppTypography.labelLarge.copyWith(color: AppColors.textHint)),
                      Text('${result.riskScore}%',
                          style: AppTypography.titleMedium.copyWith(color: riskColor)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: result.riskScore / 100,
                      backgroundColor: AppColors.surfaceLight,
                      valueColor: AlwaysStoppedAnimation(riskColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Red flags
        if (result.redFlags.isNotEmpty) ...[
          _buildSection(
            icon: Icons.flag_rounded,
            color: AppColors.danger,
            title: 'Red Flags \u2014 \u0938\u0924\u0930\u094d\u0915 \u0938\u0902\u0915\u0947\u0924:',
            items: result.redFlags,
            itemIcon: Icons.warning_amber_rounded,
            itemColor: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Prevention
        if (result.preventionSteps.isNotEmpty) ...[
          _buildSection(
            icon: Icons.shield_rounded,
            color: AppColors.success,
            title: '\u0915\u0938\u0930\u0940 \u092c\u091a\u094d\u0928\u0947?',
            items: result.preventionSteps,
            itemIcon: Icons.check_circle_rounded,
            itemColor: AppColors.success,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Law reference
        if (result.lawReference.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.gavel_rounded, color: AppColors.gold, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u0932\u093e\u0917\u0942 \u0915\u093e\u0928\u0941\u0928:',
                          style: AppTypography.labelLarge.copyWith(color: AppColors.textHint)),
                      Text(result.lawReference,
                          style: AppTypography.titleMedium.copyWith(color: AppColors.gold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Helplines
        Text('\u0924\u0941\u0930\u0928\u094d\u0924 \u0938\u092e\u094d\u092a\u0930\u094d\u0915:',
            style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
        const SizedBox(height: AppSpacing.sm),
        ...result.helplines.map((h) {
          final parts = h.split(': ');
          final name = parts[0];
          final number = parts.length > 1 ? parts[1] : '';
          return GestureDetector(
            onTap: () => _callNumber(number),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.06),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.danger.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.call_rounded, color: AppColors.danger, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                        if (number.isNotEmpty)
                          Text(number, style: AppTypography.labelLarge),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text('Call',
                        style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: AppSpacing.md),

        // Report button
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/report'),
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primaryRed,
              borderRadius: BorderRadius.circular(AppRadius.button),
              boxShadow: [
                BoxShadow(color: AppColors.primaryRed.withOpacity(0.4),
                    blurRadius: 16, offset: const Offset(0, 4)),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.report_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('\u0920\u0917\u0940 \u092d\u092f\u094b? Report \u0917\u0930\u094d\u0928\u0941\u0938\u094d!',
                      style: AppTypography.buttonPrimary),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color color,
    required String title,
    required List<String> items,
    required IconData itemIcon,
    required Color itemColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: AppTypography.titleMedium.copyWith(color: color)),
          ]),
          const SizedBox(height: AppSpacing.sm),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(itemIcon, color: itemColor, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(item, style: AppTypography.bodyMedium)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInputArea(AiCheckerProvider provider) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: const Border(top: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: 3,
              minLines: 1,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: '\u0906\u092b\u094d\u0928\u094b situation \u0928\u0947\u092a\u093e\u0932\u0940\u092e\u093e \u0932\u0947\u0916\u094d\u0928\u0941\u0938\u094d...',
                hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
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
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: provider.state == AiCheckerState.loading
                ? null
                : () => provider.checkFraud(_controller.text),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: provider.state == AiCheckerState.loading
                    ? AppColors.surfaceLight
                    : AppColors.primaryRed,
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: provider.state == AiCheckerState.loading
                    ? null
                    : [BoxShadow(color: AppColors.primaryRed.withOpacity(0.4),
                        blurRadius: 12, offset: const Offset(0, 3))],
              ),
              child: provider.state == AiCheckerState.loading
                  ? const Center(child: SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(
                          color: AppColors.textPrimary, strokeWidth: 2)))
                  : const Icon(Icons.search_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
