import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/agency_model.dart';

enum VerifyState { idle, loading, result, error, notFound }

class AgencyVerifyProvider extends ChangeNotifier {
  VerifyState _state = VerifyState.idle;
  AgencyModel? _result;
  String _selectedType = 'Manpower';
  List<AgencyModel> _allAgencies = [];
  String _searchQuery = '';

  VerifyState get state => _state;
  AgencyModel? get result => _result;
  String get selectedType => _selectedType;
  String get searchQuery => _searchQuery;
  List<AgencyModel> get blacklistedAgencies =>
      _allAgencies.where((a) => a.isBlacklisted).toList();

  Future<void> loadData() async {
    if (_allAgencies.isNotEmpty) return;
    try {
      final jsonString = await rootBundle.loadString('assets/data/verify/agencies.json');
      final jsonList = jsonDecode(jsonString) as List;
      _allAgencies = jsonList
          .map((e) => AgencyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Agency load error: $e');
    }
  }

  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  Future<void> verifyWithType(String name, String type) async {
    _selectedType = type;
    await verify(name);
  }

  Future<void> verify(String name) async {
    if (name.trim().isEmpty) return;
    _searchQuery = name.trim();
    _state = VerifyState.loading;
    notifyListeners();

    await loadData();
    await Future.delayed(const Duration(milliseconds: 800));

    final query = name.trim().toLowerCase();
    final matches = _allAgencies.where((a) {
      final typeMatch = a.type == _selectedType;
      final nameMatch = a.nameNp.toLowerCase().contains(query) ||
          a.nameEn.toLowerCase().contains(query) ||
          a.licenseNumber.toLowerCase().contains(query);
      return typeMatch && nameMatch;
    }).toList();

    if (matches.isNotEmpty) {
      _result = matches.first;
      _state = VerifyState.result;
    } else {
      _result = null;
      _state = VerifyState.notFound;
    }
    notifyListeners();
  }

  void reset() {
    _state = VerifyState.idle;
    _result = null;
    _searchQuery = '';
    notifyListeners();
  }
}
