import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/ai_response_model.dart';

class DeepSeekService {
  static const String _apiKey = 'sk-025c3fcf40244dadb27cbfb7e631d617';
  static const String _baseUrl = 'https://api.deepseek.com/chat/completions';
  static const String _model = 'deepseek-chat';

  static const String _systemPrompt = '''तपाईं Nepal को fraud detection AI हुनुहुन्छ। 
User ले describe गरेको situation analyze गरेर ठगी हो वा होइन भन्नुहोस्।
तपाईंले STRICTLY यो JSON format मा मात्र जवाफ दिनुहोस्, अरू केही नलेख्नुस्:

{
  "is_fraud": true/false,
  "is_warning": true/false,
  "is_safe": true/false,
  "result_np": "एक लाइन नेपालीमा verdict",
  "analysis_np": "२-३ लाइन नेपालीमा analysis",
  "detected_red_flags": ["red flag 1", "red flag 2"],
  "action_steps": ["step 1", "step 2", "step 3"],
  "fraud_type": "fraud type in English",
  "helpline_number": "relevant helpline number"
}

Rules:
- is_fraud, is_warning, is_safe मध्ये एउटा मात्र true हुनुपर्छ
- Helpline: DoFE=1180, Police=100, NRB=1414, Cyber=1177, Women=1145
- सबै नेपाली text Devanagari मा लेख्नुस्
- JSON मात्र return गर्नुस्, कुनै explanation नदिनुस्''';

  Future<AiResponseModel> analyzefraud(String situation) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'system', 'content': _systemPrompt},
          {'role': 'user', 'content': situation},
        ],
        'max_tokens': 800,
        'temperature': 0.3,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'] as String;
      final cleaned = content.replaceAll('json', '').replaceAll('', '').trim();
      final json = jsonDecode(cleaned) as Map<String, dynamic>;
      return AiResponseModel.fromJson(json);
    } else if (response.statusCode == 402) {
      throw Exception('INSUFFICIENT_BALANCE');
    } else {
      throw Exception('API_ERROR_${response.statusCode}');
    }
  }
}
