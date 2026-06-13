import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/screens/01_splash/splash_screen.dart';
import 'presentation/screens/02_onboarding/onboarding_screen.dart';
import 'presentation/screens/02_onboarding/disclaimer_screen.dart';
import 'presentation/screens/03_home/home_screen.dart';
import 'presentation/screens/04_ai_checker/ai_checker_screen.dart';
import 'presentation/screens/05_encyclopedia/encyclopedia_screen.dart';
import 'presentation/screens/05_encyclopedia/fraud_detail_screen.dart';
import 'presentation/screens/06_verify/verify_screen.dart';
import 'presentation/screens/07_fraud_map/fraud_map_screen.dart';
import 'presentation/screens/08_alerts/alerts_screen.dart';
import 'presentation/screens/08_alerts/alert_detail_screen.dart';
import 'presentation/screens/09_report/report_screen.dart';
import 'presentation/screens/09_report/report_success_screen.dart';
import 'presentation/screens/10_legal/legal_guide_screen.dart';
import 'presentation/screens/11_helplines/helplines_screen.dart';
import 'presentation/screens/12_quiz/quiz_home_screen.dart';
import 'presentation/screens/12_quiz/quiz_play_screen.dart';
import 'presentation/screens/12_quiz/quiz_result_screen.dart';
import 'presentation/screens/12_quiz/leaderboard_screen.dart';
import 'presentation/screens/13_search/search_screen.dart';
import 'presentation/screens/14_settings/settings_screen.dart';
import 'presentation/screens/15_about/about_screen.dart';

class ThagiSatarkApp extends StatelessWidget {
  const ThagiSatarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'ठगी सतर्क',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (_) => const SplashScreen(),
            AppRoutes.onboarding: (_) => const OnboardingScreen(),
            AppRoutes.disclaimer: (_) => const DisclaimerScreen(),
            AppRoutes.home: (_) => const HomeScreen(),
            AppRoutes.aiChecker: (_) => const AiCheckerScreen(),
            AppRoutes.encyclopedia: (_) => const EncyclopediaScreen(),
            AppRoutes.fraudDetail: (_) => const FraudDetailScreen(),
            AppRoutes.verify: (_) => const VerifyScreen(),
            AppRoutes.fraudMap: (_) => const FraudMapScreen(),
            AppRoutes.alerts: (_) => const AlertsScreen(),
            AppRoutes.alertDetail: (_) => const AlertDetailScreen(),
            AppRoutes.report: (_) => const ReportScreen(),
            AppRoutes.reportSuccess: (_) => const ReportSuccessScreen(),
            AppRoutes.legal: (_) => const LegalGuideScreen(),
            AppRoutes.helplines: (_) => const HelplinesScreen(),
            AppRoutes.quizHome: (_) => const QuizHomeScreen(),
            AppRoutes.quizPlay: (_) => const QuizPlayScreen(),
            AppRoutes.quizResult: (_) => const QuizResultScreen(),
            AppRoutes.leaderboard: (_) => const LeaderboardScreen(),
            AppRoutes.search: (_) => const SearchScreen(),
            AppRoutes.settings: (_) => const SettingsScreen(),
            AppRoutes.about: (_) => const AboutScreen(),
          },
        );
      },
    );
  }
}
