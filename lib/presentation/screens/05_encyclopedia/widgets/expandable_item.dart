import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';

class ExpandableItem extends StatefulWidget {
  final int index;
  final String title;
  final String detail;
  final Color color;
  final IconData? leadingIcon;
  final Widget? detailWidget;

  const ExpandableItem({
    super.key,
    required this.index,
    required this.title,
    required this.detail,
    required this.color,
    this.leadingIcon,
    this.detailWidget,
  });

  @override
  State<ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem>
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
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: _isExpanded
            ? widget.color.withOpacity(0.08)
            : AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _isExpanded
              ? widget.color.withOpacity(0.5)
              : widget.color.withOpacity(0.25),
          width: _isExpanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Clickable Header
          GestureDetector(
            onTap: _toggle,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(
                      color: _isExpanded
                          ? widget.color
                          : widget.color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: widget.leadingIcon != null && !_isExpanded
                          ? Icon(widget.leadingIcon, color: widget.color, size: 18)
                          : Text(
                              '${widget.index}',
                              style: AppTypography.labelLarge.copyWith(
                                color: _isExpanded ? Colors.white : widget.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTypography.titleMedium.copyWith(
                        color: _isExpanded ? widget.color : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _isExpanded ? widget.color : AppColors.textHint,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Detail
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.md,
                bottom: AppSpacing.md,
              ),
              child: widget.detailWidget ??
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: widget.color.withOpacity(0.2)),
                    ),
                    child: Text(
                      widget.detail,
                      style: AppTypography.bodyMedium.copyWith(height: 1.6),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
