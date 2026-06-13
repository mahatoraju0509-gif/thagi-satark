class ReportModel {
  final String id;
  final String fraudType;
  final String descriptionNp;
  final String district;
  final String? photoUrl;
  final bool isAnonymous;
  final String? reporterName;
  final int verificationCount;
  final DateTime createdAt;

  const ReportModel({
    required this.id,
    required this.fraudType,
    required this.descriptionNp,
    required this.district,
    this.photoUrl,
    required this.isAnonymous,
    this.reporterName,
    this.verificationCount = 0,
    required this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    id: json['id'] as String,
    fraudType: json['fraud_type'] as String,
    descriptionNp: json['description_np'] as String,
    district: json['district'] as String,
    photoUrl: json['photo_url'] as String?,
    isAnonymous: json['is_anonymous'] as bool,
    reporterName: json['reporter_name'] as String?,
    verificationCount: json['verification_count'] as int? ?? 0,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fraud_type': fraudType,
    'description_np': descriptionNp,
    'district': district,
    'photo_url': photoUrl,
    'is_anonymous': isAnonymous,
    'reporter_name': reporterName,
    'verification_count': verificationCount,
    'created_at': createdAt.toIso8601String(),
  };
}
