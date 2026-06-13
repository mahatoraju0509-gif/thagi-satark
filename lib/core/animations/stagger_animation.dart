import 'package:flutter/material.dart';
import 'animation_durations.dart';
import 'animation_curves.dart';

// Stagger Animation — list items appear one by one
class StaggerAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration itemDuration;
  final Offset beginOffset;

  const StaggerAnimation({
    super.key,
    required this.children,
    this.staggerDelay = AnimationDurations.listStagger,
    this.itemDuration = AnimationDurations.cardEntrance,
    this.beginOffset = const Offset(0.0, 0.4),
  });

  @override
  State<StaggerAnimation> createState() => _StaggerAnimationState();
}

class _StaggerAnimationState extends State<StaggerAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (i) => AnimationController(
        vsync: this,
        duration: widget.itemDuration,
      ),
    );
    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: widget.beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: AnimationCurves.spring,
      ));
    }).toList();
    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: AnimationCurves.enter,
        ),
      );
    }).toList();

    // Start staggered
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (i) {
        return SlideTransition(
          position: _slideAnimations[i],
          child: FadeTransition(
            opacity: _fadeAnimations[i],
            child: widget.children[i],
          ),
        );
      }),
    );
  }
}
