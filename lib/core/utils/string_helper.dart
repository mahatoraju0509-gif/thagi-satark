import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneHelper {
  PhoneHelper._();

  static Future<void> call(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    await SystemChannels.platform.invokeMethod(
      'url_launcher/launch',
      uri.toString(),
    );
  }
}

class ClipboardHelper {
  ClipboardHelper._();

  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}

class StringHelper {
  StringHelper._();

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}

class DateHelper {
  DateHelper._();

  static String formatNepali(DateTime date) {
    final months = [
      'जनवरी', 'फेब्रुअरी', 'मार्च', 'अप्रिल',
      'मे', 'जुन', 'जुलाई', 'अगस्ट',
      'सेप्टेम्बर', 'अक्टोबर', 'नोभेम्बर', 'डिसेम्बर'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String timeAgoNepali(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'भर्खरै';
    if (diff.inMinutes < 60) return '${diff.inMinutes} मिनेट अघि';
    if (diff.inHours < 24) return '${diff.inHours} घण्टा अघि';
    if (diff.inDays < 7) return '${diff.inDays} दिन अघि';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} हप्ता अघि';
    return formatNepali(date);
  }
}

class ConnectivityHelper {
  ConnectivityHelper._();

  static bool _isOnline = true;

  static bool get isOnline => _isOnline;
  static bool get isOffline => !_isOnline;

  static void setStatus(bool status) {
    _isOnline = status;
  }
}

class DistrictHelper {
  DistrictHelper._();

  static const List<String> allDistricts = [
    'काठमाडौं', 'ललितपुर', 'भक्तपुर', 'नुवाकोट', 'रसुवा',
    'धादिङ', 'मकवानपुर', 'रौतहट', 'बारा', 'पर्सा',
    'चितवन', 'गोर्खा', 'लमजुङ', 'तनहुँ', 'स्याङ्जा',
    'कास्की', 'मनाङ', 'मुस्ताङ', 'म्याग्दी', 'पर्वत',
    'बाग्लुङ', 'गुल्मी', 'पाल्पा', 'नवलपुर', 'रुपन्देही',
    'कपिलवस्तु', 'अर्घाखाँची', 'प्युठान', 'रोल्पा', 'रुकुम पश्चिम',
    'सल्यान', 'डोल्पा', 'जुम्ला', 'कालिकोट', 'मुगु',
    'हुम्ला', 'बझाङ', 'अछाम', 'डोटी', 'बैतडी',
    'डडेलधुरा', 'दार्चुला', 'बाजुरा', 'सुर्खेत', 'दैलेख',
    'जाजरकोट', 'रुकुम पूर्व', 'सिन्धुली', 'रामेछाप', 'काभ्रेपलाञ्चोक',
    'सिन्धुपाल्चोक', 'दोलखा', 'सोलुखुम्बु', 'ओखलढुङ्गा', 'खोटाङ',
    'भोजपुर', 'धनकुटा', 'तेह्रथुम', 'संखुवासभा', 'ताप्लेजुङ',
    'पाँचथर', 'इलाम', 'झापा', 'मोरङ', 'सुनसरी',
    'सप्तरी', 'सिराहा', 'धनुषा', 'महोत्तरी', 'सर्लाही',
    'सिन्धुली', 'उदयपुर', 'कोशी', 'सुकेत', 'बर्दिया',
    'बाँके', 'दाङ', 'कैलाली', 'कञ्चनपुर'
  ];

  static List<String> search(String query) {
    if (query.isEmpty) return allDistricts;
    return allDistricts
        .where((d) => d.contains(query))
        .toList();
  }
}

class LanguageHelper {
  LanguageHelper._();

  static bool _isNepali = true;

  static bool get isNepali => _isNepali;
  static bool get isEnglish => !_isNepali;

  static void setNepali() => _isNepali = true;
  static void setEnglish() => _isNepali = false;
  static void toggle() => _isNepali = !_isNepali;
}

class ShareHelper {
  ShareHelper._();

  static String buildFraudShareText({
    required String fraudName,
    required String summary,
  }) {
    return '''
🛡️ ठगी सतर्क — सावधान!

⚠️ $fraudName

$summary

🔗 थप जानकारीको लागि:
ठगी सतर्क app डाउनलोड गर्नुस्!

— Thagi Satark App
rajumahato.it.com
''';
  }

  static String buildAiResultShareText({
    required String situation,
    required String result,
    required List<String> redFlags,
  }) {
    final flags = redFlags.map((f) => '• $f').join('\n');
    return '''
🛡️ AI ठगी Analysis — ठगी सतर्क

📋 Situation: $situation

🔍 Result: $result

🚩 Red Flags:
$flags

⚠️ सावधान रहनुस्! यो app आफ्नो परिवारलाई पनि देखाउनुस्।

— Thagi Satark App
rajumahato.it.com
''';
  }
}

class ValidatorHelper {
  ValidatorHelper._();

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName आवश्यक छ';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'फोन नम्बर आवश्यक छ';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'सही फोन नम्बर लेख्नुस्';
    }
    return null;
  }

  static String? validateMinLength(String? value, int min) {
    if (value == null || value.length < min) {
      return 'कम्तीमा $min अक्षर लेख्नुस्';
    }
    return null;
  }
}
