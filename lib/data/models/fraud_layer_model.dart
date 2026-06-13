class FraudLayerModel {
  final String fraudId;
  final String whatIsItNp;
  final String howItHappensNp;
  final String psychologyNp;
  final List<String> redFlags;
  final List<String> preventionSteps;
  final List<String> recoverySteps;
  final String realCaseStoryNp;
  final String statisticsNp;
  final String verifyToolsNp;
  final String lawsRightsNp;
  final String conclusionNp;

  const FraudLayerModel({
    required this.fraudId,
    required this.whatIsItNp,
    required this.howItHappensNp,
    required this.psychologyNp,
    required this.redFlags,
    required this.preventionSteps,
    required this.recoverySteps,
    required this.realCaseStoryNp,
    required this.statisticsNp,
    required this.verifyToolsNp,
    required this.lawsRightsNp,
    required this.conclusionNp,
  });

  factory FraudLayerModel.fromJson(Map<String, dynamic> json) =>
      FraudLayerModel(
        fraudId: json['fraud_id'] as String,
        whatIsItNp: json['what_is_it_np'] as String,
        howItHappensNp: json['how_it_happens_np'] as String,
        psychologyNp: json['psychology_np'] as String,
        redFlags: List<String>.from(json['red_flags'] as List),
        preventionSteps: List<String>.from(json['prevention_steps'] as List),
        recoverySteps: List<String>.from(json['recovery_steps'] as List),
        realCaseStoryNp: json['real_case_story_np'] as String,
        statisticsNp: json['statistics_np'] as String,
        verifyToolsNp: json['verify_tools_np'] as String,
        lawsRightsNp: json['laws_rights_np'] as String,
        conclusionNp: json['conclusion_np'] as String,
      );
}
