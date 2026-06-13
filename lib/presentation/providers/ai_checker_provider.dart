import 'package:flutter/material.dart';
import '../../data/models/ai_response_model.dart';

enum AiCheckerState { idle, loading, result, error }

class AiCheckerProvider extends ChangeNotifier {
  AiCheckerState _state = AiCheckerState.idle;
  AiResponseModel? _result;
  String _errorMessage = '';
  final List<Map<String, String>> _chatHistory = [];

  AiCheckerState get state => _state;
  AiResponseModel? get result => _result;
  String get errorMessage => _errorMessage;
  List<Map<String, String>> get chatHistory => _chatHistory;

  // ===== OFFLINE AI ENGINE =====
  // Nepal fraud pattern database
  static const Map<String, List<String>> _fraudKeywords = {
    'foreign_employment': [
      'manpower', 'dofe', 'job abroad', 'foreign job', 'gulf', 'qatar', 'dubai',
      'malaysia', 'korea', 'japan job', 'visa job', 'agent', 'advance fee',
      'recruitment', 'bidesh', 'vaideshik', 'rojgar', 'kaam', 'salary',
      'agency', 'contract', 'passport', 'abroad', 'work permit',
      '\u0935\u093f\u0926\u0947\u0936', '\u0928\u094c\u0915\u0930\u0940',
      '\u090f\u091c\u0947\u0928\u094d\u0924', '\u0915\u093e\u092e',
      '\u0905\u0917\u094d\u0930\u093f\u092e', '\u0938\u0941\u0932\u094d\u0924\u093e\u0928',
    ],
    'online_shopping': [
      'online shopping', 'facebook sell', 'instagram buy', 'advance payment',
      'cod', 'cash on delivery', 'product', 'item', 'order', 'delivery',
      'iphone', 'mobile', 'laptop', 'cheap', 'discount', 'deal',
      '\u0905\u0928\u0932\u093e\u0907\u0928', '\u0915\u093f\u0928\u094d\u0928\u0947',
      '\u0938\u0938\u094d\u0924\u094b', '\u092e\u093e\u0932', '\u0938\u093e\u092e\u093e\u0928',
    ],
    'investment': [
      'investment', 'profit', 'return', 'interest', 'high return', 'double money',
      'scheme', 'ponzi', 'mlm', 'crypto', 'bitcoin', 'trading', 'forex',
      'guaranteed profit', 'daily profit', 'weekly return', 'cooperative',
      '\u0932\u0917\u093e\u0928\u0940', '\u092b\u093e\u0907\u0926\u093e',
      '\u092c\u094d\u092f\u093e\u091c', '\u0928\u093e\u092b\u093e',
      '\u0938\u0939\u0915\u093e\u0930\u0940', '\u0921\u0941\u092c\u094d\u092c\u093e\u0909\u0928\u0947',
    ],
    'phone_otp': [
      'otp', 'pin', 'password', 'account', 'bank call', 'verify',
      'kyc', 'update account', 'block account', 'atm', 'debit card',
      '\u092b\u094b\u0928', '\u0915\u0932', '\u092c\u0948\u0902\u0915',
      '\u0935\u0930\u093f\u092b\u093e\u0907', '\u0928\u092e\u094d\u092c\u0930',
    ],
    'fake_job': [
      'government job', 'loksewa', 'psc', 'army', 'police', 'civil service',
      'job guarantee', 'pass guarantee', 'interview', 'bribe', 'corruption',
      '\u0938\u0930\u0915\u093e\u0930\u0940 \u091c\u093e\u0917\u093f\u0930',
      '\u0932\u094b\u0915\u0938\u0947\u0935\u093e', '\u092a\u093e\u0938',
      '\u092a\u0948\u0938\u093e \u0926\u093f\u090f\u0930',
    ],
    'land_property': [
      'land', 'jagga', 'plot', 'lalpurja', 'property', 'house', 'rent',
      'fake deed', 'double sell', 'broker', 'dalal',
      '\u091c\u0917\u094d\u0917\u093e', '\u091c\u092e\u093f\u0928',
      '\u0918\u0930', '\u092d\u093e\u0921\u093e', '\u0926\u0932\u093e\u0932',
      '\u0932\u093e\u0932\u092a\u0941\u0930\u094d\u091c\u093e',
    ],
    'romance_fraud': [
      'love', 'girlfriend', 'boyfriend', 'online friend', 'facebook friend',
      'money send', 'emergency', 'sick', 'hospital', 'accident', 'gift',
      '\u092a\u094d\u0930\u0947\u092e', '\u092e\u093e\u092f\u093e',
      '\u0938\u094d\u0928\u0947\u0939', '\u092a\u0948\u0938\u093e \u092e\u093e\u0917\u094d\u092f\u094b',
    ],
    'sextortion': [
      'video call', 'naked', 'photo', 'blackmail', 'threat', 'share video',
      'intimate', 'private photo', 'screenshot', 'record',
      '\u092d\u093f\u0921\u093f\u092f\u094b', '\u092b\u094b\u091f\u094b',
      '\u092c\u094d\u0932\u094d\u092f\u093e\u0915\u092e\u0947\u0932',
      '\u0927\u092e\u0915\u0940',
    ],
    'fake_cooperative': [
      'cooperative', 'savings', 'bachat', 'deposit', 'interest high',
      'sahakari', 'committee', 'fund', 'scheme close', 'ran away',
      '\u0938\u0939\u0915\u093e\u0930\u0940', '\u092c\u091a\u0924',
      '\u0928\u093f\u0915\u094d\u0937\u0947\u092a', '\u092a\u0948\u0938\u093e \u0921\u0941\u092c\u094d\u092f\u094b',
    ],
    'phishing': [
      'link click', 'fake website', 'email', 'sms link', 'bank website',
      'login', 'credentials', 'phishing', 'qr code', 'scan pay',
      '\u0932\u093f\u0902\u0915', '\u0935\u0947\u092c\u0938\u093e\u0907\u091f',
      '\u0932\u0917\u093f\u0928', '\u0938\u094d\u0915\u094d\u092f\u093e\u0928',
    ],
    'fake_government': [
      'official', 'government officer', 'tax', 'fine', 'penalty',
      'municipality', 'ward', 'police threat', 'arrest threat',
      '\u0938\u0930\u0915\u093e\u0930\u0940', '\u091c\u0930\u093f\u092c\u093e\u0928\u093e',
      '\u0915\u0930', '\u0917\u093f\u0930\u092b\u094d\u0924\u093e\u0930',
    ],
    'loan_fraud': [
      'loan', 'karza', 'easy loan', 'instant loan', 'no collateral',
      'processing fee', 'insurance fee', 'advance fee loan',
      '\u0915\u0930\u094d\u091c\u093e', '\u0932\u094b\u0928',
      '\u092a\u094d\u0930\u094b\u0938\u0947\u0938\u093f\u0919 \u092b\u093f',
    ],
    'fake_medicine': [
      'medicine', 'cure', 'treatment', 'cancer cure', 'diabetes cure',
      'herbal', 'ayurvedic', '100% cure', 'guaranteed treatment',
      '\u0914\u0937\u0927\u093f', '\u0909\u092a\u091a\u093e\u0930',
      '\u0928\u093f\u0930\u094d\u0935\u093e\u0923',
    ],
    'lottery': [
      'lottery', 'prize', 'winner', 'congratulations', 'award',
      'lucky draw', 'gift voucher', 'tax pay first',
      '\u0932\u091f\u0930\u0940', '\u092a\u0941\u0930\u0938\u094d\u0915\u093e\u0930',
      '\u091c\u093f\u0924\u094d\u0928\u0941\u092d\u092f\u094b',
    ],
  };

