class AlertModel {
  final String id;
  final String titleNp;
  final String descriptionNp;
  final String district;
  final String severity;
  final String fraudType;
  final DateTime createdAt;
  final bool isRead;

  const AlertModel({
    required this.id,
    required this.titleNp,
    required this.descriptionNp,
    required this.district,
    required this.severity,
    required this.fraudType,
    required this.createdAt,
    this.isRead = false,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
    id: json['id'] as String,
    titleNp: json['title_np'] as String,
    descriptionNp: json['description_np'] as String,
    district: json['district'] as String,
    severity: json['severity'] as String,
    fraudType: json['fraud_type'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    isRead: json['is_read'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title_np': titleNp,
    'description_np': descriptionNp,
    'district': district,
    'severity': severity,
    'fraud_type': fraudType,
    'created_at': createdAt.toIso8601String(),
    'is_read': isRead,
  };
}
