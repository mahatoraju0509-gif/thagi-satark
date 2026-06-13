import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/shimmer_animation.dart';

class TsLoading extends StatelessWidget {
  const TsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          4,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ShimmerAnimation(
              width: double.infinity,
              height: 80,
              borderRadius: AppRadius.md,
            ),
          ),
        ),
      ),
    );
  }
}

class TsErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TsErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.danger, size: 64),
            const SizedBox(height: 16),
            Text(message,
                style: AppTypography.bodyMedium, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('फेरि प्रयास गर्नुस्'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TsEmptyView extends StatelessWidget {
  final String message;
  final IconData icon;

  const TsEmptyView({
    super.key,
    required this.message,
    this.icon = Icons.inbox_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textHint, size: 64),
            const SizedBox(height: 16),
            Text(message,
                style: AppTypography.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class TsConnectivityBanner extends StatelessWidget {
  final bool isOnline;

  const TsConnectivityBanner({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isOnline ? 0 : 36,
      color: AppColors.warning,
      child: isOnline
          ? const SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Internet छैन — Offline mode',
                  style: AppTypography.labelLarge.copyWith(
                      color: Colors.white),
                ),
              ],
            ),
    );
  }
}
