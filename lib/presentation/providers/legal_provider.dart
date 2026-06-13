import 'package:flutter/material.dart';

class LegalProvider extends ChangeNotifier {
  String _selectedFraudType = 'employment';

  String get selectedFraudType => _selectedFraudType;

  void setFraudType(String type) {
    _selectedFraudType = type;
    notifyListeners();
  }
}
