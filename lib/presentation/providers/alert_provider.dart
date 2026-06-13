import 'package:flutter/material.dart';
import '../../data/models/alert_model.dart';

class AlertProvider extends ChangeNotifier {
  List<AlertModel> _alerts = [];
  bool _isLoading = false;
  String _selectedFilter = 'सबै';

  List<AlertModel> get alerts => _filteredAlerts;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;
  int get unreadCount => _alerts.where((a) => !a.isRead).length;

  List<AlertModel> get _filteredAlerts {
    if (_selectedFilter == 'सबै') return _alerts;
    if (_selectedFilter == 'उच्च') return _alerts.where((a) => a.severity == 'high' || a.severity == 'critical').toList();
    if (_selectedFilter == 'मध्यम') return _alerts.where((a) => a.severity == 'medium').toList();
    return _alerts.where((a) => a.fraudType == _selectedFilter).toList();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void loadDummyAlerts() {
    _alerts = [
      // Critical alerts
      AlertModel(id: 'a001', titleNp: '🚨 काठमाडौंमा नयाँ Telegram Investment Scam!',
        descriptionNp: 'Telegram group मार्फत "Daily 5% profit" को लोभ देखाएर लाखौं ठगिएको। Group admin नेपाली देखिन्छन् तर पैसा India transfer हुन्छ। Cyber Bureau: 1177',
        district: 'काठमाडौं', severity: 'critical', fraudType: 'investment',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)), isRead: false),

      AlertModel(id: 'a002', titleNp: '🚨 रौतहटमा Gulf Manpower ठगी — ५०+ पीडित!',
        descriptionNp: 'Qatar र UAE मा राम्रो काम दिलाउने नाममा Rs.1.5 lakh अग्रिम लिएर agent भागेको। DoFE मा complaint दर्ता: 1180',
        district: 'रौतहट', severity: 'critical', fraudType: 'employment',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)), isRead: false),

      AlertModel(id: 'a003', titleNp: '🚨 सप्तरीमा Fake Cooperative — Rs.2 Crore ठगी!',
        descriptionNp: '"उज्यालो बचत सहकारी" नामको fake cooperative ले २०% monthly interest भनेर पैसा जम्मा गरेर भागेको। DoC: 01-4229032',
        district: 'सप्तरी', severity: 'critical', fraudType: 'cooperative',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)), isRead: false),

      // High alerts
      AlertModel(id: 'a004', titleNp: '⚠️ Facebook मा Fake iPhone Sales — Advance लिएर भाग्ने!',
        descriptionNp: 'Facebook Marketplace मा iPhone 15 Rs.35,000 मा बेच्छु भनेर advance लिएर contact बन्द गर्ने cases बढेका छन्। COD मात्र गर्नुस्।',
        district: 'काठमाडौं', severity: 'high', fraudType: 'online',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)), isRead: false),

      AlertModel(id: 'a005', titleNp: '⚠️ धनुषामा Fake Government Job Agent!',
        descriptionNp: 'लोकसेवामा pass गराइदिन्छु भनेर Rs.3 lakh लिने agent पकडिएको। सरकारी जागिरमा कहिल्यै पैसा लाग्दैन। CIAA: 1113',
        district: 'धनुषा', severity: 'high', fraudType: 'government',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)), isRead: false),

      AlertModel(id: 'a006', titleNp: '⚠️ पोखरामा Fake Study Visa Consultancy!',
        descriptionNp: 'Australia visa 100% guarantee भन्ने consultancy ले Rs.2 lakh लिएर fake documents दिएको। MoE: 01-4200385',
        district: 'पोखरा', severity: 'high', fraudType: 'education',
        createdAt: DateTime.now().subtract(const Duration(hours: 14)), isRead: true),

      AlertModel(id: 'a007', titleNp: '⚠️ चितवनमा Fake Land Broker!',
        descriptionNp: 'Bharatpur मा fake lalpurja देखाएर जग्गा बेच्ने broker पकडिएको। जग्गा किन्नु अघि Naapi मा verify गर्नुस्।',
        district: 'चितवन', severity: 'high', fraudType: 'property',
        createdAt: DateTime.now().subtract(const Duration(days: 1)), isRead: true),

      AlertModel(id: 'a008', titleNp: '⚠️ मोरङमा OTP Fraud — बैंक Account खाली!',
        descriptionNp: 'बैंकको नाममा call गरेर OTP माग्ने र account खाली गर्ने cases बढेका छन्। OTP कसैलाई नदिनुस्। NRB: 1414',
        district: 'मोरङ', severity: 'high', fraudType: 'digital',
        createdAt: DateTime.now().subtract(const Duration(days: 1)), isRead: true),

      // Medium alerts
      AlertModel(id: 'a009', titleNp: '🟡 Sextortion Cases बढेका — Cyber Bureau Alert!',
        descriptionNp: 'Unknown video call मार्फत intimate content record गरेर blackmail गर्ने cases Nepal मा बढेका छन्। Cyber Bureau: 1177',
        district: 'सबै', severity: 'medium', fraudType: 'digital',
        createdAt: DateTime.now().subtract(const Duration(days: 2)), isRead: true),

      AlertModel(id: 'a010', titleNp: '🟡 QR Code Scam Alert — Scan गर्दा पैसा जान्छ!',
        descriptionNp: '"Receive गर्न QR scan गर्नुस्" भन्ने message आएमा नगर्नुस्। QR scan = पैसा send। eSewa: 16600172222',
        district: 'सबै', severity: 'medium', fraudType: 'digital',
        createdAt: DateTime.now().subtract(const Duration(days: 2)), isRead: true),

      AlertModel(id: 'a011', titleNp: '🟡 काठमाडौंमा Fake Loan App!',
        descriptionNp: 'Play Store मा "Quick Loan Nepal" नामको fake app ले contacts access गरेर blackmail गर्दैछ। App uninstall गर्नुस्।',
        district: 'काठमाडौं', severity: 'medium', fraudType: 'financial',
        createdAt: DateTime.now().subtract(const Duration(days: 3)), isRead: true),

      AlertModel(id: 'a012', titleNp: '🟡 Rupandehi मा Fake Medicine Seller!',
        descriptionNp: 'Online मा cancer cure गर्ने medicine बेच्ने fake seller पकडिएको। DDA registered medicine मात्र किन्नुस्।',
        district: 'रुपन्देही', severity: 'medium', fraudType: 'health',
        createdAt: DateTime.now().subtract(const Duration(days: 3)), isRead: true),

      AlertModel(id: 'a013', titleNp: '🟡 Lottery Fraud SMS बढेको!',
        descriptionNp: '"तपाईंले Rs.5 lakh lottery जित्नुभयो" भन्ने SMS आएमा ignore गर्नुस्। नखेलेको lottery जित्न असम्भव।',
        district: 'सबै', severity: 'medium', fraudType: 'financial',
        createdAt: DateTime.now().subtract(const Duration(days: 4)), isRead: true),

      AlertModel(id: 'a014', titleNp: '🟡 सुनसरीमा Fake NGO Donation Fraud!',
        descriptionNp: 'Earthquake victims को नाममा door-to-door donation collect गर्ने fake NGO पकडिएको। SWC: swc.org.np मा verify गर्नुस्।',
        district: 'सुनसरी', severity: 'medium', fraudType: 'social',
        createdAt: DateTime.now().subtract(const Duration(days: 5)), isRead: true),

      AlertModel(id: 'a015', titleNp: '🟡 Cryptocurrency Ponzi Scheme — Nepal मा बढ्दो खतरा!',
        descriptionNp: 'Telegram मा crypto trading group मार्फत "500% profit" को लोभ देखाएर ठगी। NRB: 1414 मा report गर्नुस्।',
        district: 'सबै', severity: 'medium', fraudType: 'investment',
        createdAt: DateTime.now().subtract(const Duration(days: 6)), isRead: true),
    ];
    notifyListeners();
  }

  void markAsRead(String id) {
    _alerts = _alerts.map((a) {
      if (a.id == id) {
        return AlertModel(
          id: a.id, titleNp: a.titleNp, descriptionNp: a.descriptionNp,
          district: a.district, severity: a.severity, fraudType: a.fraudType,
          createdAt: a.createdAt, isRead: true,
        );
      }
      return a;
    }).toList();
    notifyListeners();
  }

  void markAllAsRead() {
    _alerts = _alerts.map((a) => AlertModel(
      id: a.id, titleNp: a.titleNp, descriptionNp: a.descriptionNp,
      district: a.district, severity: a.severity, fraudType: a.fraudType,
      createdAt: a.createdAt, isRead: true,
    )).toList();
    notifyListeners();
  }
}
