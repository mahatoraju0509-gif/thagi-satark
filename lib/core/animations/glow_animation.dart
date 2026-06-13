import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'animation_durations.dart';

// Glow Animation Widget
class GlowAnimation extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double minBlur;
  final double maxBlur;
  final double spreadRadius;

  const GlowAnimation({
    super.key,
    required this.child,
    this.glowColor = AppColors.primaryRed,
    this.minBlur = 8.0,
    this.maxBlur = 24.0,
    this.spreadRadius = 2.0,
  });

  @override
  State<GlowAnimation> createState() => _GlowAnimationState();
}

class _GlowAnimationState extends State<GlowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationDurations.glow,
    );
    _glowAnimation = Tween<double>(
      begin: widget.minBlur,
      end: widget.maxBlur,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.5),
                blurRadius: _glowAnimation.value,
                spreadRadius: widget.spreadRadius,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

// Glow Text Widget
class GlowText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final List<Color> gradientColors;

  const GlowText({
    super.key,
    required this.text,
    required this.style,
    this.gradientColors = const [
      AppColors.primaryRed,
      AppColors.gold,
      AppColors.accentCyan,
    ],
  });

  @override
  State<GlowText> createState() => _GlowTextState();
}

class _GlowTextState extends State<GlowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: widget.gradientColors,
            begin: Alignment(_animation.value * 2 - 1, 0),
            end: Alignment(_animation.value * 2, 0),
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}

// Animated Checkmark
class AnimatedCheckmark extends StatefulWidget {
  final double size;
  final Color color;
  final Duration delay;

  const AnimatedCheckmark({
    super.key,
    this.size = 80,
    this.color = AppColors.success,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedCheckmark> createState() => _AnimatedCheckmarkState();
}

class _AnimatedCheckmarkState extends State<AnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationDurations.checkmark,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(0.15),
            border: Border.all(
              color: widget.color.withOpacity(_animation.value),
              width: 2,
            ),
          ),
          child: Opacity(
            opacity: _animation.value,
            child: Icon(
              Icons.check_rounded,
              color: widget.color,
              size: widget.size * 0.5,
            ),
          ),
        );
      },
    );
  }
}

// Animated Warning
class AnimatedWarning extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedWarning({
    super.key,
    this.size = 80,
    this.color = AppColors.danger,
  });

  @override
  State<AnimatedWarning> createState() => _AnimatedWarningState();
}

class _AnimatedWarningState extends State<AnimatedWarning>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationDurations.warning,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.15),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: widget.color,
              size: widget.size * 0.5,
            ),
          ),
        );
      },
    );
  }
}

// Animated Counter
class AnimatedCounter extends StatefulWidget {
  final int targetNumber;
  final TextStyle style;
  final String suffix;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetNumber,
    required this.style,
    this.suffix = '',
    this.duration = AnimationDurations.counter,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = IntTween(begin: 0, end: widget.targetNumber).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
