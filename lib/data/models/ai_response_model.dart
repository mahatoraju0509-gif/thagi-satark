class AiResponseModel {
  final bool isFraud;
  final String fraudType;
  final int riskScore;
  final int confidenceScore;
  final String severity;
  final String resultNp;
  final String fraudTitle;
  final String fraudDescription;
  final List<String> redFlags;
  final List<String> preventionSteps;
  final List<String> helplines;
  final String lawReference;
  final List<String> detectedPatterns;
  final List<String> followUpQuestions;
  final String advice;

  const AiResponseModel({
    required this.isFraud,
    required this.fraudType,
    required this.riskScore,
    required this.confidenceScore,
    required this.severity,
    required this.resultNp,
    required this.fraudTitle,
    required this.fraudDescription,
    required this.redFlags,
    required this.preventionSteps,
    required this.helplines,
    required this.lawReference,
    required this.detectedPatterns,
    required this.followUpQuestions,
    required this.advice,
  });
}
