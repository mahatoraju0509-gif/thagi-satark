import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';

class ExpandablePreventionItem extends StatefulWidget {
  final int index;
  final String step;
  final String detail;

  const ExpandablePreventionItem({
    super.key,
    required this.index,
    required this.step,
    required this.detail,
  });

  @override
  State<ExpandablePreventionItem> createState() => _ExpandablePreventionItemState();
}

class _ExpandablePreventionItemState extends State<ExpandablePreventionItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: _isExpanded
            ? AppColors.success.withOpacity(0.08)
            : AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _isExpanded
              ? AppColors.success.withOpacity(0.5)
              : AppColors.success.withOpacity(0.25),
          width: _isExpanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header — always visible, clickable
          GestureDetector(
            onTap: _toggle,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: _isExpanded
                          ? AppColors.success
                          : AppColors.success.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${widget.index}',
                        style: AppTypography.labelLarge.copyWith(
                          color: _isExpanded ? Colors.white : AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.step,
                      style: AppTypography.titleMedium.copyWith(
                        color: _isExpanded ? AppColors.success : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _isExpanded ? AppColors.success : AppColors.textHint,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Detail — animated expand
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.md,
                bottom: AppSpacing.md,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: AppColors.success.withOpacity(0.2)),
                ),
                child: Text(
                  widget.detail,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
