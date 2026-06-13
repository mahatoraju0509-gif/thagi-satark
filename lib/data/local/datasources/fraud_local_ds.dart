import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/fraud_model.dart';

class FraudLocalDs {
  static List<FraudModel>? _cache;

  Future<List<FraudModel>> getAllFrauds() async {
    if (_cache != null) return _cache!;
    final jsonString = await rootBundle.loadString('assets/data/frauds.json');
    final jsonList = jsonDecode(jsonString) as List;
    _cache = jsonList.map((e) => FraudModel.fromJson(e as Map<String, dynamic>)).toList();
    return _cache!;
  }

  Future<FraudModel?> getFraudById(String id) async {
    final frauds = await getAllFrauds();
    try {
      return frauds.firstWhere((f) => f.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<FraudModel>> getFraudsByCategory(String category) async {
    final frauds = await getAllFrauds();
    return frauds.where((f) => f.category == category).toList();
  }

  Future<List<FraudModel>> searchFrauds(String query) async {
    final frauds = await getAllFrauds();
    final q = query.toLowerCase();
    return frauds.where((f) =>
      f.titleNp.toLowerCase().contains(q) ||
      f.titleEn.toLowerCase().contains(q) ||
      f.descriptionNp.toLowerCase().contains(q) ||
      f.category.toLowerCase().contains(q)
    ).toList();
  }

  Future<List<FraudModel>> getFraudsBySeverity(String severity) async {
    final frauds = await getAllFrauds();
    return frauds.where((f) => f.severity == severity).toList();
  }

  void clearCache() => _cache = null;
}