  static const Map<String, Map<String, dynamic>> _fraudInfo = {
    'foreign_employment': {
      'title': '\u0935\u0948\u0926\u0947\u0936\u093f\u0915 \u0930\u094b\u091c\u0917\u093e\u0930 \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u0928\u0915\u0932\u0940 \u090f\u091c\u0947\u0928\u094d\u091f\u0932\u0947 \u0935\u093f\u0926\u0947\u0936\u092e\u093e \u0930\u093e\u092e\u094d\u0930\u094b \u091c\u093e\u0917\u093f\u0930 \u0926\u093f\u0932\u093e\u0909\u0928\u0947 \u0928\u093e\u092e\u092e\u093e \u0905\u0917\u094d\u0930\u093f\u092e \u092a\u0948\u0938\u093e \u0932\u093f\u090f\u0930 \u092d\u093e\u0917\u094d\u0928\u0947 \u0920\u0917\u0940 \u0939\u094b\u0964',
      'redFlags': [
        '\u0905\u0917\u094d\u0930\u093f\u092e \u092a\u0948\u0938\u093e \u092e\u093e\u0917\u094d\u0928\u0947',
        'DoFE \u0926\u0930\u094d\u0924\u093e \u0928\u092d\u090f\u0915\u094b \u090f\u091c\u0947\u0928\u094d\u091f',
        'Visa guarantee \u0917\u0930\u094d\u0928\u0947',
        'Contract \u0928\u0926\u093f\u0928\u0947',
      ],
      'prevention': [
        'DoFE \u092e\u093e agency verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d: dofeprovident.gov.np',
        '\u0905\u0917\u094d\u0930\u093f\u092e \u092a\u0948\u0938\u093e \u0915\u0939\u093f\u0932\u094d\u092f\u0948 \u0928\u0926\u093f\u0928\u0941\u0938\u094d',
        'Contract \u0930\u093e\u092e\u094d\u0930\u094b\u0938\u0902\u0917 \u092a\u0922\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['DoFE: 1180', 'Nepal Police: 100'],
      'law': '\u0935\u0948\u0926\u0947\u0936\u093f\u0915 \u0930\u094b\u091c\u0917\u093e\u0930 \u0910\u0928 \u0968\u0966\u0953\u0967',
    },
    'online_shopping': {
      'title': '\u0905\u0928\u0932\u093e\u0907\u0928 \u0915\u093f\u0928\u092e\u0947\u0932 \u0920\u0917\u0940',
      'risk': 'high',
      'description': 'Facebook/Instagram \u092e\u093e \u0938\u0938\u094d\u0924\u094b \u092e\u0942\u0932\u094d\u092e\u093e \u0938\u093e\u092e\u093e\u0928 \u092c\u0947\u091a\u094d\u091b\u0941 \u092d\u0928\u0947\u0930 advance \u0932\u093f\u090f\u0930 \u092d\u093e\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '\u0905\u0917\u094d\u0930\u093f\u092e \u092d\u0941\u0915\u094d\u0924\u093e\u0928\u0940 \u092e\u093e\u0917\u094d\u0928\u0947',
        'COD \u0928\u0926\u093f\u0928\u0947',
        'Review \u0928\u092d\u090f\u0915\u094b page',
        '\u0905\u0938\u094d\u0935\u093e\u092d\u093e\u0935\u093f\u0915 \u0938\u0938\u094d\u0924\u094b \u092e\u0942\u0932\u094d\u092f',
      ],
      'prevention': [
        'Cash on delivery \u092e\u093e\u0924\u094d\u0930 \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        'Page \u0915\u094b review \u0930 rating \u0939\u0947\u0930\u094d\u0928\u0941\u0938\u094d',
        'Trusted platform \u092e\u093e\u0924\u094d\u0930 \u0915\u093f\u0928\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Cyber Bureau: 1177', 'Nepal Police: 100'],
      'law': 'ETA \u0968\u0966\u0953\u0969, \u0926\u092b\u093e \u0969\u096d',
    },
    'investment': {
      'title': '\u0932\u0917\u093e\u0928\u0940 \u0930 \u092a\u094b\u0928\u094d\u091c\u0940 \u0920\u0917\u0940',
      'risk': 'critical',
      'description': '\u0909\u091a\u094d\u091a \u092c\u094d\u092f\u093e\u091c \u0935\u093e guaranteed return \u0915\u094b \u0932\u094b\u092d\u092e\u093e \u0932\u0917\u093e\u0928\u0940 \u0917\u0930\u093e\u0909\u0928\u0947 \u0930 \u092a\u091b\u093f \u092d\u093e\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'Guaranteed return \u0926\u093f\u0928\u0947',
        'NRB \u0926\u0930\u094d\u0924\u093e \u0928\u092d\u090f\u0915\u094b',
        '\u091a\u093e\u0901\u0921\u094b \u0927\u0928\u0940 \u0939\u0941\u0928\u0947 \u0932\u094b\u092d',
        'MLM/Ponzi \u0938\u0902\u0930\u091a\u0928\u093e',
      ],
      'prevention': [
        'NRB \u0926\u0930\u094d\u0924\u093e \u092d\u090f\u0915\u094b \u0938\u0902\u0938\u094d\u0925\u093e\u092e\u093e \u092e\u093e\u0924\u094d\u0930',
        'Guaranteed return \u0935\u093f\u0936\u094d\u0935\u093e\u0938 \u0928\u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        '\u0935\u093f\u0936\u0947\u0937\u091c\u094d\u091e\u0938\u0902\u0917 \u0938\u0932\u093e\u0939 \u0932\u093f\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['NRB: 1414', 'Nepal Police: 100'],
      'law': '\u0938\u0941\u0930\u0915\u094d\u0937\u093e \u0935\u093f\u0927\u0947\u092f\u0915 \u0968\u0966\u0953\u0969',
    },
    'phone_otp': {
      'title': '\u092b\u094b\u0928 \u0915\u0932/OTP \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u092c\u0948\u0902\u0915 \u0935\u093e \u0938\u0930\u0915\u093e\u0930\u0940 \u0915\u0930\u094d\u092e\u091a\u093e\u0930\u0940 \u092d\u0928\u094d\u0926\u0948 OTP, PIN \u092e\u093e\u0917\u0940 \u0916\u093e\u0924\u093e \u0916\u093e\u0932\u0940 \u0917\u0930\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '\u092b\u094b\u0928\u092e\u093e OTP \u092e\u093e\u0917\u094d\u0928\u0947',
        '\u0905\u0928\u091c\u093e\u0928 \u0928\u092e\u094d\u092c\u0930\u092c\u093e\u091f \u0915\u0932',
        '\u0916\u093e\u0924\u093e block \u0939\u0941\u0928\u094d\u091b \u092d\u0928\u094d\u0928\u0947',
        '\u0924\u0941\u0930\u0928\u094d\u0924 verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d \u092d\u0928\u094d\u0928\u0947',
      ],
      'prevention': [
        'OTP \u0915\u0938\u0948\u0932\u093e\u0908 \u0928\u0926\u093f\u0928\u0941\u0938\u094d',
        '\u092c\u0948\u0902\u0915\u0915\u094b official number \u092e\u093e callback \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        'PIN/Password share \u0928\u0917\u0930\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Cyber Bureau: 1177', 'Nepal Police: 100'],
      'law': 'ETA \u0968\u0966\u0953\u0969, \u0926\u092b\u093e \u0969\u096d',
    },
    'fake_job': {
      'title': '\u0928\u0915\u0932\u0940 \u0938\u0930\u0915\u093e\u0930\u0940 \u091c\u093e\u0917\u093f\u0930 \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u0938\u0930\u0915\u093e\u0930\u0940 \u091c\u093e\u0917\u093f\u0930 \u0926\u093f\u0932\u093e\u0909\u0928\u094d\u091b\u0941 \u092d\u0928\u094d\u0926\u0948 \u0932\u093e\u0916\u094c\u0902 \u0920\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '\u092a\u0948\u0938\u093e\u092e\u093e pass guarantee',
        'Official channel \u0928\u092d\u090f\u0915\u094b',
        '\u0905\u0917\u094d\u0930\u093f\u092e \u092a\u0948\u0938\u093e \u092e\u093e\u0917\u094d\u0928\u0947',
      ],
      'prevention': [
        '\u0938\u0930\u0915\u093e\u0930\u0940 \u091c\u093e\u0917\u093f\u0930\u092e\u093e \u092a\u0948\u0938\u093e \u0932\u093e\u0917\u094d\u0926\u0948\u0928',
        'PSC \u0935\u0947\u092c\u0938\u093e\u0907\u091f\u092e\u093e\u0924\u094d\u0930 apply \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        'CIAA \u092e\u093e report \u0917\u0930\u094d\u0928\u0941\u0938\u094d: 1113',
      ],
      'helplines': ['CIAA: 1113', 'PSC: 01-4770680'],
      'law': '\u092e\u0941\u0932\u0941\u0915\u0940 \u092b\u094c\u091c\u0926\u093e\u0930\u0940 \u0938\u0902\u0939\u093f\u0924\u093e',
    },
    'land_property': {
      'title': '\u091c\u0917\u094d\u0917\u093e \u091c\u092e\u093f\u0928 \u0920\u0917\u0940',
      'risk': 'critical',
      'description': '\u0928\u0915\u0932\u0940 \u0932\u093e\u0932\u092a\u0941\u0930\u094d\u091c\u093e \u092c\u0928\u093e\u0908 \u091c\u0917\u094d\u0917\u093e \u092c\u0947\u091a\u094d\u0928\u0947 \u0935\u093e \u090f\u0915\u0948 \u091c\u0917\u094d\u0917\u093e \u0926\u0941\u0908 \u091c\u0928\u093e\u0932\u093e\u0908 \u092c\u0947\u091a\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '\u0928\u093e\u092a\u0940 verify \u0928\u0917\u0930\u0940 \u0915\u093f\u0928\u094d\u0928 \u0926\u092c\u093e\u092c',
        '\u091a\u093e\u0901\u0921\u094b deal \u0917\u0930\u094d\u0928 \u092a\u094d\u0930\u0947\u0938\u0930',
        '\u0928\u0915\u0932\u0940 \u0932\u093e\u0932\u092a\u0941\u0930\u094d\u091c\u093e',
      ],
      'prevention': [
        '\u0928\u093e\u092a\u0940\u092e\u093e verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        '\u0935\u0915\u093f\u0932 \u0930\u093e\u0916\u094d\u0928\u0941\u0938\u094d',
        'Bank transfer \u092e\u093e\u0924\u094d\u0930 \u092d\u0941\u0915\u094d\u0924\u093e\u0928\u0940 \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Nepal Police: 100', 'Legal Aid: 01-4221740'],
      'law': '\u092e\u0941\u0932\u0941\u0915\u0940 \u092b\u094c\u091c\u0926\u093e\u0930\u0940 \u0938\u0902\u0939\u093f\u0924\u093e',
    },
    'romance_fraud': {
      'title': '\u092a\u094d\u0930\u0947\u092e \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u0938\u093e\u092e\u093e\u091c\u093f\u0915 \u0938\u091e\u094d\u091c\u093e\u0932\u092e\u093e \u0928\u0915\u0932\u0940 profile \u092c\u0928\u093e\u0908 \u0935\u093f\u0936\u094d\u0935\u093e\u0938 \u091c\u093f\u0924\u0947\u0930 \u092a\u0948\u0938\u093e \u0920\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'Video call \u0928\u0917\u0930\u094d\u0928\u0947',
        'Emergency \u092e\u093e \u092a\u0948\u0938\u093e \u092e\u093e\u0917\u094d\u0928\u0947',
        '\u091c\u0932\u094d\u0926\u0940 \u092e\u093e\u092f\u093e \u0926\u0947\u0916\u093e\u0909\u0928\u0947',
      ],
      'prevention': [
        'Video call \u092e\u093e face verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        '\u0905\u0928\u091c\u093e\u0928 \u0935\u094d\u092f\u0915\u094d\u0924\u093f\u0932\u093e\u0908 \u092a\u0948\u0938\u093e \u0928\u092a\u0920\u093e\u0909\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Cyber Bureau: 1177', 'Nepal Police: 100'],
      'law': '\u092e\u0941\u0932\u0941\u0915\u0940 \u092b\u094c\u091c\u0926\u093e\u0930\u0940 \u0938\u0902\u0939\u093f\u0924\u093e',
    },
    'sextortion': {
      'title': 'Sextortion \u0920\u0917\u0940',
      'risk': 'critical',
      'description': 'Video call \u092e\u093e \u0905\u0936\u094d\u0932\u093f\u0932 content record \u0917\u0930\u0940 blackmail \u0917\u0930\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'Unknown \u0938\u0902\u0917 video call',
        'Screen record \u0917\u0930\u094d\u0928\u0947',
        '\u092a\u0948\u0938\u093e \u0928\u0926\u093f\u090f photo/video share \u0917\u0930\u094d\u0928\u0947 \u0927\u092e\u0915\u0940',
      ],
      'prevention': [
        'Unknown \u0938\u0902\u0917 video call \u0928\u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        '\u092a\u0948\u0938\u093e \u0928\u0926\u093f\u0928\u0941\u0938\u094d — \u092a\u0948\u0938\u093e \u0926\u093f\u090f \u0930 \u092c\u0922\u094d\u0928\u0947 \u091b\u0948\u0928',
        'Cyber Bureau \u092e\u093e report \u0917\u0930\u094d\u0928\u0941\u0938\u094d: 1177',
      ],
      'helplines': ['Cyber Bureau: 1177', '\u092e\u0939\u093f\u0932\u093e \u0906\u092f\u094b\u0917: 1145'],
      'law': 'ETA \u0968\u0966\u0953\u0969, \u0926\u092b\u093e \u0969\u096d',
    },
    'fake_cooperative': {
      'title': '\u0928\u0915\u0932\u0940 \u0938\u0939\u0915\u093e\u0930\u0940 \u0920\u0917\u0940',
      'risk': 'critical',
      'description': 'Fake cooperative \u092e\u093e \u092a\u0948\u0938\u093e \u0930\u093e\u0916\u093f \u0920\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '20%+ \u092e\u093e\u0938\u093f\u0915 \u092c\u094d\u092f\u093e\u091c',
        'DoC \u0926\u0930\u094d\u0924\u093e \u0928\u092d\u090f\u0915\u094b',
        'Audit report \u0928\u0926\u093f\u0928\u0947',
      ],
      'prevention': [
        'DoC \u092e\u093e verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d: doc.gov.np',
        'Audit report \u092e\u093e\u0917\u094d\u0928\u0941\u0938\u094d',
        '20%+ interest = \u0920\u0917\u0940\u0915\u094b \u0938\u0902\u0915\u0947\u0924',
      ],
      'helplines': ['DoC: 01-4229032', 'Nepal Police: 100'],
      'law': '\u0938\u0939\u0915\u093e\u0930\u0940 \u0910\u0928 \u0968\u0966\u0967\u0969',
    },
    'phishing': {
      'title': 'Phishing/QR Code \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u0928\u0915\u0932\u0940 link \u0935\u093e QR code \u092e\u093e\u0930\u094d\u092b\u0924 \u0935\u094d\u092f\u0915\u094d\u0924\u093f\u0917\u0924 \u091c\u093e\u0928\u0915\u093e\u0930\u0940 \u091a\u094b\u0930\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'Unknown link click \u0917\u0930\u094d\u0928 \u092d\u0928\u094d\u0928\u0947',
        'Receive \u0917\u0930\u094d\u0928 QR scan \u0917\u0930\u094d\u0928 \u092d\u0928\u094d\u0928\u0947',
        'Fake bank website',
      ],
      'prevention': [
        'Unknown link click \u0928\u0917\u0930\u094d\u0928\u0941\u0938\u094d',
        'QR scan = send, receive \u0939\u094b\u0907\u0928',
        'Two-factor authentication \u0930\u093e\u0916\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Cyber Bureau: 1177', 'Nepal Police: 100'],
      'law': 'ETA \u0968\u0966\u0953\u0969',
    },
    'loan_fraud': {
      'title': '\u0915\u0930\u094d\u091c\u093e \u0920\u0917\u0940',
      'risk': 'high',
      'description': 'Easy loan \u0915\u094b \u0928\u093e\u092e\u092e\u093e processing fee \u0932\u093f\u090f\u0930 \u0920\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'Processing fee \u092e\u093e\u0917\u094d\u0928\u0947',
        'NRB \u0926\u0930\u094d\u0924\u093e \u0928\u092d\u090f\u0915\u094b',
        'Collateral \u0928\u091a\u093e\u0939\u093f\u0928\u0947 loan',
      ],
      'prevention': [
        'NRB \u0926\u0930\u094d\u0924\u093e \u092d\u090f\u0915\u094b \u0938\u0902\u0938\u094d\u0925\u093e\u092e\u093e\u0924\u094d\u0930',
        'Processing fee \u0928\u0926\u093f\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['NRB: 1414', 'Nepal Police: 100'],
      'law': '\u092c\u0948\u0902\u0915\u093f\u0902\u0917 \u0905\u0927\u093f\u0928\u093f\u092e',
    },
    'lottery': {
      'title': '\u0928\u0915\u0932\u0940 \u0932\u091f\u0930\u0940/\u092a\u0941\u0930\u0938\u094d\u0915\u093e\u0930 \u0920\u0917\u0940',
      'risk': 'medium',
      'description': '\u0928\u0916\u0947\u0932\u0947\u0915\u094b \u0932\u091f\u0930\u0940 \u091c\u093f\u0924\u094d\u0928\u0941\u092d\u092f\u094b \u092d\u0928\u0940 tax/fee \u092e\u093e\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '\u0928\u0916\u0947\u0932\u0947\u0915\u094b \u0932\u091f\u0930\u0940',
        'Tax/processing fee \u092e\u093e\u0917\u094d\u0928\u0947',
        'Unknown number \u092c\u093e\u091f \u0915\u0932',
      ],
      'prevention': [
        '\u0928\u0916\u0947\u0932\u0947\u0915\u094b \u0932\u091f\u0930\u0940 \u091c\u093f\u0924\u094d\u0928 \u0905\u0938\u092e\u094d\u092d\u0935',
        'Ignore \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['Cyber Bureau: 1177', 'Nepal Police: 100'],
      'law': 'ETA \u0968\u0966\u0953\u0969',
    },
    'fake_government': {
      'title': '\u0928\u0915\u0932\u0940 \u0938\u0930\u0915\u093e\u0930\u0940 \u0915\u0930\u094d\u092e\u091a\u093e\u0930\u0940 \u0920\u0917\u0940',
      'risk': 'high',
      'description': '\u0938\u0930\u0915\u093e\u0930\u0940 \u0915\u0930\u094d\u092e\u091a\u093e\u0930\u0940 \u092d\u0928\u094d\u0926\u0948 \u0915\u0930, \u091c\u0930\u093f\u092c\u093e\u0928\u093e \u0935\u093e \u0938\u0947\u0935\u093e \u0936\u0941\u0932\u094d\u0915\u0915\u094b \u0928\u093e\u092e\u092e\u093e \u092a\u0948\u0938\u093e \u0920\u0917\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        'ID card \u0928\u0926\u0947\u0916\u093e\u0909\u0928\u0947',
        'Cash \u092e\u093e cash \u092e\u093e\u0917\u094d\u0928\u0947',
        'Receipt \u0928\u0926\u093f\u0928\u0947',
      ],
      'prevention': [
        'Official ID \u0939\u0947\u0930\u094d\u0928\u0941\u0938\u094d',
        'Receipt \u0932\u093f\u0928\u0941\u0938\u094d',
        'CIAA: 1113 \u092e\u093e report \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['CIAA: 1113', 'Nepal Police: 100'],
      'law': '\u092e\u0941\u0932\u0941\u0915\u0940 \u092b\u094c\u091c\u0926\u093e\u0930\u0940 \u0938\u0902\u0939\u093f\u0924\u093e',
    },
    'fake_medicine': {
      'title': '\u0928\u0915\u0932\u0940 \u0914\u0937\u0927\u093f \u0920\u0917\u0940',
      'risk': 'critical',
      'description': '\u0928\u0915\u0932\u0940 \u0914\u0937\u0927\u093f \u092c\u0947\u091a\u0940 \u091c\u0940\u0935\u0928 \u0916\u0924\u0930\u093e\u092e\u093e \u092a\u093e\u0930\u094d\u0928\u0947 \u0920\u0917\u0940\u0964',
      'redFlags': [
        '100% \u0928\u093f\u0930\u094d\u0935\u093e\u0923 \u0926\u093e\u092c\u0940',
        'Prescription \u0928\u091a\u093e\u0939\u093f\u0928\u0947',
        'Online \u092e\u093e\u0924\u094d\u0930 \u092c\u0947\u091a\u094d\u0928\u0947',
      ],
      'prevention': [
        '\u0926\u0930\u094d\u0924\u093e \u092d\u090f\u0915\u094b pharmacy\u092e\u093e\u0924\u094d\u0930',
        'Doctor prescription \u0932\u093f\u0928\u0941\u0938\u094d',
        'DDA \u0926\u0930\u094d\u0924\u093e verify \u0917\u0930\u094d\u0928\u0941\u0938\u094d',
      ],
      'helplines': ['DDA: 1800-01-8899', 'Nepal Police: 100'],
      'law': '\u0914\u0937\u0927\u093f \u0905\u0927\u093f\u0928\u093f\u092e',
    },
  };

  // ===== ANALYZE FUNCTION =====
  String _detectFraudType(String text) {
    final lower = text.toLowerCase();
    int maxScore = 0;
    String detected = 'unknown';

    _fraudKeywords.forEach((fraudType, keywords) {
      int score = 0;
      for (final keyword in keywords) {
        if (lower.contains(keyword.toLowerCase())) score++;
      }
      if (score > maxScore) {
        maxScore = score;
        detected = fraudType;
      }
    });
    return maxScore > 0 ? detected : 'unknown';
  }

  int _calculateRiskScore(String text, String fraudType) {
    final lower = text.toLowerCase();
    int score = 0;
    final keywords = _fraudKeywords[fraudType] ?? [];
    for (final k in keywords) {
      if (lower.contains(k.toLowerCase())) score += 10;
    }
    if (lower.contains('paisa') || lower.contains('\u092a\u0948\u0938\u093e')) score += 15;
    if (lower.contains('advance') || lower.contains('\u0905\u0917\u094d\u0930\u093f\u092e')) score += 20;
    if (lower.contains('guarantee') || lower.contains('\u0917\u094d\u092f\u093e\u0930\u0947\u0928\u094d\u091f\u0940')) score += 20;
    if (lower.contains('urgent') || lower.contains('\u0924\u0941\u0930\u0928\u094d\u0924')) score += 10;
    return score.clamp(0, 100);
  }

  Future<void> checkFraud(String situation) async {
    if (situation.trim().isEmpty) return;

    _chatHistory.add({'role': 'user', 'content': situation});
    _state = AiCheckerState.loading;
    _errorMessage = '';
    notifyListeners();

    // Simulate AI thinking
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      final fraudType = _detectFraudType(situation);
      final riskScore = _calculateRiskScore(situation, fraudType);
      final info = _fraudInfo[fraudType];

      String resultNp;
      String severity;
      List<String> redFlags;
      List<String> prevention;
      List<String> helplines;
      String law;
      bool isFraud;

      if (fraudType == 'unknown' || info == null) {
        isFraud = false;
        severity = 'low';
        resultNp = '\u0924\u092a\u093e\u0908\u0902\u0932\u0947 \u0935\u0930\u094d\u0923\u0928 \u0917\u0930\u0947\u0915\u094b situation \u092e\u093e \u0938\u094d\u092a\u0937\u094d\u091f \u0920\u0917\u0940\u0915\u094b \u0938\u0902\u0915\u0947\u0924 \u092d\u0947\u091f\u093f\u090f\u0928\u0964 \u0924\u0930 \u0938\u0924\u0930\u094d\u0915 \u0930\u0939\u094d\u0928\u0941\u0938\u094d\u0964';
        redFlags = ['\u0915\u0941\u0928\u0948 \u092a\u0928\u093f \u0905\u0917\u094d\u0930\u093f\u092e \u092a\u0948\u0938\u093e \u0928\u0926\u093f\u0928\u0941\u0938\u094d', '\u0936\u0902\u0915\u093e \u0932\u093e\u0917\u0947 Nepal Police: 100 \u092e\u093e call \u0917\u0930\u094d\u0928\u0941\u0938\u094d'];
        prevention = ['\u0936\u0902\u0915\u093e\u0938\u094d\u092a\u0926 \u0915\u0941\u0930\u093e\u092e\u093e \u0935\u093f\u0936\u094d\u0935\u093e\u0938 \u0928\u0917\u0930\u094d\u0928\u0941\u0938\u094d'];
        helplines = ['Nepal Police: 100', 'Cyber Bureau: 1177'];
        law = '';
      } else {
        isFraud = riskScore > 20;
        severity = info['risk'] as String;
        resultNp = isFraud
            ? '\u26a0\ufe0f \u0938\u0924\u0930\u094d\u0915! \u0924\u092a\u093e\u0908\u0902\u0932\u0947 \u0935\u0930\u094d\u0923\u0928 \u0917\u0930\u0947\u0915\u094b situation ${info['title']} \u091c\u0938\u094d\u0924\u094b \u0926\u0947\u0916\u093f\u0928\u094d\u091b\u0964 \u092f\u094b \u0920\u0917\u0940 \u0939\u094b\u0928 \u0938\u0915\u094d\u091b\u0964'
            : '\u2705 \u0924\u092a\u093e\u0908\u0902\u0915\u094b situation \u092e\u093e \u0926\u0947\u0916\u093f\u0902\u0926\u093e ${info['title']} \u0915\u094b \u0915\u0941\u0928\u0948 \u0938\u094d\u092a\u0937\u094d\u091f \u0938\u0902\u0915\u0947\u0924 \u0926\u0947\u0916\u093f\u090f\u0928\u0964 \u0924\u0930 \u0938\u0924\u0930\u094d\u0915 \u0930\u0939\u094d\u0928\u0941\u0938\u094d\u0964';
        redFlags = List<String>.from(info['redFlags'] as List);
        prevention = List<String>.from(info['prevention'] as List);
        helplines = List<String>.from(info['helplines'] as List);
        law = info['law'] as String;
      }

     _result = AiResponseModel(
        isFraud: isFraud,
        fraudType: fraudType,
        riskScore: riskScore,
        confidenceScore: (riskScore * 0.8 + 20).round().clamp(30, 99),
        severity: severity,
        resultNp: resultNp,
        fraudTitle: info != null ? info['title'] as String : 'अज्ञात',
        fraudDescription: info != null ? info['description'] as String : '',
        redFlags: redFlags,
        preventionSteps: prevention,
        helplines: helplines,
        lawReference: law,
        detectedPatterns: _getDetectedPatterns(situation, fraudType),
        followUpQuestions: _getFollowUpQuestions(fraudType),
        advice: _getAdvice(fraudType, isFraud),
      );
      
      _chatHistory.add({'role': 'assistant', 'content': resultNp});
      _state = AiCheckerState.result;
    } catch (e) {
      _errorMessage = 'विश्लेषण गर्न सकिएन। पुनः प्रयास गर्नुस्।';
      _state = AiCheckerState.error;
    }
    notifyListeners();
  }

  List<String> _getDetectedPatterns(String text, String fraudType) {
    final lower = text.toLowerCase();
    final keywords = _fraudKeywords[fraudType] ?? [];
    final detected = <String>[];
    for (final k in keywords) {
      if (lower.contains(k.toLowerCase()) && detected.length < 5) {
        detected.add(k);
      }
    }
    return detected;
  }
