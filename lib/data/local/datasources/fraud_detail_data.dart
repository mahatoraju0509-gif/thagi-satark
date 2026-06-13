import 'package:flutter/material.dart';

class FraudLayerContent {
  final List<String> howItHappens;
  final List<String> psychologyReasons;
  final List<PreventionDetail> preventionDetails;
  final RealCaseData realCase;
  final List<VerifyToolData> verifyTools;
  final LawData lawDetails;

  const FraudLayerContent({
    required this.howItHappens,
    required this.psychologyReasons,
    required this.preventionDetails,
    required this.realCase,
    required this.verifyTools,
    required this.lawDetails,
  });
}

class PreventionDetail {
  final String step;
  final String detail;
  final String icon;
  const PreventionDetail({required this.step, required this.detail, required this.icon});
}

class RealCaseData {
  final String victimProfile;
  final String story;
  final String lesson;
  final String amountLost;
  const RealCaseData({required this.victimProfile, required this.story, required this.lesson, required this.amountLost});
}

class VerifyToolData {
  final String name;
  final String url;
  final String description;
  final String icon;
  const VerifyToolData({required this.name, required this.url, required this.description, required this.icon});
}

class LawData {
  final String mainLaw;
  final String punishment;
  final List<String> yourRights;
  final List<String> complaintProcess;
  const LawData({required this.mainLaw, required this.punishment, required this.yourRights, required this.complaintProcess});
}

class FraudDetailData {
  static FraudLayerContent getContent(String fraudId) {
    return _allData[fraudId] ?? _defaultContent;
  }

  static const FraudLayerContent _defaultContent = FraudLayerContent(
    howItHappens: [
      'Step 1 — पहिलो सम्पर्क — Facebook, phone, वा चिनजान मार्फत',
      'Step 2 — विश्वास जित्ने — राम्रो offer, fake documents देखाउने',
      'Step 3 — Pressure दिने — "जल्दी गर्नुस्, अवसर जान्छ"',
      'Step 4 — पैसा माग्ने — Advance, registration fee',
      'Step 5 — भाग्ने — पैसा लिएपछि contact बन्द गर्ने',
    ],
    psychologyReasons: [
      'आर्थिक बाध्यता — गरिबी र बेरोजगारी',
      'चिनजानको भरोसा — आफ्नै मान्छेले गर्छ',
      'लोभ — धेरै पैसाको आशा',
      'जानकारीको अभाव — verify गर्न थाहा नहुनु',
      'Time pressure — "अहिले नगरे हुँदैन"',
    ],
    preventionDetails: [
      PreventionDetail(step: 'Verify गर्नुस्', detail: 'कुनै पनि offer वा person लाई official channel मार्फत verify गर्नुस्।', icon: 'verify'),
      PreventionDetail(step: 'Advance पैसा नदिनुस्', detail: 'कुनै पनि advance payment नगर्नुस्।', icon: 'money'),
      PreventionDetail(step: 'परिवारसँग सल्लाह गर्नुस्', detail: 'ठूलो निर्णय गर्नु अघि परिवारसँग सल्लाह गर्नुस्।', icon: 'family'),
    ],
    realCase: RealCaseData(
      victimProfile: 'पीडित, ३०-४० वर्ष',
      story: 'एउटा अपरिचित व्यक्तिले राम्रो अवसरको लोभ देखाएर पैसा लियो।',
      lesson: 'Verify नगरी पैसा नदिनु। परिवारसँग सल्लाह गर्नु।',
      amountLost: 'Rs. ५०,०००–५,००,०००',
    ),
    verifyTools: [
      VerifyToolData(name: 'Nepal Police', url: 'nepalpolice.gov.np', description: 'Complaint दर्ता गर्नुस्', icon: 'police'),
      VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud report', icon: 'cyber'),
    ],
    lawDetails: LawData(
      mainLaw: 'मुलुकी अपराध संहिता २०७४',
      punishment: '३ देखि ७ वर्षसम्म कैद र जरिबाना',
      yourRights: [
        'Complaint दर्ता गर्ने अधिकार',
        'कानुनी सहायता पाउने अधिकार',
        'Compensation माग्ने अधिकार',
      ],
      complaintProcess: [
        'नजिकको प्रहरी कार्यालयमा जानुस्',
        'FIR दर्ता गर्नुस्',
        'सबै प्रमाण सुरक्षित राख्नुस्',
        'कानुनी सहायता लिनुस्',
      ],
    ),
  );

