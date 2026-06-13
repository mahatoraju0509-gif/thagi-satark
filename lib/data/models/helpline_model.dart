class HelplineModel {
  final String id;
  final String nameNp;
  final String nameEn;
  final String phoneNumber;
  final String category;
  final String descriptionNp;
  final bool isEmergency;
  final bool is24Hours;

  const HelplineModel({
    required this.id,
    required this.nameNp,
    required this.nameEn,
    required this.phoneNumber,
    required this.category,
    required this.descriptionNp,
    required this.isEmergency,
    required this.is24Hours,
  });

  factory HelplineModel.fromJson(Map<String, dynamic> json) => HelplineModel(
    id: json['id'] as String,
    nameNp: json['name_np'] as String,
    nameEn: json['name_en'] as String,
    phoneNumber: json['phone_number'] as String,
    category: json['category'] as String,
    descriptionNp: json['description_np'] as String,
    isEmergency: json['is_emergency'] as bool,
    is24Hours: json['is_24_hours'] as bool,
  );
}
