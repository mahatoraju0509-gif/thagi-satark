import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/animations/animation_durations.dart';
import '../../../core/animations/animation_curves.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _contentController;
  late Animation<double> _contentOpacity;
  late Animation<Offset> _contentSlide;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.shield_rounded,
      'iconColor': AppColors.primaryRed,
      'title': 'ठगी चिन्नुस्',
      'description':
          '३०+ प्रकारका ठगीहरू विस्तृत जानकारीसहित — Foreign Employment देखि Online Fraud सम्म। Internet नभए पनि काम गर्छ।',
      'tag': '३०+ ठगी प्रकार',
      'tagColor': AppColors.primaryRed,
    },
    {
      'icon': Icons.psychology_rounded,
      'iconColor': AppColors.accentCyan,
      'title': 'AI ले detect गर्छ',
      'description':
          'तपाईंको situation नेपालीमा लेख्नुस् — AI ले तुरुन्त बताउँछ: ठगी हो कि होइन, Red Flags के छन्, अब के गर्ने।',
      'tag': 'AI Powered',
      'tagColor': AppColors.accentCyan,
    },
    {
      'icon': Icons.verified_user_rounded,
      'iconColor': AppColors.success,
      'title': 'सुरक्षित रहनुस्',
      'description':
          'Manpower Agency verify गर्नुस्, District-wise Fraud Map हेर्नुस्, कानुनी सहायता पाउनुस्, Community लाई alert गर्नुस्।',
      'tag': '१०० % नेपाली',
      'tagColor': AppColors.gold,
    },
  ];

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: AnimationDurations.dramatic,
    );
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: AnimationCurves.enter,
      ),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: AnimationCurves.spring,
      ),
    );
    _contentController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AnimationDurations.pageTransition,
        curve: AnimationCurves.spring,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.disclaimer);
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, AppRoutes.disclaimer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  'छोड्नुस्',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                  _contentController.reset();
                  _contentController.forward();
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Bottom section
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> page) {
    return SlideTransition(
      position: _contentSlide,
      child: FadeTransition(
        opacity: _contentOpacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (page['iconColor'] as Color).withOpacity(0.1),
                  border: Border.all(
                    color: (page['iconColor'] as Color).withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (page['iconColor'] as Color).withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
            child: Image.asset('assets/images/logo.png', width: 80, height: 80, fit: BoxFit.contain),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (page['tagColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: (page['tagColor'] as Color).withOpacity(0.4),
                  ),
                ),
                child: Text(
                  page['tag'] as String,
                  style: AppTypography.labelLarge.copyWith(
                    color: page['tagColor'] as Color,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                page['title'] as String,
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              // Description
              Text(
                page['description'] as String,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: AnimationDurations.normal,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primaryRed
                      : AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Next/Get Started button
          GestureDetector(
            onTap: _nextPage,
            child: AnimatedContainer(
              duration: AnimationDurations.normal,
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(AppRadius.button),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryRed.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _currentPage == _pages.length - 1
                      ? 'सुरु गरौं 🛡️'
                      : 'अर्को →',
                  style: AppTypography.buttonPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