  static final Map<String, FraudLayerContent> _allData = {
    'fraud_001': FraudLayerContent(
      howItHappens: [
        'Step 1 — Facebook, Viber वा चिनजान मार्फत "राम्रो job" को offer आउँछ',
        'Step 2 — Fake company ID, fake offer letter देखाएर विश्वास जिताउँछ',
        'Step 3 — "Visa processing", "Medical fee", "Training fee" भनी पैसा माग्छ',
        'Step 4 — DoFE registration नभएको agency बाट कागजात बनाउँछ',
        'Step 5 — पैसा लिएपछि contact बन्द गर्छ वा गलत देशमा पठाउँछ',
      ],
      psychologyReasons: [
        'विदेशमा राम्रो कमाइको सपना — धेरै नेपालीको चाहना',
        'परिवारको आर्थिक बोझ घटाउने इच्छा',
        'चिनजानको agent भए झन् विश्वास गर्छन्',
        '"सबै गाउँलेले गए, म किन नजाने" भन्ने सामाजिक दबाब',
        'DoFE registration check गर्न थाहा नहुनु',
      ],
      preventionDetails: [
        PreventionDetail(step: 'DoFE website मा verify गर्नुस्', detail: 'dofeprovident.gov.np मा गएर agency को license number check गर्नुस्। License नभएको agency बाट कहिल्यै काम नगर्नुस्।', icon: 'verify'),
        PreventionDetail(step: 'कुनै पनि advance पैसा नदिनुस्', detail: 'वैध agency ले कहिल्यै advance पैसा माग्दैन। Visa fee Embassy मा आफैं तिर्नुस्।', icon: 'money'),
        PreventionDetail(step: 'Contract राम्रोसँग पढ्नुस्', detail: 'Job contract मा salary, working hours, accommodation, र return ticket को कुरा स्पष्ट भए मात्र sign गर्नुस्।', icon: 'document'),
        PreventionDetail(step: 'परिवारलाई पूरा जानकारी दिनुस्', detail: 'जाने देश, company, agent को नाम र नम्बर परिवारसँग राख्नुस्। Embassy को नम्बर पनि save गर्नुस्।', icon: 'family'),
        PreventionDetail(step: 'DoFE Hotline: 1180 मा सोध्नुस्', detail: 'कुनै पनि agency बारे शंका लागे DoFE को toll-free number 1180 मा call गरेर verify गर्नुस्।', icon: 'call'),
      ],
      realCase: RealCaseData(
        victimProfile: 'सुनिता (नाम परिवर्तित), २४ वर्ष, सर्लाही',
        story: 'गाउँको एक जनाले "Malaysia मा factory job छ, Rs.80,000 दिए Visa लाइदिन्छु" भन्यो। सुनिताले बिक्री गरेको खेतको पैसाबाट Rs.80,000 दियो। Agent ले Visa नआएको भन्दै अर्को Rs.30,000 माग्यो। पैसा दिएपछि agent को phone बन्द भयो।',
        lesson: 'DoFE registered agency मात्र trust गर्नुस्। Advance पैसा दिनु भनेको ठगाउनु हो।',
        amountLost: 'Rs. १,१०,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'DoFE', url: 'dofeprovident.gov.np', description: 'Agency license verify', icon: 'govt'),
        VerifyToolData(name: 'DoFE Hotline', url: '1180', description: 'Toll-free, agency बारे सोध्नुस्', icon: 'call'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'Complaint दर्ता', icon: 'police'),
        VerifyToolData(name: 'Embassy', url: 'mofa.gov.np', description: 'Embassy verify', icon: 'embassy'),
      ],
      lawDetails: LawData(
        mainLaw: 'वैदेशिक रोजगार ऐन २०६४, दफा ४२',
        punishment: '५ देखि १० वर्षसम्म कैद र Rs. ५०,०००–५,००,००० जरिबाना',
        yourRights: ['DoFE मा निःशुल्क complaint दर्ता गर्ने अधिकार', 'ठगिएको रकम फिर्ता माग्ने अधिकार', 'Agent को license रद्द गराउने अधिकार'],
        complaintProcess: ['DoFE कार्यालयमा जानुस्', 'Agent को नाम, receipt सहित complaint दिनुस्', 'नजिकको प्रहरीमा FIR दर्ता गर्नुस्', 'Legal aid: 01-4268316'],
      ),
    ),
    'fraud_002': FraudLayerContent(
      howItHappens: [
        'Step 1 — Facebook वा Instagram मा "सस्तो iPhone/Gold" को post देखिन्छ',
        'Step 2 — Chat मा "Original product, half price" भन्छ',
        'Step 3 — "Cash on delivery छैन, Esewa मा पठाउनुस्" भन्छ',
        'Step 4 — Advance पैसा पाएपछि product नपठाई block गर्छ',
        'Step 5 — Profile delete गरेर नयाँ page बनाउँछ',
      ],
      psychologyReasons: [
        'सस्तोमा राम्रो सामान पाउने लोभ',
        'Facebook page मा धेरै likes र fake reviews देखेर विश्वास',
        'Online shopping को बढ्दो trend',
        'Cash on delivery माग्दा "Extra charge" भनी discourage गर्छ',
        'Urgency — "Stock सकिन्छ, अहिले नै order गर्नुस्"',
      ],
      preventionDetails: [
        PreventionDetail(step: 'Cash on Delivery मात्र', detail: 'Online किन्दा सधैं COD option माग्नुस्। COD नदिने seller बाट कहिल्यै किन्नुस् नगर्नुस्।', icon: 'money'),
        PreventionDetail(step: 'Page history verify गर्नुस्', detail: 'Facebook page "Page transparency" मा click गरेर page कहिले बनेको हो हेर्नुस्। नयाँ page बाट किन्न सतर्क।', icon: 'verify'),
        PreventionDetail(step: 'Google मा seller search गर्नुस्', detail: 'Seller को नाम + "scam" लेखेर Google search गर्नुस्।', icon: 'search'),
        PreventionDetail(step: 'बजार मूल्यभन्दा ५०%+ सस्तो = ठगी', detail: 'Real product बजार मूल्यमा नै बिक्छ। धेरै सस्तो भए नक्कली वा ठगी हो।', icon: 'warning'),
        PreventionDetail(step: 'Video call मा product देखाउन भन्नुस्', detail: 'किन्नु अघि video call गरेर product live देखाउन भन्नुस्।', icon: 'call'),
      ],
      realCase: RealCaseData(
        victimProfile: 'राजन (नाम परिवर्तित), १९ वर्ष, काठमाडौं',
        story: 'Facebook मा "iPhone 15 Pro — Rs.45,000" देखेर contact गर्यो। "Dubai बाट ल्याएको Original" भन्यो। Esewa मा Rs.45,000 पठाएपछि seller ले block गर्यो।',
        lesson: 'Advance payment कहिल्यै नगर्नुस्। Cash on delivery मात्र।',
        amountLost: 'Rs. ४५,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud report', icon: 'cyber'),
        VerifyToolData(name: 'eSewa Dispute', url: 'esewa.com.np', description: 'Transaction dispute', icon: 'payment'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'Complaint दर्ता', icon: 'police'),
        VerifyToolData(name: 'Hamrobazar', url: 'hamrobazar.com', description: 'Verified platform', icon: 'shop'),
      ],
      lawDetails: LawData(
        mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३, दफा ४७',
        punishment: '२ देखि ५ वर्षसम्म कैद',
        yourRights: ['Cyber Bureau मा complaint गर्ने अधिकार', 'Transaction reverse माग्ने अधिकार'],
        complaintProcess: ['Cyber Bureau: 1177 मा complaint', 'Transaction screenshot राख्नुस्', 'Bank/eSewa मा dispute file', 'प्रहरीमा FIR दर्ता'],
      ),
    ),
    'fraud_003': FraudLayerContent(
      howItHappens: [
        'Step 1 — Cooperative ले "२०-३०% ब्याज दिन्छु" भनेर approach गर्छ',
        'Step 2 — सुरुमा थोरै लगानीमा ब्याज दिन्छ',
        'Step 3 — "थप लगाउनुस्" भनेर ठूलो रकम लगाउन लगाउँछ',
        'Step 4 — अरू मान्छेलाई पनि भर्ती गर्न लगाउँछ',
        'Step 5 — एक दिन office बन्द गरेर भाग्छ',
      ],
      psychologyReasons: [
        'बैंकको भन्दा धेरै ब्याज पाउने लोभ',
        'छिमेकीले नाफा गरेको देखेर',
        'NRB registration check गर्न थाहा नहुनु',
        'Ponzi scheme सुरुमा साँच्चिकै ब्याज दिन्छ',
        '"आफ्नो cooperative" भनेर विश्वास',
      ],
      preventionDetails: [
        PreventionDetail(step: 'NRB दर्ता verify गर्नुस्', detail: 'nrb.org.np मा verify गर्नुस्। दर्ता नभएको ठाउँमा लगानी नगर्नुस्।', icon: 'verify'),
        PreventionDetail(step: '१२% भन्दा बढी ब्याज असम्भव छ', detail: 'यसभन्दा बढी दिन्छु भन्नेले ठग्न खोजेको हो।', icon: 'warning'),
        PreventionDetail(step: 'Audit report माग्नुस्', detail: 'Last 3 year को audited financial report माग्नुस्।', icon: 'document'),
        PreventionDetail(step: 'एउटै ठाउँमा सबै पैसा नराख्नुस्', detail: 'Risk diversify गर्नुस्।', icon: 'money'),
        PreventionDetail(step: 'Financial expert सँग सल्लाह लिनुस्', detail: 'ठूलो रकम लगानी गर्नु अघि सल्लाह लिनुस्।', icon: 'family'),
      ],
      realCase: RealCaseData(
        victimProfile: 'मायादेवी (नाम परिवर्तित), ४५ वर्ष, रुपन्देही',
        story: '"सहकारी" ले मासिक ३% ब्याज दिन्छु भन्यो। मायादेवीले Rs.५,००,००० लगाइन्। एक वर्षपछि cooperative को office बन्द भयो।',
        lesson: 'NRB registered cooperative मात्र। High return = High risk।',
        amountLost: 'Rs. ५,००,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'NRB', url: 'nrb.org.np', description: 'Financial institution verify', icon: 'bank'),
        VerifyToolData(name: 'DoC', url: 'doc.gov.np', description: 'Cooperative check', icon: 'govt'),
        VerifyToolData(name: 'NRB Hotline', url: '1414', description: 'Financial fraud report', icon: 'call'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR दर्ता', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'बैंक तथा वित्तीय संस्था ऐन २०७३, दफा ९८',
        punishment: '५ देखि १२ वर्षसम्म कैद र सम्पत्ति जफत',
        yourRights: ['NRB मा complaint गर्ने अधिकार', 'Asset freeze को अधिकार', 'Compensation माग्ने अधिकार'],
        complaintProcess: ['NRB: 1414 मा call', 'Deposit receipt राख्नुस्', 'Collective complaint दिनुस्', 'प्रहरीमा FIR दर्ता'],
      ),
    ),
    'fraud_004': FraudLayerContent(
      howItHappens: [
        'Step 1 — अनचिनेको नम्बरबाट "म बैंकको कर्मचारी हुँ" भनेर call',
        'Step 2 — "Account मा suspicious activity छ, बन्द हुन्छ"',
        'Step 3 — "Account बचाउन OTP दिनुस्"',
        'Step 4 — OTP पाएपछि account बाट पैसा निकाल्छ',
        'Step 5 — Phone बन्द गरेर भाग्छ',
      ],
      psychologyReasons: [
        'Account बन्द हुने डर',
        '"बैंकको मान्छे" भनेर authority मा विश्वास',
        'OTP को महत्व थाहा नहुनु',
        'Urgency — "अहिले नगरे account बन्द हुन्छ"',
        'Account details सहित बोल्छ — genuine लाग्छ',
      ],
      preventionDetails: [
        PreventionDetail(step: 'OTP कसैलाई पनि नदिनुस्', detail: 'बैंकले कहिल्यै OTP सोध्दैन — phone मा, SMS मा, वा Email मा।', icon: 'warning'),
        PreventionDetail(step: 'बैंकको official number मा callback', detail: 'Card को पछाडिको number मा आफैं call गर्नुस्।', icon: 'call'),
        PreventionDetail(step: 'Link मा click नगर्नुस्', detail: 'SMS मा आएको banking link मा कहिल्यै click नगर्नुस्।', icon: 'security'),
        PreventionDetail(step: 'Transaction alert on राख्नुस्', detail: 'Mobile alert service activate गर्नुस्।', icon: 'bell'),
        PreventionDetail(step: 'परिवारलाई सिकाउनुस्', detail: 'बुढापाका सदस्यहरूलाई यो ठगीबारे बताउनुस्।', icon: 'family'),
      ],
      realCase: RealCaseData(
        victimProfile: 'हरिप्रसाद (नाम परिवर्तित), ५५ वर्ष, पोखरा',
        story: '"NIC Asia Bank बाट बोल्दैछु। Account मा suspicious transaction भयो। OTP दिनुस्।" OTP दिए। ५ मिनेटमा Rs.२,५०,००० गयो।',
        lesson: 'बैंकले कहिल्यै OTP सोध्दैन।',
        amountLost: 'Rs. २,५०,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'तुरुन्त बैंकमा call', url: 'Card पछाडिको number', description: 'Account block', icon: 'call'),
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Phone fraud report', icon: 'cyber'),
        VerifyToolData(name: 'NRB', url: '1414', description: 'Banking fraud report', icon: 'bank'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR दर्ता', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३, दफा ४७',
        punishment: '३ देखि ७ वर्षसम्म कैद',
        yourRights: ['Bank मार्फत transaction reverse माग्ने अधिकार', 'Cyber Bureau मा complaint गर्ने अधिकार'],
        complaintProcess: ['तुरुन्त बैंकमा call गरेर account block', 'Cyber Bureau: 1177 मा complaint', 'Transaction details note गर्नुस्', 'प्रहरीमा FIR दर्ता'],
      ),
    ),
    'fraud_005': FraudLayerContent(
      howItHappens: [
        'Step 1 — "सेना/प्रहरीमा connection छ" भनेर approach',
        'Step 2 — Fake uniform वा ID देखाएर विश्वास जिताउँछ',
        'Step 3 — "Quota छ, तर पैसा चाहिन्छ"',
        'Step 4 — थोरैबाट सुरु गरेर ठूलो रकम माग्छ',
        'Step 5 — "Physical भएन" भनेर अझ माग्छ',
      ],
      psychologyReasons: [
        'सरकारी जागिरको सुरक्षाको चाहना',
        'Competitive exam मा fail को निराशा',
        '"Connection" भएकाले pass हुने भ्रम',
        'Fake success stories सुनाउँछ',
        'परिवारको सामाजिक प्रतिष्ठाको इच्छा',
      ],
      preventionDetails: [
        PreventionDetail(step: 'सरकारी भर्ना सधैं निःशुल्क', detail: 'नेपाली सेना, प्रहरीको भर्नामा कहिल्यै पैसा लाग्दैन।', icon: 'warning'),
        PreventionDetail(step: 'Official notice मात्र', detail: 'Nepal Army/Police official website मा मात्र vacancy हुन्छ।', icon: 'verify'),
        PreventionDetail(step: 'गोप्य राख्न भन्छ = ठगी', detail: '"परिवारलाई नभन्नुस्" भन्ने ठगी हो।', icon: 'family'),
        PreventionDetail(step: 'Office मा verify गर्नुस्', detail: 'व्यक्तिको नाम सम्बन्धित कार्यालयमा verify गर्नुस्।', icon: 'call'),
        PreventionDetail(step: 'Complaint गर्न नडराउनुस्', detail: 'ठग्न खोज्ने व्यक्ति criminal हो।', icon: 'police'),
      ],
      realCase: RealCaseData(
        victimProfile: 'बिक्रम (नाम परिवर्तित), २२ वर्ष, दाङ',
        story: '"नेपाली सेनामा connection छ, Rs.३,००,००० दिए भर्ना लाइदिन्छु।" परिवारले जग्गा बेचेर दियो। Agent भाग्यो।',
        lesson: 'सरकारी जागिरमा कहिल्यै पैसा लाग्दैन।',
        amountLost: 'Rs. ३,००,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Nepal Army', url: 'nepalarmy.mil.np', description: 'Official vacancy check', icon: 'govt'),
        VerifyToolData(name: 'Nepal Police', url: 'nepalpolice.gov.np', description: 'Official vacancy check', icon: 'police'),
        VerifyToolData(name: 'Gorkhapatra', url: 'gorkhapatraonline.com', description: 'Official notice check', icon: 'news'),
        VerifyToolData(name: 'CIB', url: '01-4412548', description: 'Complaint दर्ता', icon: 'call'),
      ],
      lawDetails: LawData(
        mainLaw: 'मुलुकी अपराध संहिता २०७४, दफा ३०९',
        punishment: '३ देखि ७ वर्षसम्म कैद',
        yourRights: ['प्रहरीमा complaint गर्ने अधिकार', 'रकम फिर्ता माग्ने अधिकार'],
        complaintProcess: ['प्रहरीमा FIR दर्ता', 'CIB: 01-4412548 मा सम्पर्क', 'Evidence राख्नुस्', 'Agent को ID record गर्नुस्'],
      ),
    ),
    'fraud_006': FraudLayerContent(
      howItHappens: [
        'Step 1 — Facebook मा fake profile "विदेशी" भनी message',
        'Step 2 — हप्ता/महिनौं chat गरेर emotional attachment',
        'Step 3 — "माया गर्छु, विवाह गर्छु" भन्छ',
        'Step 4 — "Emergency परेको, पैसा पठाउनुस्"',
        'Step 5 — पैसा पाएपछि block गर्छ',
      ],
      psychologyReasons: [
        'एक्लोपनको भावना',
        'विदेशी मान्छेसँग relationship को आकर्षण',
        'महिनौं invest गरेको emotional attachment',
        'AI-generated photos र scripted conversation',
        '"यति दिन माया गर्यो, ठग्ने होइन" भन्ने भ्रम',
      ],
      preventionDetails: [
        PreventionDetail(step: 'Video call मा face verify गर्नुस्', detail: 'Online चिनेको मान्छेसँग video call गर्नुस्। Live question सोध्नुस् — "नाक छुनुस्"।', icon: 'call'),
        PreventionDetail(step: 'Profile photo reverse search', detail: 'Google Images मा right-click → "Search image"। Stock photo भए fake हो।', icon: 'search'),
        PreventionDetail(step: 'Online मात्र चिनेकोलाई पैसा नपठाउनुस्', detail: '"Airport मा package", "Hospital bill" — यी fraud scripts हुन्।', icon: 'money'),
        PreventionDetail(step: 'परिवारसँग share गर्नुस्', detail: 'Outsider ले red flags छिट्टै देख्छ।', icon: 'family'),
        PreventionDetail(step: 'Suspicious account report गर्नुस्', detail: 'Facebook/Instagram मा report गर्नुस्।', icon: 'flag'),
      ],
      realCase: RealCaseData(
        victimProfile: 'प्रमिला (नाम परिवर्तित), ३२ वर्ष, काठमाडौं',
        story: '"James" नाम गरेको "Doctor" ले ३ महिना chat पछि "Airport मा gold package अड्कियो, Rs.१,५०,००० पठाउनुस्" भन्यो। Block भयो।',
        lesson: 'Online relationship मा पैसाको कुरा = ठगी।',
        amountLost: 'Rs. १,५०,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Google Reverse Image', url: 'images.google.com', description: 'Profile photo verify', icon: 'search'),
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Romance fraud report', icon: 'cyber'),
        VerifyToolData(name: 'Facebook Report', url: 'facebook.com', description: 'Fake profile report', icon: 'social'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR दर्ता', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'मुलुकी अपराध संहिता २०७४, दफा ३०९',
        punishment: '३ देखि ७ वर्षसम्म कैद',
        yourRights: ['Cyber Bureau मा complaint गर्ने अधिकार', 'Account suspend गराउने अधिकार'],
        complaintProcess: ['Chat, photo, transaction screenshot राख्नुस्', 'Cyber Bureau: 1177', 'Bank dispute file', 'मनोवैज्ञानिक सहायता'],
      ),
    ),
    'fraud_007': FraudLayerContent(
      howItHappens: [
        'Step 1 — "तपाईं Rs.५,००,००० जित्नुभयो!" SMS आउँछ',
        'Step 2 — "Claim गर्न tax वा fee तिर्नुस्"',
        'Step 3 — Fee तिरेपछि "अझ fee बाँकी" भन्छ',
        'Step 4 — पटक पटक fee लिएर भाग्छ',
        'Step 5 — Prize कहिल्यै आउँदैन',
      ],
      psychologyReasons: [
        'अप्रत्याशित पैसाको लोभ',
        'Official looking SMS',
        '"Already won" loss aversion',
        'Urgency — "२४ घण्टाभित्र claim"',
        'थोरै fee मा ठूलो prize',
      ],
      preventionDetails: [
        PreventionDetail(step: 'नखेलेको lottery जित्न सकिँदैन', detail: 'Lottery जित्न पहिले ticket किन्नुपर्छ।', icon: 'warning'),
        PreventionDetail(step: 'Prize claim गर्न fee लाग्दैन', detail: '"Tax", "Processing fee" माग्नु ठगीको sign।', icon: 'money'),
        PreventionDetail(step: 'Link मा click नगर्नुस्', detail: 'Phone hack हुन सक्छ।', icon: 'security'),
        PreventionDetail(step: 'Telecom मा report गर्नुस्', detail: 'Spam number Ncell/NTC मा report गर्नुस्।', icon: 'flag'),
        PreventionDetail(step: 'बुढापाकालाई सिकाउनुस्', detail: 'उनीहरू बढी target हुन्छन्।', icon: 'family'),
      ],
      realCase: RealCaseData(
        victimProfile: 'दिलमाया (नाम परिवर्तित), ५८ वर्ष, काभ्रे',
        story: '"Ncell lucky draw मा Rs.३,००,००० जित्नुभयो। Claim गर्न Rs.५,००० tax।" ७ पटकसम्म पैसा लियो।',
        lesson: 'Telecom ले SMS मा prize दिँदैन।',
        amountLost: 'Rs. ७५,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Ncell', url: '9801099', description: 'Spam report', icon: 'telecom'),
        VerifyToolData(name: 'NTC', url: '1600', description: 'Spam report', icon: 'telecom'),
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Fraud report', icon: 'cyber'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR दर्ता', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'मुलुकी अपराध संहिता २०७४, दफा ३०९',
        punishment: '२ देखि ५ वर्षसम्म कैद',
        yourRights: ['Cyber Bureau मा complaint', 'Refund माग्ने अधिकार'],
        complaintProcess: ['Transaction proof राख्नुस्', 'Cyber Bureau: 1177', 'Bank dispute', 'प्रहरीमा FIR'],
      ),
    ),
    'fraud_008': FraudLayerContent(
      howItHappens: [
        'Step 1 — Fake lalpurja बनाएर "सस्तोमा जग्गा बेच्छु"',
        'Step 2 — एउटै जग्गा धेरैलाई बेच्छ',
        'Step 3 — "Naapi office जान दिँदैन"',
        'Step 4 — Token money लिएर हराउँछ',
        'Step 5 — Real owner अर्कै निस्कन्छ',
      ],
      psychologyReasons: [
        'सस्तो जग्गाको लोभ',
        'चिनजानको broker',
        '"Hurry up — अर्को buyer छ"',
        'Fake documents professional देखिने',
        'Naapi process complex लाग्ने',
      ],
      preventionDetails: [
        PreventionDetail(step: 'Naapi कार्यालयमा verify', detail: 'जग्गा किन्नु अघि Naapi मा lalpurja verify। निःशुल्क सेवा।', icon: 'verify'),
        PreventionDetail(step: 'Malpot मा ownership check', detail: 'Owner को नाम record मा match हुनुपर्छ।', icon: 'document'),
        PreventionDetail(step: 'Lawyer राख्नुस्', detail: 'ठूलो रकमको जग्गा किन्दा certified lawyer राख्नुस्।', icon: 'legal'),
        PreventionDetail(step: 'Pressure मा sign नगर्नुस्', detail: '"आजै sign गर्नुस्" भन्ने seller बाट सतर्क।', icon: 'warning'),
        PreventionDetail(step: 'Bank transfer मार्फत payment', detail: 'Cash payment नगर्नुस् — proof हुँदैन।', icon: 'money'),
      ],
      realCase: RealCaseData(
        victimProfile: 'गोपाल (नाम परिवर्तित), ४२ वर्ष, काठमाडौं',
        story: 'Rs.५ lakh token दियो। पछि उही जग्गा ३ जनालाई बेचिएको थाहा भयो।',
        lesson: 'Naapi र Malpot मा verify अनिवार्य।',
        amountLost: 'Rs. ५,००,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Naapi', url: 'naapi.gov.np', description: 'Lalpurja verify', icon: 'govt'),
        VerifyToolData(name: 'Malpot', url: 'mrd.gov.np', description: 'Ownership check', icon: 'govt'),
        VerifyToolData(name: 'Nepal Bar', url: 'nepalbar.org.np', description: 'Lawyer खोज्नुस्', icon: 'legal'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'Fraud report', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'मुलुकी देवानी संहिता २०७४, दफा १९७',
        punishment: '५ देखि १० वर्षसम्म कैद',
        yourRights: ['Court मार्फत जग्गा फिर्ता माग्ने', 'Compensation माग्ने'],
        complaintProcess: ['Naapi र Malpot मा complaint', 'Court order लिनुस्', 'प्रहरीमा FIR', 'Lawyer राख्नुस्'],
      ),
    ),
    'fraud_009': FraudLayerContent(
      howItHappens: [
        'Step 1 — Phishing link पठाउँछ',
        'Step 2 — Fake bank website — real जस्तो देखिन्छ',
        'Step 3 — Login गर्दा credentials capture हुन्छ',
        'Step 4 — Malware download गराएर phone control लिन्छ',
        'Step 5 — Account खाली गर्छ',
      ],
      psychologyReasons: [
        'Fake र real website छुट्याउन नसक्नु',
        'Urgent security alert देखेर panic',
        'Official logo देखेर विश्वास',
        'Free wifi मा sensitive काम',
        'Password reuse',
      ],
      preventionDetails: [
        PreventionDetail(step: 'URL check गर्नुस्', detail: '"https://" र lock icon छ कि हेर्नुस्। Spelling carefully check।', icon: 'security'),
        PreventionDetail(step: '2FA on गर्नुस्', detail: 'Google Authenticator app use गर्नुस्।', icon: 'shield'),
        PreventionDetail(step: 'Email link मा click नगर्नुस्', detail: 'Browser मा directly URL type गर्नुस्।', icon: 'warning'),
        PreventionDetail(step: 'Public WiFi मा banking नगर्नुस्', detail: 'VPN use गर्नुस् वा mobile data।', icon: 'wifi'),
        PreventionDetail(step: 'Device update गर्नुस्', detail: 'Security patches नियमित install गर्नुस्।', icon: 'update'),
      ],
      realCase: RealCaseData(
        victimProfile: 'निरज (नाम परिवर्तित), २८ वर्ष, काठमाडौं',
        story: '"Himalayan Bank account suspended" email आयो। Fake website मा login गरे। Rs.१,८०,००० गयो।',
        lesson: 'Email link मा click नगर्नुस्।',
        amountLost: 'Rs. १,८०,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Hacking report', icon: 'cyber'),
        VerifyToolData(name: 'Password Change', url: 'हरेक account', description: 'तुरुन्त change गर्नुस्', icon: 'security'),
        VerifyToolData(name: 'बैंकमा call', url: 'Card number', description: 'Account block', icon: 'call'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR दर्ता', icon: 'police'),
      ],
      lawDetails: LawData(
        mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३, दफा ४४',
        punishment: '३ देखि ७ वर्षसम्म कैद',
        yourRights: ['Cyber Bureau मा complaint', 'Transaction reverse माग्ने'],
        complaintProcess: ['Password change', 'Bank block', 'Cyber Bureau: 1177', 'FIR दर्ता'],
      ),
    ),
    'fraud_010': FraudLayerContent(
      howItHappens: [
        'Step 1 — "100% scholarship guarantee" advertisement',
        'Step 2 — Processing fee, visa fee माग्छ',
        'Step 3 — Fake admission letter बनाउँछ',
        'Step 4 — Airport मा visa rejected हुन्छ',
        'Step 5 — Consultancy भाग्छ',
      ],
      psychologyReasons: [
        'विदेश पढ्ने सपना',
        '"Guarantee" शब्दले विश्वास',
        'Embassy process complex',
        'Peer pressure',
        'Registered र fake छुट्याउन नसक्नु',
      ],
      preventionDetails: [
        PreventionDetail(step: 'Ministry of Education मा verify', detail: 'moe.gov.np मा consultancy registration check।', icon: 'verify'),
        PreventionDetail(step: 'Embassy directly सम्पर्क', detail: 'Official visa info Embassy website मा छ।', icon: 'embassy'),
        PreventionDetail(step: 'Guarantee शब्दमा विश्वास नगर्नुस्', detail: 'Visa Embassy को decision हो।', icon: 'warning'),
        PreventionDetail(step: 'University directly contact', detail: 'Admission letter verify गर्नुस्।', icon: 'document'),
        PreventionDetail(step: 'Receipt लिनुस्', detail: 'हरेक payment को official receipt।', icon: 'receipt'),
      ],
      realCase: RealCaseData(
        victimProfile: 'सपना (नाम परिवर्तित), २० वर्ष, पोखरा',
        story: '"Australia scholarship" को लागि Rs.२,५०,००० तिरिन्। Visa reject भयो। Refund भएन।',
        lesson: 'Ministry registered consultancy मात्र।',
        amountLost: 'Rs. २,५०,०००',
      ),
      verifyTools: [
        VerifyToolData(name: 'MoE', url: 'moe.gov.np', description: 'Consultancy verify', icon: 'govt'),
        VerifyToolData(name: 'Embassy', url: 'mofa.gov.np', description: 'Visa info', icon: 'embassy'),
        VerifyToolData(name: 'Nepal Police', url: '100', description: 'Fraud report', icon: 'police'),
        VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud', icon: 'cyber'),
      ],
      lawDetails: LawData(
        mainLaw: 'शिक्षा ऐन २०२८',
        punishment: '२ देखि ५ वर्षसम्म कैद',
        yourRights: ['MoE मा complaint', 'Refund माग्ने', 'License रद्द गराउने'],
        complaintProcess: ['Receipt राख्नुस्', 'MoE मा complaint', 'FIR दर्ता', 'Consumer court'],
      ),
    ),
    'fraud_011': FraudLayerContent(
      howItHappens: ['Step 1 — "Cancer, Diabetes 100% निको" भनेर आउँछ', 'Step 2 — Fake certificate देखाउँछ', 'Step 3 — महँगो नक्कली medicine बेच्छ', 'Step 4 — "अझ course चाहिन्छ" भनेर माग्छ', 'Step 5 — वास्तवमा रोग निको हुँदैन'],
      psychologyReasons: ['गम्भीर रोगबाट निको हुने आशा', 'Hospital महँगो लाग्ने', 'Testimonials मा विश्वास', 'Desperate इच्छा', 'Alternative medicine आकर्षण'],
      preventionDetails: [
        PreventionDetail(step: 'NMC registered doctor मात्र', detail: 'nmc.org.np मा verify।', icon: 'verify'),
        PreventionDetail(step: 'DDA verify गर्नुस्', detail: 'dda.gov.np मा medicine check।', icon: 'document'),
        PreventionDetail(step: '100% cure असम्भव', detail: 'यस्तो claim गर्ने quack हो।', icon: 'warning'),
        PreventionDetail(step: 'Second opinion', detail: 'अर्को registered doctor बाट।', icon: 'doctor'),
        PreventionDetail(step: 'Government hospital', detail: 'Bir Hospital, TUTH मा qualified doctors छन्।', icon: 'hospital'),
      ],
      realCase: RealCaseData(victimProfile: 'रामकली, ५० वर्ष, सिन्धुली', story: 'Rs.१,२०,000 को "herbal medicine" किनिन्। Medicine मा sugar मात्र थियो।', lesson: 'DDA registered medicine मात्र।', amountLost: 'Rs. १,२०,०००'),
      verifyTools: [VerifyToolData(name: 'NMC', url: 'nmc.org.np', description: 'Doctor verify', icon: 'medical'), VerifyToolData(name: 'DDA', url: 'dda.gov.np', description: 'Medicine verify', icon: 'govt'), VerifyToolData(name: 'DDA Hotline', url: '1800-01-8899', description: 'Fake medicine report', icon: 'call'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'औषधि ऐन २०३५', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['DDA मा complaint', 'Refund माग्ने', 'Health damage compensation'], complaintProcess: ['Medicine sample राख्नुस्', 'DDA: 1800-01-8899', 'FIR दर्ता', 'Consumer court']),
    ),
    'fraud_012': FraudLayerContent(
      howItHappens: ['Step 1 — बैंकको नाममा professional email', 'Step 2 — "Account suspended" link', 'Step 3 — Fake website मा login', 'Step 4 — Credentials captured', 'Step 5 — Account खाली'],
      psychologyReasons: ['Account बन्द हुने डर', 'Official looking email', 'Urgency', 'URL नहेर्ने', 'Mobile मा URL देखिँदैन'],
      preventionDetails: [
        PreventionDetail(step: 'Email URL verify गर्नुस्', detail: 'Sender domain carefully check।', icon: 'verify'),
        PreventionDetail(step: 'बैंकले email link पठाउँदैन', detail: 'Browser मा directly type।', icon: 'warning'),
        PreventionDetail(step: 'Official banking app मात्र', detail: 'Play Store बाट download।', icon: 'app'),
        PreventionDetail(step: 'Transaction alert on', detail: 'Mobile alert activate।', icon: 'bell'),
        PreventionDetail(step: 'Suspicious email report', detail: 'Gmail मा "Report phishing"।', icon: 'flag'),
      ],
      realCase: RealCaseData(victimProfile: 'सुरेश, ३५ वर्ष, ललितपुर', story: 'NIC Asia Bank email link मा login गरे। Rs.३,२०,000 गयो।', lesson: 'बैंकले email login link पठाउँदैन।', amountLost: 'Rs. ३,२०,०००'),
      verifyTools: [VerifyToolData(name: 'बैंकमा call', url: 'Card number', description: 'Account block', icon: 'call'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Phishing report', icon: 'cyber'), VerifyToolData(name: 'NRB', url: '1414', description: 'Banking fraud', icon: 'bank'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['Transaction reverse', 'Cyber complaint'], complaintProcess: ['Account block', 'Phishing screenshot', 'Cyber Bureau: 1177', 'FIR']),
    ),
    'fraud_013': FraudLayerContent(
      howItHappens: ['Step 1 — Fake NGO disaster पछि बन्छ', 'Step 2 — Emotional photos राख्छ', 'Step 3 — "तुरुन्त donate" urgency', 'Step 4 — Personal account मा माग्छ', 'Step 5 — पैसा आफ्नै खर्च'],
      psychologyReasons: ['पीडितप्रति सहानुभूति', 'Emotional photos', 'NGO verification थाहा नहुनु', 'Social proof', 'Disaster chaos'],
      preventionDetails: [
        PreventionDetail(step: 'SWC दर्ता verify', detail: 'swc.org.np मा NGO check।', icon: 'verify'),
        PreventionDetail(step: 'Personal account मा donate नगर्नुस्', detail: 'Institutional bank account हुनुपर्छ।', icon: 'money'),
        PreventionDetail(step: 'Government fund मा donate', detail: 'PM Disaster Relief Fund वा Red Cross।', icon: 'govt'),
        PreventionDetail(step: 'Receipt माग्नुस्', detail: 'Legitimate NGO ले receipt दिन्छ।', icon: 'receipt'),
        PreventionDetail(step: 'Track record check', detail: 'Annual report र news coverage।', icon: 'search'),
      ],
      realCase: RealCaseData(victimProfile: 'अनेक donors', story: '"Earthquake Relief Nepal" ले Rs.५०+ lakh जम्मा गर्यो। Personal account थियो। Page delete भयो।', lesson: 'SWC registered NGO मात्र।', amountLost: 'Rs. ५०+ लाख'),
      verifyTools: [VerifyToolData(name: 'SWC', url: 'swc.org.np', description: 'NGO verify', icon: 'govt'), VerifyToolData(name: 'Red Cross', url: 'nrcs.org', description: 'Verified relief', icon: 'ngo'), VerifyToolData(name: 'PM Relief Fund', url: 'pmrf.gov.np', description: 'Official fund', icon: 'govt'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'Fraud report', icon: 'police')],
      lawDetails: LawData(mainLaw: 'संस्था दर्ता ऐन २०३४', punishment: '२ देखि ५ वर्षसम्म', yourRights: ['SWC complaint', 'Refund माग्ने'], complaintProcess: ['Transaction proof', 'SWC complaint', 'Cyber Bureau', 'FIR']),
    ),
    'fraud_014': FraudLayerContent(
      howItHappens: ['Step 1 — "Room to Let" post', 'Step 2 — "विदेशमा छु, agent मार्फत deal"', 'Step 3 — Authentic photos पठाउँछ', 'Step 4 — "Deposit पठाउनुस्, key courier"', 'Step 5 — Block गर्छ'],
      psychologyReasons: ['Kathmandu मा घर खोज्न गाह्रो', 'Sasto rent', 'Photos authentic', 'Agent normal', 'Student र नयाँ आएका target'],
      preventionDetails: [
        PreventionDetail(step: 'घर आफैं हेर्नुस्', detail: 'Deposit दिनु अघि physically जानुस्।', icon: 'home'),
        PreventionDetail(step: 'Landlord identity verify', detail: 'Citizenship र Ward office।', icon: 'verify'),
        PreventionDetail(step: 'Rent agreement गर्नुस्', detail: 'सबै terms लेखिएको हुनुपर्छ।', icon: 'document'),
        PreventionDetail(step: 'Bank transfer मार्फत deposit', detail: 'Proof को लागि।', icon: 'money'),
        PreventionDetail(step: 'Photo reverse search', detail: 'Stolen photo detect गर्नुस्।', icon: 'search'),
      ],
      realCase: RealCaseData(victimProfile: 'रमेश, २३ वर्ष, भक्तपुर', story: '"Kathmandu 1BHK, Rs.8000/month" OLX। Rs.25,000 deposit पठाएपछि block।', lesson: 'घर नदेखाइ deposit नदिनुस्।', amountLost: 'Rs. २५,०००'),
      verifyTools: [VerifyToolData(name: 'Ward कार्यालय', url: 'नजिकको', description: 'Property verify', icon: 'govt'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'NRB', url: '1414', description: 'Payment fraud', icon: 'bank')],
      lawDetails: LawData(mainLaw: 'मुलुकी देवानी संहिता २०७४', punishment: '१ देखि ३ वर्षसम्म', yourRights: ['Deposit फिर्ता', 'FIR दर्ता'], complaintProcess: ['Transaction proof', 'Cyber Bureau', 'FIR', 'Bank dispute']),
    ),
    'fraud_015': FraudLayerContent(
      howItHappens: ['Step 1 — "Bitcoin मा 500% profit" message', 'Step 2 — Fake trading platform', 'Step 3 — Profit देखाउँछ — withdraw दिँदैन', 'Step 4 — "Tax तिर्नुस्" भनेर थप माग्छ', 'Step 5 — Platform बन्द'],
      psychologyReasons: ['Crypto success stories', 'Fast money', 'Fake profit screenshot', 'FOMO', 'Friends ले गरेको देखेर'],
      preventionDetails: [
        PreventionDetail(step: 'Nepal मा crypto unregulated', detail: 'NRB ले license दिएको छैन।', icon: 'warning'),
        PreventionDetail(step: 'Guaranteed profit असम्भव', detail: '"500% profit" भन्ने ठगी हो।', icon: 'money'),
        PreventionDetail(step: 'Regulated platform मात्र', detail: 'Unknown Nepali platform trust नगर्नुस्।', icon: 'verify'),
        PreventionDetail(step: 'Withdraw test गर्नुस्', detail: 'Small amount test withdraw।', icon: 'security'),
        PreventionDetail(step: 'Expert सँग सल्लाह', detail: 'Telegram advice = ठग।', icon: 'advice'),
      ],
      realCase: RealCaseData(victimProfile: 'प्रकाश, २६ वर्ष, काठमाडौं', story: '"CryptoNepal" Telegram मा Rs.३,५०,000 invest गरे। Tax भनेर थप Rs.१,५०,000। Platform बन्द।', lesson: 'Guaranteed profit = ठगी।', amountLost: 'Rs. ५,००,०००'),
      verifyTools: [VerifyToolData(name: 'NRB', url: 'nrb.org.np', description: 'Platform verify', icon: 'bank'), VerifyToolData(name: 'SEBON', url: 'sebon.gov.np', description: 'Investment fraud', icon: 'govt'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'धितोपत्र ऐन २०६३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['NRB/SEBON complaint', 'Asset freeze'], complaintProcess: ['Records राख्नुस्', 'NRB: 1414', 'Cyber Bureau: 1177', 'FIR']),
    ),
    'fraud_016': FraudLayerContent(
      howItHappens: ['Step 1 — "विवाह गरिदिन्छु"', 'Step 2 — Fake identity', 'Step 3 — Dowry/खर्च माग्छ', 'Step 4 — विदेश लैजाने प्रलोभन', 'Step 5 — पैसा/गहना लिएर भाग्छ'],
      psychologyReasons: ['विवाहको सामाजिक दबाब', 'राम्रो जीवनसाथी', 'परिवारको approval', 'Background verify नगर्ने', 'विदेश प्रलोभन'],
      preventionDetails: [
        PreventionDetail(step: 'Background thoroughly verify', detail: 'Citizenship, family, job सबै verify।', icon: 'verify'),
        PreventionDetail(step: 'Dowry नदिनुस्', detail: 'Nepal मा illegal छ।', icon: 'warning'),
        PreventionDetail(step: 'हतार नगर्नुस्', detail: 'Time लिएर जान्नुस्।', icon: 'time'),
        PreventionDetail(step: 'परिवारसँग सल्लाह', detail: 'परिवारलाई भेटाउनुस्।', icon: 'family'),
        PreventionDetail(step: 'Trafficking awareness', detail: 'Passport कसैलाई नदिनुस्।', icon: 'alert'),
      ],
      realCase: RealCaseData(victimProfile: 'सावित्री, २१ वर्ष, रौतहट', story: '"UAE मा job, विवाह गरेर लैजान्छु।" Rs.३,५०,000 गहना/नगद। UAE मा छोडेर भाग्यो।', lesson: 'Dowry नदिनुस्। Passport आफैं राख्नुस्।', amountLost: 'Rs. ३,५०,०००'),
      verifyTools: [VerifyToolData(name: 'महिला आयोग', url: '1145', description: 'Women complaint', icon: 'women'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'DoFE', url: '1180', description: 'Trafficking report', icon: 'govt'), VerifyToolData(name: 'THB', url: '1800-01-8899', description: 'Rescue', icon: 'call')],
      lawDetails: LawData(mainLaw: 'मुलुकी अपराध संहिता २०७४, दफा १७३', punishment: '५ देखि २० वर्षसम्म', yourRights: ['Legal aid', 'Dowry फिर्ता', 'Safe house'], complaintProcess: ['महिला आयोग: 1145', 'FIR दर्ता', 'Evidence राख्नुस्', 'Safe house']),
    ),
    'fraud_017': FraudLayerContent(
      howItHappens: ['Step 1 — Fake government ID', 'Step 2 — "Tax irregularity छ"', 'Step 3 — "Cash दिए case close"', 'Step 4 — Receipt नदिई जान्छ', 'Step 5 — फेरि माग्न आउँछ'],
      psychologyReasons: ['सरकारी कारबाहीको डर', 'Authority विश्वास', 'Legal process नबुझ्नु', 'Business बन्द हुने डर', 'Quietly settle'],
      preventionDetails: [
        PreventionDetail(step: 'Official ID verify गर्नुस्', detail: 'कार्यालयमा call गरेर verify।', icon: 'verify'),
        PreventionDetail(step: 'Cash कहिल्यै नदिनुस्', detail: 'Tax सधैं bank मार्फत receipt सहित।', icon: 'money'),
        PreventionDetail(step: 'Office बाहिर deal नगर्नुस्', detail: 'सरकारी काम official office मा।', icon: 'warning'),
        PreventionDetail(step: 'CIAA मा report', detail: 'CIAA: 1113।', icon: 'flag'),
        PreventionDetail(step: 'Lawyer राख्नुस्', detail: 'Fake officer आफैं भाग्छ।', icon: 'legal'),
      ],
      realCase: RealCaseData(victimProfile: 'मनोज, ४० वर्ष, भरतपुर', story: 'Fake "IRO officer" ले Rs.५०,000 लियो। फेरि माग्न आयो।', lesson: 'Official ID verify। Cash नदिनुस्।', amountLost: 'Rs. ५०,०००'),
      verifyTools: [VerifyToolData(name: 'CIAA', url: '1113', description: 'Corruption report', icon: 'govt'), VerifyToolData(name: 'IRD', url: 'ird.gov.np', description: 'Tax office verify', icon: 'tax'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'प्रहरी', url: '100', description: 'तुरुन्त call', icon: 'call')],
      lawDetails: LawData(mainLaw: 'भ्रष्टाचार निवारण ऐन २०५९', punishment: '३ देखि १० वर्षसम्म', yourRights: ['CIAA complaint', 'Fake ID मुद्दा'], complaintProcess: ['CIAA: 1113', 'Fake ID photo', 'FIR', 'Witness राख्नुस्']),
    ),
    'fraud_018': FraudLayerContent(
      howItHappens: ['Step 1 — Facebook account hack', 'Step 2 — साथीलाई "Emergency, पैसा पठाउनुस्"', 'Step 3 — Personal photos blackmail', 'Step 4 — Personal info collect', 'Step 5 — Dark web मा बेच्छ'],
      psychologyReasons: ['साथीको account trust', 'Emergency help', 'Verify नगरी पठाउने', 'Weak password', 'Personal photos share'],
      preventionDetails: [
        PreventionDetail(step: '2FA on गर्नुस्', detail: 'Settings → Security → 2FA।', icon: 'security'),
        PreventionDetail(step: 'Strong unique password', detail: 'Password manager use।', icon: 'lock'),
        PreventionDetail(step: 'Phone मा verify गर्नुस्', detail: 'Paise पठाउनु अघि call गर्नुस्।', icon: 'call'),
        PreventionDetail(step: 'Suspicious link click नगर्नुस्', detail: 'Account hack हुन्छ।', icon: 'warning'),
        PreventionDetail(step: 'Login activity check', detail: 'Settings → Security → Logged In।', icon: 'monitor'),
      ],
      realCase: RealCaseData(victimProfile: 'सन्तोष, ३२ वर्ष, काठमाडौं', story: 'Facebook hack। ८ साथीले Rs.५,000-5,000 पठाए। Total Rs.४०,000।', lesson: '2FA on गर्नुस्। Verify गरेर मात्र पठाउनुस्।', amountLost: 'Rs. ४०,०००'),
      verifyTools: [VerifyToolData(name: 'Facebook Recovery', url: 'facebook.com/hacked', description: 'Account recover', icon: 'social'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Hacking report', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'Bank', url: 'तुरुन्त call', description: 'Transaction reverse', icon: 'bank')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['Cyber complaint', 'Account recovery'], complaintProcess: ['Account recover', 'Alert साथीहरूलाई', 'Cyber Bureau: 1177', 'Bank dispute']),
    ),
    'fraud_019': FraudLayerContent(
      howItHappens: ['Step 1 — Unregistered insurance agent', 'Step 2 — Fake policy देखाउँछ', 'Step 3 — Cash premium लिन्छ', 'Step 4 — Fake document दिन्छ', 'Step 5 — Claim गर्दा invalid'],
      psychologyReasons: ['Insurance बुझ्न गाह्रो', 'Cheap premium', 'Agent चिनजान', 'Policy नपढ्ने', 'Claim process complex'],
      preventionDetails: [
        PreventionDetail(step: 'Beema Samiti verify', detail: 'ib.gov.np मा check।', icon: 'verify'),
        PreventionDetail(step: 'Bank transfer premium', detail: 'Cash नदिनुस्।', icon: 'money'),
        PreventionDetail(step: 'Policy document पढ्नुस्', detail: 'Coverage, exclusions सबै clear।', icon: 'document'),
        PreventionDetail(step: 'Direct company बाट', detail: 'Agent को साटो office।', icon: 'building'),
        PreventionDetail(step: 'Renewal track गर्नुस्', detail: 'Lapse भए coverage छैन।', icon: 'calendar'),
      ],
      realCase: RealCaseData(victimProfile: 'कमला, ४८ वर्ष, धादिङ', story: '५ वर्ष premium तिरिन्। Claim गर्दा company registered नै थिएन।', lesson: 'Beema Samiti registered मात्र।', amountLost: 'Rs. १५,०००'),
      verifyTools: [VerifyToolData(name: 'Beema Samiti', url: 'ib.gov.np', description: 'Insurance verify', icon: 'govt'), VerifyToolData(name: 'Beema Samiti', url: '01-4229873', description: 'Complaint', icon: 'call'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'Consumer Court', url: 'District Court', description: 'Civil case', icon: 'legal')],
      lawDetails: LawData(mainLaw: 'बीमा ऐन २०४९', punishment: '२ देखि ५ वर्षसम्म', yourRights: ['Beema Samiti complaint', 'Refund', 'Compensation'], complaintProcess: ['Beema Samiti: 01-4229873', 'Receipt राख्नुस्', 'FIR', 'Consumer court']),
    ),
    'fraud_020': FraudLayerContent(
      howItHappens: ['Step 1 — "राम्रो job" भनेर approach', 'Step 2 — "Passport राख्छु" भन्छ', 'Step 3 — "कसैलाई नभन्नुस्"', 'Step 4 — Passport खोसेर forced work', 'Step 5 — Escape दिँदैन'],
      psychologyReasons: ['आर्थिक बाध्यता', 'Agent चिनजान', 'परिवारको बोझ', 'Process नबुझ्नु', 'Isolation'],
      preventionDetails: [
        PreventionDetail(step: 'Passport कसैलाई नदिनुस्', detail: 'Embassy मा officially submit हुन्छ।', icon: 'passport'),
        PreventionDetail(step: 'परिवारलाई सबै जानकारी', detail: 'गोप्य राख्न भन्ने = fake।', icon: 'family'),
        PreventionDetail(step: 'DoFE registered agent मात्र', detail: 'dofeprovident.gov.np।', icon: 'verify'),
        PreventionDetail(step: 'Embassy number save', detail: 'Emergency मा contact।', icon: 'call'),
        PreventionDetail(step: 'Contract अनिवार्य', detail: 'Salary, hours, accommodation सब।', icon: 'document'),
      ],
      realCase: RealCaseData(victimProfile: 'रेखा, १९ वर्ष, सिन्धुली', story: 'Passport लियो। Kuwait पुगेपछि Passport खोसियो। Embassy मा भागेर उद्धार।', lesson: 'Passport कसैलाई नदिनुस्।', amountLost: 'स्वतन्त्रता र trauma'),
      verifyTools: [VerifyToolData(name: 'THB Hotline', url: '1800-01-8899', description: 'Rescue', icon: 'emergency'), VerifyToolData(name: 'DoFE', url: '1180', description: 'Agent verify', icon: 'govt'), VerifyToolData(name: 'Maiti Nepal', url: '01-4271871', description: 'Support', icon: 'ngo'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'Emergency', icon: 'police')],
      lawDetails: LawData(mainLaw: 'मानव बेचबिखन ऐन २०६४', punishment: '१५ देखि २५ वर्षसम्म', yourRights: ['Embassy rescue', 'Safe house', 'Compensation'], complaintProcess: ['THB: 1800-01-8899', 'Embassy', 'Nepal Police', 'Maiti Nepal']),
    ),
    'fraud_021': FraudLayerContent(
      howItHappens: ['Step 1 — "Serious रोग छ" भनेर डर देखाउँछ', 'Step 2 — "Special treatment, महँगो" भन्छ', 'Step 3 — Unnecessary tests', 'Step 4 — "अझ treatment" भनेर माग्छ', 'Step 5 — रोग नै थिएन'],
      psychologyReasons: ['स्वास्थ्यको डर', 'Doctor authority', 'Medical knowledge कम', 'Second opinion लाज', 'Rural areas limited options'],
      preventionDetails: [
        PreventionDetail(step: 'NMC registered doctor', detail: 'nmc.org.np।', icon: 'verify'),
        PreventionDetail(step: 'Second opinion', detail: 'तपाईंको अधिकार हो।', icon: 'doctor'),
        PreventionDetail(step: 'Government hospital', detail: 'Bir Hospital, TUTH।', icon: 'hospital'),
        PreventionDetail(step: 'Prescription माग्नुस्', detail: 'Written prescription अनिवार्य।', icon: 'document'),
        PreventionDetail(step: 'Cost estimate अघि माग्नुस्', detail: 'Unexpected charges clarify।', icon: 'money'),
      ],
      realCase: RealCaseData(victimProfile: 'हरिबहादुर, ६२ वर्ष, गोरखा', story: '"Kidney problem छ, Rs.२,५०,000 treatment।" Government hospital मा kidney ठिक थियो।', lesson: 'Government hospital verify। Second opinion।', amountLost: 'Rs. २,५०,०००'),
      verifyTools: [VerifyToolData(name: 'NMC', url: 'nmc.org.np', description: 'Doctor verify', icon: 'medical'), VerifyToolData(name: 'NMC Complaint', url: '01-4225374', description: 'Fake doctor', icon: 'call'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'Consumer Court', url: 'District Court', description: 'Compensation', icon: 'legal')],
      lawDetails: LawData(mainLaw: 'स्वास्थ्य सेवा ऐन २०५३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['NMC complaint', 'Refund', 'Compensation'], complaintProcess: ['NMC: 01-4225374', 'Bills राख्नुस्', 'FIR', 'Consumer court']),
    ),
    'fraud_022': FraudLayerContent(
      howItHappens: ['Step 1 — "Special recharge 50% off" Whatsapp', 'Step 2 — Fake app download', 'Step 3 — Phone access लिन्छ', 'Step 4 — Recharge नहुने', 'Step 5 — Banking info चोर्छ'],
      psychologyReasons: ['Discount लोभ', 'Mobile data महँगो', 'Unknown app install', 'Offer legit', 'Technical knowledge कम'],
      preventionDetails: [
        PreventionDetail(step: 'Official app मात्र', detail: 'Play Store बाट Ncell/NTC app।', icon: 'app'),
        PreventionDetail(step: 'Verified retailer', detail: 'Physical recharge card।', icon: 'shop'),
        PreventionDetail(step: 'Unknown link click नगर्नुस्', detail: 'Official channel मा मात्र offer।', icon: 'warning'),
        PreventionDetail(step: 'App permissions check', detail: 'Recharge app ले banking access माग्छ = install नगर्नुस्।', icon: 'security'),
        PreventionDetail(step: '"Unknown sources" off', detail: 'Android Settings → Security।', icon: 'settings'),
      ],
      realCase: RealCaseData(victimProfile: 'बिनोद, २५ वर्ष, पोखरा', story: '"Ncell Special" app download गरे। eSewa बाट Rs.१५,000 गयो।', lesson: 'Official app मात्र।', amountLost: 'Rs. १५,०००'),
      verifyTools: [VerifyToolData(name: 'Ncell', url: '9801099', description: 'Official', icon: 'telecom'), VerifyToolData(name: 'NTC', url: '1600', description: 'Official', icon: 'telecom'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'App fraud', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '२ देखि ५ वर्षसम्म', yourRights: ['Cyber complaint', 'Bank reverse'], complaintProcess: ['Logout तुरुन्त', 'Bank call', 'Cyber Bureau', 'Factory reset']),
    ),
    'fraud_023': FraudLayerContent(
      howItHappens: ['Step 1 — "Easy loan, no collateral"', 'Step 2 — Contacts/photos access माग्छ', 'Step 3 — High interest loan दिन्छ', 'Step 4 — "Defaulter" भनेर contacts मा message', 'Step 5 — Photos blackmail'],
      psychologyReasons: ['Quick cash', 'Bank loan complex', 'Easy approval', 'Terms नपढ्ने', 'Desperation'],
      preventionDetails: [
        PreventionDetail(step: 'NRB licensed app मात्र', detail: 'nrb.org.np मा list छ।', icon: 'verify'),
        PreventionDetail(step: 'App permissions check', detail: 'Contacts/photos access = install नगर्नुस्।', icon: 'security'),
        PreventionDetail(step: 'APR calculate गर्नुस्', detail: '"1% daily" = 365% annual।', icon: 'calculate'),
        PreventionDetail(step: 'Bank/microfinance बाट loan', detail: 'Slow तर safe।', icon: 'bank'),
        PreventionDetail(step: 'Harassment report गर्नुस्', detail: 'Cyber Bureau: 1177।', icon: 'flag'),
      ],
      realCase: RealCaseData(victimProfile: 'सुमन, ३० वर्ष, भरतपुर', story: '"QuickCash" Rs.5,000 loan। ७ दिनमा Rs.7,500। Contacts मा "Defaulter" message।', lesson: 'Contact access दिने app install नगर्नुस्।', amountLost: 'Rs. ७,५०० + reputation'),
      verifyTools: [VerifyToolData(name: 'NRB', url: 'nrb.org.np', description: 'Licensed lenders', icon: 'bank'), VerifyToolData(name: 'NRB Hotline', url: '1414', description: 'Illegal lending', icon: 'call'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Harassment', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'बैंक तथा वित्तीय संस्था ऐन २०७३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['NRB complaint', 'Refund', 'Harassment action'], complaintProcess: ['NRB: 1414', 'Cyber Bureau: 1177', 'Screenshot evidence', 'FIR']),
    ),
    'fraud_024': FraudLayerContent(
      howItHappens: ['Step 1 — "Your PC has virus" popup', 'Step 2 — "Call Microsoft/Apple support"', 'Step 3 — "Remote access दिनुस्"', 'Step 4 — Banking details चोर्छ', 'Step 5 — "Fix fee तिर्नुस्"'],
      psychologyReasons: ['Virus को डर', 'Microsoft नाम देखेर', 'Technical fix नसक्नु', 'Popup panic', 'Remote convenient'],
      preventionDetails: [
        PreventionDetail(step: 'Browser popup trust नगर्नुस्', detail: 'Microsoft ले popup support गर्दैन। Browser बन्द।', icon: 'warning'),
        PreventionDetail(step: 'Remote access नदिनुस्', detail: '= घरको key दिनु।', icon: 'security'),
        PreventionDetail(step: 'Original antivirus', detail: 'Windows Defender, Kaspersky।', icon: 'shield'),
        PreventionDetail(step: 'Trusted IT person', detail: 'Physically आएर help।', icon: 'person'),
        PreventionDetail(step: 'Regular backup', detail: 'Google Drive वा external drive।', icon: 'backup'),
      ],
      realCase: RealCaseData(victimProfile: 'प्रेमलाल, ५५ वर्ष, काठमाडौं', story: '"Microsoft" popup। Remote access दिए। Rs.१,८०,000 account बाट।', lesson: 'Popup number मा call नगर्नुस्।', amountLost: 'Rs. १,८०,०००'),
      verifyTools: [VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Tech fraud', icon: 'cyber'), VerifyToolData(name: 'Bank', url: 'Card number', description: 'Account block', icon: 'bank'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'IT Expert', url: 'Trusted person', description: 'Computer clean', icon: 'tech')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['Cyber complaint', 'Bank reverse'], complaintProcess: ['Internet disconnect', 'Bank block', 'Cyber Bureau: 1177', 'IT clean']),
    ),
    'fraud_025': FraudLayerContent(
      howItHappens: ['Step 1 — "Receive गर्न QR scan" mislead', 'Step 2 — Fake QR टाँस्छ', 'Step 3 — Scan गर्दा आफ्नो account बाट', 'Step 4 — "Verify गर्न फेरि scan"', 'Step 5 — Double payment'],
      psychologyReasons: ['QR कम बुझिएको', '"Receive गर्न scan" confuse', 'Digital payment trust', 'Quick scan', 'Amount confirm नगर्ने'],
      preventionDetails: [
        PreventionDetail(step: 'Receive गर्न QR scan गर्नु पर्दैन', detail: 'Scan = SEND। यो सबैभन्दा important।', icon: 'warning'),
        PreventionDetail(step: 'Amount confirm गर्नुस्', detail: 'Confirm button अघि amount check।', icon: 'verify'),
        PreventionDetail(step: 'Shop QR verify', detail: 'Owner को नाम देखिन्छ कि check।', icon: 'check'),
        PreventionDetail(step: 'Official app मात्र', detail: 'eSewa, Khalti, IME Pay।', icon: 'app'),
        PreventionDetail(step: 'Transaction history check', detail: 'Suspicious transaction report।', icon: 'history'),
      ],
      realCase: RealCaseData(victimProfile: 'मोहन, ३८ वर्ष, ललितपुर', story: 'Bike बेच्दा buyer ले "QR scan गर्नुस्" भन्यो। Rs.२५,000 account बाट गयो।', lesson: 'Scan = Send। Receive गर्न scan नगर्नुस्।', amountLost: 'Rs. २५,०००'),
      verifyTools: [VerifyToolData(name: 'eSewa', url: '16600172222', description: 'Transaction dispute', icon: 'payment'), VerifyToolData(name: 'Khalti', url: '16600185001', description: 'Transaction dispute', icon: 'payment'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'QR fraud', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '२ देखि ५ वर्षसम्म', yourRights: ['Payment app dispute', 'Transaction reverse'], complaintProcess: ['eSewa/Khalti call', 'Screenshot राख्नुस्', 'Cyber Bureau', 'FIR']),
    ),
    'fraud_026': FraudLayerContent(
      howItHappens: ['Step 1 — Video call record गर्छ', 'Step 2 — Photos collect गर्छ', 'Step 3 — AI ले manipulate गर्छ', 'Step 4 — "पैसा नदिए viral"', 'Step 5 — दिए झन् माग्छ'],
      psychologyReasons: ['शर्म र सामाजिक डर', 'परिवारलाई थाहा भएला', 'Alone feel', 'पैसाले बन्द हुन्छ भन्ने', 'Evidence destroy नजान्नु'],
      preventionDetails: [
        PreventionDetail(step: 'Unknown सँग video call नगर्नुस्', detail: 'Screen record भइरहेको हुन्छ।', icon: 'camera'),
        PreventionDetail(step: 'Intimate photos share नगर्नुस्', detail: 'Partner लाई पनि।', icon: 'photo'),
        PreventionDetail(step: 'Blackmail मा पैसा नतिर्नुस्', detail: 'तिरे झन् माग्छ।', icon: 'warning'),
        PreventionDetail(step: 'Block र report गर्नुस्', detail: 'Evidence राखेर block।', icon: 'block'),
        PreventionDetail(step: 'Cyber Bureau मा जानुस्', detail: 'Victim तपाईं हो, criminal होइन।', icon: 'police'),
      ],
      realCase: RealCaseData(victimProfile: 'अनिल, २४ वर्ष, मोरङ', story: '"Emma" ले video record गर्यो। Rs.५०,000 पठाएपछि Rs.२,00,000 माग्यो।', lesson: 'पैसा नतिर्नुस्। Cyber Bureau: 1177।', amountLost: 'Rs. ५०,०००'),
      verifyTools: [VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Sextortion', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police'), VerifyToolData(name: 'महिला आयोग', url: '1145', description: 'Women', icon: 'women'), VerifyToolData(name: 'Mental Health', url: '1166', description: 'Counseling', icon: 'health')],
      lawDetails: LawData(mainLaw: 'इलेक्ट्रोनिक कारोबार ऐन २०६३', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['Confidential complaint', 'Content remove', 'Compensation'], complaintProcess: ['Cyber Bureau: 1177', 'Evidence राख्नुस्', 'Platform report', 'Mental health: 1166']),
    ),
    'fraud_027': FraudLayerContent(
      howItHappens: ['Step 1 — "Business opportunity" seminar', 'Step 2 — Lifestyle देखाउँछ', 'Step 3 — Product + member investment', 'Step 4 — "Recruit गर्यौ = कमाउँछौ"', 'Step 5 — Pyramid collapse'],
      psychologyReasons: ['Passive income सपना', 'Success stories', 'Social pressure', 'Sunk cost', 'Top मा भएकाले कमाउँछन्'],
      preventionDetails: [
        PreventionDetail(step: 'Recruit based = Pyramid', detail: 'Nepal मा illegal।', icon: 'warning'),
        PreventionDetail(step: 'Company OCR मा verify', detail: 'ocr.gov.np।', icon: 'verify'),
        PreventionDetail(step: 'Product actual value', detail: 'Market price compare।', icon: 'calculate'),
        PreventionDetail(step: 'Income disclosure माग्नुस्', detail: '९०%+ participants ले loss।', icon: 'document'),
        PreventionDetail(step: 'Pressure मा join नगर्नुस्', detail: '"आजै" भन्ने = fraud।', icon: 'time'),
      ],
      realCase: RealCaseData(victimProfile: 'रामप्रसाद, ३५ वर्ष, चितवन', story: '"XYZ Network" Rs.२५,000 invest। ६ महिनापछि collapse। साथीसँग झगडा।', lesson: 'Recruit focus = Pyramid।', amountLost: 'Rs. २५,०००'),
      verifyTools: [VerifyToolData(name: 'OCR', url: 'ocr.gov.np', description: 'Company verify', icon: 'govt'), VerifyToolData(name: 'DoC', url: 'doc.gov.np', description: 'MLM complaint', icon: 'govt'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'Fraud', icon: 'police'), VerifyToolData(name: 'Consumer Forum', url: 'नजिकको', description: 'Consumer complaint', icon: 'legal')],
      lawDetails: LawData(mainLaw: 'प्रतिस्पर्धा प्रवर्द्धन ऐन २०६३', punishment: '२ देखि ५ वर्षसम्म', yourRights: ['DoC complaint', 'Refund'], complaintProcess: ['DoC complaint', 'Receipt राख्नुस्', 'FIR', 'Consumer Forum']),
    ),
    'fraud_028': FraudLayerContent(
      howItHappens: ['Step 1 — Unregistered taxi approach', 'Step 2 — Meter नलगाई fixed price', 'Step 3 — एक्लो ठाउँमा "थप पैसा"', 'Step 4 — Threat दिएर लिन्छ', 'Step 5 — Luggage लिएर भाग्छ'],
      psychologyReasons: ['रात्रि desperate', 'Cheap fare', 'Stranger trust', 'Plate नोट नगर्ने', 'Location share नगर्ने'],
      preventionDetails: [
        PreventionDetail(step: 'Official ride-sharing app', detail: 'Pathao, InDrive।', icon: 'app'),
        PreventionDetail(step: 'Plate number note', detail: 'परिवारलाई message।', icon: 'note'),
        PreventionDetail(step: 'Real-time location share', detail: 'WhatsApp location।', icon: 'location'),
        PreventionDetail(step: 'Meter भएको taxi मात्र', detail: 'Official tariff।', icon: 'taxi'),
        PreventionDetail(step: 'रात्रि एक्लो avoid', detail: 'Public transport।', icon: 'night'),
      ],
      realCase: RealCaseData(victimProfile: 'सरिता, २६ वर्ष, काठमाडौं', story: 'Airport बाट unregistered taxi। एक्लो road मा "Rs.5,000 दिनुस्"। Luggage लिएर भाग्यो।', lesson: 'Official app। Plate note। Location share।', amountLost: 'Rs. ३०,०००+'),
      verifyTools: [VerifyToolData(name: 'Nepal Police', url: '100', description: 'Emergency', icon: 'police'), VerifyToolData(name: 'DoT', url: 'dotm.gov.np', description: 'Taxi complaint', icon: 'govt'), VerifyToolData(name: 'Pathao', url: 'pathao.com', description: 'Safe ride', icon: 'app'), VerifyToolData(name: 'Women Helpline', url: '1145', description: 'Emergency', icon: 'women')],
      lawDetails: LawData(mainLaw: 'सवारी तथा यातायात ऐन २०४९', punishment: '१ देखि ५ वर्षसम्म', yourRights: ['Police complaint', 'Compensation'], complaintProcess: ['Police: 100', 'Plate description', 'DoT complaint', 'FIR']),
    ),
    'fraud_029': FraudLayerContent(
      howItHappens: ['Step 1 — "100% visa guarantee"', 'Step 2 — Fake visa documents', 'Step 3 — "Embassy bypass गर्छु"', 'Step 4 — Airport मा problem', 'Step 5 — Consultancy भाग्छ'],
      psychologyReasons: ['Visa complex', '"Guarantee" confidence', 'Peer pressure', 'Embassy slow', 'Professional देखिने'],
      preventionDetails: [
        PreventionDetail(step: 'Embassy directly सम्पर्क', detail: 'Official website मा info।', icon: 'embassy'),
        PreventionDetail(step: 'Visa guarantee असम्भव', detail: 'Embassy को decision।', icon: 'warning'),
        PreventionDetail(step: 'Passport आफैं राख्नुस्', detail: 'Embassy मा officially जान्छ।', icon: 'passport'),
        PreventionDetail(step: 'MoE registered consultancy', detail: 'moe.gov.np।', icon: 'verify'),
        PreventionDetail(step: 'Official fee structure', detail: 'Embassy website मा छ।', icon: 'money'),
      ],
      realCase: RealCaseData(victimProfile: 'सुजन, २३ वर्ष, पाल्पा', story: '"Japan Visa Expert" Rs.१,८०,000। Fake visa। Tokyo airport मा रोकियो।', lesson: 'Embassy directly। Guarantee = fraud।', amountLost: 'Rs. १,८०,०००'),
      verifyTools: [VerifyToolData(name: 'DoFE', url: '1180', description: 'Work visa verify', icon: 'govt'), VerifyToolData(name: 'MoFA', url: 'mofa.gov.np', description: 'Embassy contacts', icon: 'embassy'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'Fraud', icon: 'police'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Online fraud', icon: 'cyber')],
      lawDetails: LawData(mainLaw: 'वैदेशिक रोजगार ऐन २०६४', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['DoFE complaint', 'Refund', 'Fake doc मुद्दा'], complaintProcess: ['DoFE: 1180', 'Fake visa evidence', 'FIR', 'Embassy सूचित']),
    ),
    'fraud_030': FraudLayerContent(
      howItHappens: ['Step 1 — Fake form भराएर Citizenship लिन्छ', 'Step 2 — Social media बाट info collect', 'Step 3 — Stolen identity बाट bank account', 'Step 4 — Loan लिन्छ', 'Step 5 — Victim को नाममा debt'],
      psychologyReasons: ['Citizenship copy normal', 'Data misuse नबुझ्नु', 'Social media over-share', 'Privacy awareness कम', 'Phishing data theft'],
      preventionDetails: [
        PreventionDetail(step: 'Citizenship copy carefully', detail: '"Purpose: [specific]" लेखेर sign गर्नुस्।', icon: 'document'),
        PreventionDetail(step: 'Social media privacy', detail: 'DOB, address, family public नराख्नुस्।', icon: 'privacy'),
        PreventionDetail(step: 'Unknown form fill नगर्नुस्', detail: 'Purpose verify गर्नुस्।', icon: 'warning'),
        PreventionDetail(step: 'CIB credit check', detail: 'cibnepal.org.np।', icon: 'check'),
        PreventionDetail(step: 'Strong password + 2FA', detail: 'Password manager use।', icon: 'security'),
      ],
      realCase: RealCaseData(victimProfile: 'कृष्ण, ४५ वर्ष, भक्तपुर', story: 'Citizenship copy लियो। ६ महिनापछि "Rs.५,00,000 loan overdue" notice। Loan नै लिएका थिएनन्।', lesson: 'Citizenship copy carefully। Purpose लेखेर दिनुस्।', amountLost: 'Rs. ५,००,०००+'),
      verifyTools: [VerifyToolData(name: 'CIB Nepal', url: 'cibnepal.org.np', description: 'Credit check', icon: 'bank'), VerifyToolData(name: 'NRB', url: '1414', description: 'Identity fraud', icon: 'bank'), VerifyToolData(name: 'Cyber Bureau', url: '1177', description: 'Data theft', icon: 'cyber'), VerifyToolData(name: 'Nepal Police', url: '100', description: 'FIR', icon: 'police')],
      lawDetails: LawData(mainLaw: 'मुलुकी अपराध संहिता २०७४', punishment: '३ देखि ७ वर्षसम्म', yourRights: ['NRB loan dispute', 'Compensation', 'Account close'], complaintProcess: ['NRB: 1414', 'Bank complaint', 'Cyber Bureau: 1177', 'FIR + Legal aid']),
    ),
  };
}
