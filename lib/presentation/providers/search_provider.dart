import 'package:flutter/material.dart';
import '../../data/models/fraud_model.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  List<FraudModel> _results = [];
  List<String> _recentSearches = [];
  bool _isSearching = false;

  String get query => _query;
  List<FraudModel> get results => _results;
  List<String> get recentSearches => _recentSearches;
  bool get isSearching => _isSearching;

  final Map<String, String> _keywordMap = {
    'manpower': 'employment',
    'job': 'employment',
    'foreign': 'employment',
    'विदेश': 'employment',
    'online': 'digital',
    'internet': 'digital',
    'cyber': 'digital',
    'otp': 'digital',
    'sextortion': 'digital',
    'cooperative': 'cooperative',
    'सहकारी': 'cooperative',
    'investment': 'investment',
    'invest': 'investment',
    'ponzi': 'investment',
    'land': 'property',
    'jagga': 'property',
    'जग्गा': 'property',
    'health': 'health',
    'स्वास्थ्य': 'health',
    'education': 'education',
    'school': 'education',
    'visa': 'education',
    'loan': 'financial',
    'bank': 'financial',
    'wallet': 'financial',
    'social': 'social',
    'romance': 'social',
    'government': 'government',
    'सरकार': 'government',
    'police': 'crime',
  };

  void search(String query, List<FraudModel> allFrauds) {
    _query = query;
    if (query.isEmpty) {
      _results = [];
      _isSearching = false;
    } else {
      _isSearching = true;
      final mapped = _keywordMap[query.toLowerCase()] ?? query;
      _results = allFrauds.where((f) =>
        f.titleNp.contains(query) ||
        f.titleEn.toLowerCase().contains(query.toLowerCase()) ||
        f.category.toLowerCase().contains(mapped.toLowerCase()) ||
        f.descriptionNp.toLowerCase().contains(query.toLowerCase()) ||
        f.category.toLowerCase().contains(query.toLowerCase())
      ).toList();
      if (!_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 10) _recentSearches.removeLast();
      }
    }
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches = [];
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _results = [];
    _isSearching = false;
    notifyListeners();
  }
}