List<String> _getFollowUpQuestions(String fraudType) {
    switch (fraudType) {
      case 'foreign_employment':
        return [
          'Agency को DoFE registration number के हो?',
          'Contract मा तलब कति लेखिएको छ?',
          'Advance कति माग्यो?',
        ];
      case 'investment':
        return [
          'Monthly कति % return भन्यो?',
          'Company को NRB registration छ?',
          'पैसा कहाँ transfer गर्नुस् भन्यो?',
        ];
      case 'online_shopping':
        return [
          'COD option दियो कि अग्रिम मात्र?',
          'Page कति दिन पुरानो छ?',
          'Review कस्तो छ?',
        ];
      case 'phone_otp':
        return [
          'Call कुन number बाट आयो?',
          'OTP मागेर के गर्छु भन्यो?',
          'Account block हुन्छ भन्यो?',
        ];
      case 'sextortion':
        return [
          'कति पैसा माग्यो?',
          'कुन platform बाट contact भयो?',
          'Video/photo लिइसक्यो भन्यो?',
        ];
      default:
        return [
          'पैसा कसरी पठाउनुस् भन्यो?',
          'कुनै document माग्यो?',
          'अग्रिम भुक्तानी माग्यो?',
        ];
    }
  }

  String _getAdvice(String fraudType, bool isFraud) {
    if (!isFraud) return 'अहिले स्पष्ट ठगी देखिएन तर सतर्क रहनुस्। कुनै पनि अग्रिम पैसा नदिनुस्।';
    switch (fraudType) {
      case 'foreign_employment': return 'तुरुन्त DoFE मा agency verify गर्नुस्। पैसा नदिनुस्। DoFE: 1180';
      case 'investment': return 'पैसा नलगाउनुस्। NRB: 1414 मा report गर्नुस्।';
      case 'online_shopping': return 'अग्रिम पैसा नदिनुस्। COD मात्र। Cyber Bureau: 1177';
      case 'phone_otp': return 'OTP कसैलाई नदिनुस्। Bank मा तुरुन्त call गर्नुस्।';
      case 'sextortion': return 'पैसा नदिनुस्। Cyber Bureau: 1177 मा तुरुन्त report गर्नुस्।';
      default: return 'तुरुन्त Nepal Police: 100 वा Cyber Bureau: 1177 मा call गर्नुस्।';
    }
  }
  void reset() {
    _state = AiCheckerState.idle;
    _result = null;
    _errorMessage = '';
    _chatHistory.clear();
    notifyListeners();
  }
}
