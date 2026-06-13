import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/animations/animation_durations.dart';
import '../../../core/animations/animation_curves.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Shield animation
  late AnimationController _shieldController;
  late Animation<double> _shieldScale;
  late Animation<double> _shieldOpacity;

  // Glow animation
  late AnimationController _glowController;
  late Animation<double> _glowRadius;

  // Text animation
  late AnimationController _textController;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  // Tagline animation
  late AnimationController _taglineController;
  late Animation<double> _taglineOpacity;

  // Progress animation
  late AnimationController _progressController;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSequence();
  }

  void _initAnimations() {
    // Shield
    _shieldController = AnimationController(
      vsync: this,
      duration: AnimationDurations.epic,
    );
    _shieldScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shieldController,
        curve: AnimationCurves.bounce,
      ),
    );
    _shieldOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shieldController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Glow
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _glowRadius = Tween<double>(begin: 20.0, end: 60.0).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    // Text
    _textController = AnimationController(
      vsync: this,
      duration: AnimationDurations.dramatic,
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: AnimationCurves.enter,
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: AnimationCurves.spring,
      ),
    );

    // Tagline
    _taglineController = AnimationController(
      vsync: this,
      duration: AnimationDurations.slow,
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineController,
        curve: AnimationCurves.enter,
      ),
    );

    // Progress
    _progressController = AnimationController(
      vsync: this,
      duration: AnimationDurations.splash,
    );
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _startSequence() async {
    // Shield appears
    await Future.delayed(const Duration(milliseconds: 300));
    _shieldController.forward();

    // Glow starts
    await Future.delayed(const Duration(milliseconds: 500));
    _glowController.repeat(reverse: true);

    // App name appears
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Tagline appears
    await Future.delayed(const Duration(milliseconds: 1200));
    _taglineController.forward();

    // Progress bar starts
    await Future.delayed(const Duration(milliseconds: 1500));
    _progressController.forward();

    // Navigate
    await Future.delayed(const Duration(milliseconds: 3800));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    _shieldController.dispose();
    _glowController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient circles
          _buildBackgroundEffects(),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Shield
                _buildAnimatedShield(),

                const SizedBox(height: 32),

                // App Name
                _buildAppName(),

                const SizedBox(height: 12),

                // Tagline
                _buildTagline(),
              ],
            ),
          ),

          // Bottom progress bar
          _buildProgressBar(),

          // Made in Nepal
          _buildMadeInNepal(),
        ],
      ),
    );
  }

  Widget _buildBackgroundEffects() {
    return Stack(
      children: [
        // Top left glow
        Positioned(
          top: -100,
          left: -100,
          child: AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryRed.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Bottom right glow
        Positioned(
          bottom: -80,
          right: -80,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentCyan.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedShield() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _shieldController,
        _glowController,
      ]),
      builder: (context, child) {
        return Opacity(
          opacity: _shieldOpacity.value,
          child: Transform.scale(
            scale: _shieldScale.value,
            child: Container(
              width: 140,
              height: 140,
             child: Image.asset('assets/images/logo.png', width: 100, height: 100, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      AppColors.textPrimary,
                      AppColors.primaryRedLight,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'ठगी सतर्क',
                    style: AppTypography.displayLarge.copyWith(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'THAGI SATARK',
                  style: AppTypography.englishLabel.copyWith(
                    color: AppColors.textHint,
                    letterSpacing: 6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagline() {
    return FadeTransition(
      opacity: _taglineOpacity,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderDark,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
          color: AppColors.surfaceDark,
        ),
        child: Text(
          'एक app, सम्पूर्ण सुरक्षा',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      bottom: 80,
      left: 48,
      right: 48,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _progress,
            builder: (context, child) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: _progress.value,
                      backgroundColor: AppColors.surfaceLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryRed,
                      ),
                      minHeight: 3,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMadeInNepal() {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _taglineOpacity,
        child: Center(
          child: Text(
            'नेपालका लागि बनाइएको 🇳🇵',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }
}
