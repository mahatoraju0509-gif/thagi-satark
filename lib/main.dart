import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/fraud_provider.dart';
import 'presentation/providers/ai_checker_provider.dart';
import 'presentation/providers/alert_provider.dart';
import 'presentation/providers/report_provider.dart';
import 'presentation/providers/search_provider.dart';
import 'presentation/providers/quiz_provider.dart';
import 'presentation/providers/agency_verify_provider.dart';
import 'presentation/providers/map_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0A0A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => FraudProvider()),
        ChangeNotifierProvider(create: (_) => AiCheckerProvider()),
        ChangeNotifierProvider(create: (_) => AlertProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => AgencyVerifyProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: const ThagiSatarkApp(),
    ),
  );
}
