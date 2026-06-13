import 'package:flutter/material.dart';
import '../../data/models/fraud_model.dart';
import '../../data/local/datasources/fraud_local_ds.dart';

class FraudProvider extends ChangeNotifier {
  final FraudLocalDs _localDs = FraudLocalDs();

  List<FraudModel> _frauds = [];
  List<FraudModel> _filtered = [];
  bool _isLoading = false;
  String _selectedCategory = 'सबै';
  String _error = '';

  List<FraudModel> get frauds => _frauds;
  List<FraudModel> get filtered => _filtered;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get error => _error;

  Future<void> loadFrauds() async {
    if (_frauds.isNotEmpty) return;
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _frauds = await _localDs.getAllFrauds();
      _filtered = List.from(_frauds);
    } catch (e) {
      _error = 'Data load गर्न सकिएन: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == 'सबै') {
      _filtered = List.from(_frauds);
    } else if (category == 'high' || category == 'medium' || category == 'critical') {
      _filtered = _frauds.where((f) => f.severity == category).toList();
    } else {
      _filtered = _frauds.where((f) => f.category == category).toList();
    }
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filtered = List.from(_frauds);
    } else {
      final q = query.toLowerCase();
      _filtered = _frauds.where((f) =>
        f.titleNp.contains(query) ||
        f.titleEn.toLowerCase().contains(q) ||
        f.descriptionNp.contains(query) ||
        f.category.toLowerCase().contains(q)
      ).toList();
    }
    notifyListeners();
  }

  FraudModel? getFraudById(String id) {
    try {
      return _frauds.firstWhere((f) => f.id == id);
    } catch (_) {
      return null;
    }
  }
}
