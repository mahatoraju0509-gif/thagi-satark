import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  String _selectedFraudType = '';
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  String get selectedFraudType => _selectedFraudType;
  bool get isSubmitting => _isSubmitting;
  bool get isSubmitted => _isSubmitted;

  void setFraudType(String type) {
    _selectedFraudType = type;
    notifyListeners();
  }

  Future<void> submitReport({
    required String description,
    required bool isAnonymous,
    String location = '',
    String scammerInfo = '',
    String amount = '',
    String date = '',
  }) async {
    _isSubmitting = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isSubmitting = false;
    _isSubmitted = true;
    notifyListeners();
  }

  void reset() {
    _selectedFraudType = '';
    _isSubmitting = false;
    _isSubmitted = false;
    notifyListeners();
  }
}
