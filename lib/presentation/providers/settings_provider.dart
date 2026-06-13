import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _selectedDistrict = 'काठमाडौं';
  bool _notificationsEnabled = true;
  bool _emergencyAlertsEnabled = true;

  String get selectedDistrict => _selectedDistrict;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get emergencyAlertsEnabled => _emergencyAlertsEnabled;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedDistrict = prefs.getString('district') ?? 'काठमाडौं';
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    _emergencyAlertsEnabled = prefs.getBool('emergency_alerts') ?? true;
    notifyListeners();
  }

  Future<void> acceptDisclaimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('disclaimer_accepted', true);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    notifyListeners();
  }

  Future<void> setDistrict(String district) async {
    _selectedDistrict = district;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('district', district);
    notifyListeners();
  }

  Future<void> setNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    notifyListeners();
  }

  Future<void> setEmergencyAlerts(bool value) async {
    _emergencyAlertsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('emergency_alerts', value);
    notifyListeners();
  }
}
