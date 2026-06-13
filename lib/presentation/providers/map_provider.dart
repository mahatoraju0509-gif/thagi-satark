import 'package:flutter/material.dart';

class DistrictFraudData {
  final String name;
  final String province;
  final int fraudCount;
  final String topFraud;
  final String severity;

  const DistrictFraudData({
    required this.name,
    required this.province,
    required this.fraudCount,
    required this.topFraud,
    required this.severity,
  });
}

class MapProvider extends ChangeNotifier {
  String _selectedProvince = 'सबै';
  DistrictFraudData? _selectedDistrict;
  String? _selectedSeverity;
  bool _isLoading = false;

  String get selectedProvince => _selectedProvince;
  DistrictFraudData? get selectedDistrict => _selectedDistrict;
  String? get selectedSeverity => _selectedSeverity;
  bool get isLoading => _isLoading;

  final List<String> provinces = [
    'सबै',
    'कोशी',
    'मधेश',
    'बागमती',
    'गण्डकी',
    'लुम्बिनी',
    'कर्णाली',
    'सुदूरपश्चिम',
  ];

  final List<DistrictFraudData> allDistricts = [
    // बागमती
    DistrictFraudData(name: 'काठमाडौं', province: 'बागमती', fraudCount: 4521, topFraud: 'Online Fraud', severity: 'critical'),
    DistrictFraudData(name: 'ललितपुर', province: 'बागमती', fraudCount: 2341, topFraud: 'Investment Fraud', severity: 'critical'),
    DistrictFraudData(name: 'भक्तपुर', province: 'बागमती', fraudCount: 1876, topFraud: 'Online Shopping', severity: 'high'),
    DistrictFraudData(name: 'नुवाकोट', province: 'बागमती', fraudCount: 456, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'रसुवा', province: 'बागमती', fraudCount: 123, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'धादिङ', province: 'बागमती', fraudCount: 345, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'मकवानपुर', province: 'बागमती', fraudCount: 567, topFraud: 'Investment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'रामेछाप', province: 'बागमती', fraudCount: 234, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'सिन्धुली', province: 'बागमती', fraudCount: 312, topFraud: 'Cooperative Fraud', severity: 'medium'),
    DistrictFraudData(name: 'सिन्धुपाल्चोक', province: 'बागमती', fraudCount: 289, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'काभ्रेपलाञ्चोक', province: 'बागमती', fraudCount: 678, topFraud: 'Online Fraud', severity: 'medium'),
    DistrictFraudData(name: 'चितवन', province: 'बागमती', fraudCount: 1234, topFraud: 'Investment Fraud', severity: 'high'),
    // कोशी
    DistrictFraudData(name: 'मोरङ', province: 'कोशी', fraudCount: 1456, topFraud: 'Employment Fraud', severity: 'high'),
    DistrictFraudData(name: 'सुनसरी', province: 'कोशी', fraudCount: 1234, topFraud: 'Online Fraud', severity: 'high'),
    DistrictFraudData(name: 'झापा', province: 'कोशी', fraudCount: 987, topFraud: 'Investment Fraud', severity: 'high'),
    DistrictFraudData(name: 'इलाम', province: 'कोशी', fraudCount: 456, topFraud: 'Employment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'पाँचथर', province: 'कोशी', fraudCount: 234, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'ताप्लेजुङ', province: 'कोशी', fraudCount: 123, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'संखुवासभा', province: 'कोशी', fraudCount: 156, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'सोलुखुम्बु', province: 'कोशी', fraudCount: 189, topFraud: 'Tourism Fraud', severity: 'low'),
    DistrictFraudData(name: 'ओखलढुङ्गा', province: 'कोशी', fraudCount: 145, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'खोटाङ', province: 'कोशी', fraudCount: 167, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'भोजपुर', province: 'कोशी', fraudCount: 178, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'धनकुटा', province: 'कोशी', fraudCount: 234, topFraud: 'Investment Fraud', severity: 'low'),
    DistrictFraudData(name: 'तेह्रथुम', province: 'कोशी', fraudCount: 145, topFraud: 'Employment Fraud', severity: 'low'),
    // मधेश
    DistrictFraudData(name: 'सर्लाही', province: 'मधेश', fraudCount: 876, topFraud: 'Employment Fraud', severity: 'high'),
    DistrictFraudData(name: 'महोत्तरी', province: 'मधेश', fraudCount: 765, topFraud: 'Land Fraud', severity: 'high'),
    DistrictFraudData(name: 'धनुषा', province: 'मधेश', fraudCount: 987, topFraud: 'Investment Fraud', severity: 'high'),
    DistrictFraudData(name: 'सिरहा', province: 'मधेश', fraudCount: 678, topFraud: 'Employment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'सप्तरी', province: 'मधेश', fraudCount: 543, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'रौतहट', province: 'मधेश', fraudCount: 654, topFraud: 'Employment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'बारा', province: 'मधेश', fraudCount: 567, topFraud: 'Cooperative Fraud', severity: 'medium'),
    DistrictFraudData(name: 'पर्सा', province: 'मधेश', fraudCount: 489, topFraud: 'Investment Fraud', severity: 'medium'),
    // गण्डकी
    DistrictFraudData(name: 'कास्की', province: 'गण्डकी', fraudCount: 1123, topFraud: 'Tourism Fraud', severity: 'high'),
    DistrictFraudData(name: 'तनहुँ', province: 'गण्डकी', fraudCount: 456, topFraud: 'Investment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'स्याङ्जा', province: 'गण्डकी', fraudCount: 345, topFraud: 'Cooperative Fraud', severity: 'medium'),
    DistrictFraudData(name: 'गोरखा', province: 'गण्डकी', fraudCount: 289, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'लमजुङ', province: 'गण्डकी', fraudCount: 234, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'मनाङ', province: 'गण्डकी', fraudCount: 45, topFraud: 'Tourism Fraud', severity: 'low'),
    DistrictFraudData(name: 'मुस्ताङ', province: 'गण्डकी', fraudCount: 67, topFraud: 'Tourism Fraud', severity: 'low'),
    DistrictFraudData(name: 'म्याग्दी', province: 'गण्डकी', fraudCount: 123, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'पर्वत', province: 'गण्डकी', fraudCount: 178, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'नवलपुर', province: 'गण्डकी', fraudCount: 345, topFraud: 'Investment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'बाग्लुङ', province: 'गण्डकी', fraudCount: 234, topFraud: 'Land Fraud', severity: 'low'),
    // लुम्बिनी
    DistrictFraudData(name: 'रुपन्देही', province: 'लुम्बिनी', fraudCount: 1345, topFraud: 'Employment Fraud', severity: 'high'),
    DistrictFraudData(name: 'कपिलवस्तु', province: 'लुम्बिनी', fraudCount: 567, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'नवलपरासी', province: 'लुम्बिनी', fraudCount: 456, topFraud: 'Cooperative Fraud', severity: 'medium'),
    DistrictFraudData(name: 'पाल्पा', province: 'लुम्बिनी', fraudCount: 345, topFraud: 'Investment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'अर्घाखाँची', province: 'लुम्बिनी', fraudCount: 234, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'गुल्मी', province: 'लुम्बिनी', fraudCount: 289, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'प्युठान', province: 'लुम्बिनी', fraudCount: 234, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'रोल्पा', province: 'लुम्बिनी', fraudCount: 189, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'रुकुम पूर्व', province: 'लुम्बिनी', fraudCount: 123, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'बाँके', province: 'लुम्बिनी', fraudCount: 678, topFraud: 'Investment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'बर्दिया', province: 'लुम्बिनी', fraudCount: 345, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'दाङ', province: 'लुम्बिनी', fraudCount: 567, topFraud: 'Cooperative Fraud', severity: 'medium'),
    // कर्णाली
    DistrictFraudData(name: 'सुर्खेत', province: 'कर्णाली', fraudCount: 456, topFraud: 'Employment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'दैलेख', province: 'कर्णाली', fraudCount: 234, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'जाजरकोट', province: 'कर्णाली', fraudCount: 156, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'डोल्पा', province: 'कर्णाली', fraudCount: 67, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'हुम्ला', province: 'कर्णाली', fraudCount: 45, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'जुम्ला', province: 'कर्णाली', fraudCount: 89, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'मुगु', province: 'कर्णाली', fraudCount: 56, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'कालिकोट', province: 'कर्णाली', fraudCount: 123, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'रुकुम पश्चिम', province: 'कर्णाली', fraudCount: 145, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'सल्यान', province: 'कर्णाली', fraudCount: 189, topFraud: 'Land Fraud', severity: 'low'),
    // सुदूरपश्चिम
    DistrictFraudData(name: 'कैलाली', province: 'सुदूरपश्चिम', fraudCount: 678, topFraud: 'Employment Fraud', severity: 'medium'),
    DistrictFraudData(name: 'कञ्चनपुर', province: 'सुदूरपश्चिम', fraudCount: 456, topFraud: 'Land Fraud', severity: 'medium'),
    DistrictFraudData(name: 'डोटी', province: 'सुदूरपश्चिम', fraudCount: 234, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'अछाम', province: 'सुदूरपश्चिम', fraudCount: 189, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'बाजुरा', province: 'सुदूरपश्चिम', fraudCount: 123, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'बझाङ', province: 'सुदूरपश्चिम', fraudCount: 145, topFraud: 'Land Fraud', severity: 'low'),
    DistrictFraudData(name: 'डडेलधुरा', province: 'सुदूरपश्चिम', fraudCount: 167, topFraud: 'Employment Fraud', severity: 'low'),
    DistrictFraudData(name: 'बैतडी', province: 'सुदूरपश्चिम', fraudCount: 189, topFraud: 'Cooperative Fraud', severity: 'low'),
    DistrictFraudData(name: 'दार्चुला', province: 'सुदूरपश्चिम', fraudCount: 134, topFraud: 'Employment Fraud', severity: 'low'),
  ];

  List<DistrictFraudData> get filteredDistricts {
    List<DistrictFraudData> base = _selectedProvince == 'सबै'
        ? allDistricts
        : allDistricts.where((d) => d.province == _selectedProvince).toList();
    if (_selectedSeverity != null) {
      return base.where((d) => d.severity == _selectedSeverity).toList();
    }
    return base;
  }

  int get totalFrauds => allDistricts.fold(0, (sum, d) => sum + d.fraudCount);

  List<DistrictFraudData> get topDistricts {
    final sorted = List<DistrictFraudData>.from(filteredDistricts)
      ..sort((a, b) => b.fraudCount.compareTo(a.fraudCount));
    return sorted.take(5).toList();
  }

  void selectProvince(String province) {
    _selectedProvince = province;
    _selectedDistrict = null;
    _selectedSeverity = null;
    notifyListeners();
  }

  void selectSeverity(String? severity) {
    _selectedSeverity = severity;
    _selectedDistrict = null;
    notifyListeners();
  }

  void selectDistrict(DistrictFraudData district) {
    _selectedDistrict = district;
    notifyListeners();
  }

  void clearSelection() {
    _selectedDistrict = null;
    notifyListeners();
  }

  Color getSeverityColor(String severity) {
    switch (severity) {
      case 'critical': return const Color(0xFFB71C1C);
      case 'high': return const Color(0xFFE53935);
      case 'medium': return const Color(0xFFFF9800);
      case 'low': return const Color(0xFF4CAF50);
      default: return const Color(0xFF757575);
    }
  }

  Color getHeatColor(int count) {
    if (count >= 3000) return const Color(0xFFB71C1C);
    if (count >= 1000) return const Color(0xFFE53935);
    if (count >= 500) return const Color(0xFFFF7043);
    if (count >= 200) return const Color(0xFFFF9800);
    return const Color(0xFF4CAF50);
  }
}
