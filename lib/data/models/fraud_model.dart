class FraudModel {
  final String id;
  final String titleNp;
  final String titleEn;
  final String descriptionNp;
  final String iconPath;
  final String severity;
  final String category;
  final int reportCount;
  final List<String> redFlags;
  final List<String> preventionSteps;
  final List<String> recoverySteps;
  final String lawReference;
  final List<String> helplineNumbers;
  final String conclusionNp;

  const FraudModel({
    required this.id,
    required this.titleNp,
    required this.titleEn,
    required this.descriptionNp,
    this.iconPath = '',
    required this.severity,
    required this.category,
    required this.reportCount,
    required this.redFlags,
    required this.preventionSteps,
    required this.recoverySteps,
    required this.lawReference,
    required this.helplineNumbers,
    required this.conclusionNp,
  });

  factory FraudModel.fromJson(Map<String, dynamic> json) => FraudModel(
    id: json['id'] as String? ?? '',
    titleNp: json['title_np'] as String? ?? '',
    titleEn: json['title_en'] as String? ?? '',
    descriptionNp: json['description_np'] as String? ?? '',
    iconPath: json['icon_path'] as String? ?? '',
    severity: json['severity'] as String? ?? 'medium',
    category: json['category'] as String? ?? 'digital',
    reportCount: json['report_count'] as int? ?? 0,
    redFlags: json['red_flags'] != null ? List<String>.from(json['red_flags'] as List) : [],
    preventionSteps: json['prevention_steps'] != null ? List<String>.from(json['prevention_steps'] as List) : [],
    recoverySteps: json['recovery_steps'] != null ? List<String>.from(json['recovery_steps'] as List) : [],
    lawReference: json['law_reference'] as String? ?? '',
    helplineNumbers: json['helpline_numbers'] != null ? List<String>.from(json['helpline_numbers'] as List) : [],
    conclusionNp: json['conclusion_np'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title_np': titleNp,
    'title_en': titleEn,
    'description_np': descriptionNp,
    'icon_path': iconPath,
    'severity': severity,
    'category': category,
    'report_count': reportCount,
    'red_flags': redFlags,
    'prevention_steps': preventionSteps,
    'recovery_steps': recoverySteps,
    'law_reference': lawReference,
    'helpline_numbers': helplineNumbers,
    'conclusion_np': conclusionNp,
  };
}
