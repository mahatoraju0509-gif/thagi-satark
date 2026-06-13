class LegalStepModel {
  final String id;
  final String fraudType;
  final int stepNumber;
  final String titleNp;
  final String descriptionNp;
  final String officeName;
  final String officeAddress;
  final String officePhone;
  final List<String> requiredDocuments;
  final String estimatedTime;

  const LegalStepModel({
    required this.id,
    required this.fraudType,
    required this.stepNumber,
    required this.titleNp,
    required this.descriptionNp,
    required this.officeName,
    required this.officeAddress,
    required this.officePhone,
    required this.requiredDocuments,
    required this.estimatedTime,
  });

  factory LegalStepModel.fromJson(Map<String, dynamic> json) => LegalStepModel(
    id: json['id'] as String,
    fraudType: json['fraud_type'] as String,
    stepNumber: json['step_number'] as int,
    titleNp: json['title_np'] as String,
    descriptionNp: json['description_np'] as String,
    officeName: json['office_name'] as String,
    officeAddress: json['office_address'] as String,
    officePhone: json['office_phone'] as String,
    requiredDocuments:
        List<String>.from(json['required_documents'] as List),
    estimatedTime: json['estimated_time'] as String,
  );
}
