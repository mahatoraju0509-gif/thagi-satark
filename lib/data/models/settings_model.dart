class SettingsModel {
  final String selectedDistrict;
  final bool isNepali;
  final bool notificationsEnabled;
  final bool districtAlertsEnabled;
  final bool onboardingComplete;
  final bool disclaimerAccepted;

  const SettingsModel({
    this.selectedDistrict = 'काठमाडौं',
    this.isNepali = true,
    this.notificationsEnabled = true,
    this.districtAlertsEnabled = true,
    this.onboardingComplete = false,
    this.disclaimerAccepted = false,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    selectedDistrict: json['selected_district'] as String? ?? 'काठमाडौं',
    isNepali: json['is_nepali'] as bool? ?? true,
    notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
    districtAlertsEnabled: json['district_alerts_enabled'] as bool? ?? true,
    onboardingComplete: json['onboarding_complete'] as bool? ?? false,
    disclaimerAccepted: json['disclaimer_accepted'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'selected_district': selectedDistrict,
    'is_nepali': isNepali,
    'notifications_enabled': notificationsEnabled,
    'district_alerts_enabled': districtAlertsEnabled,
    'onboarding_complete': onboardingComplete,
    'disclaimer_accepted': disclaimerAccepted,
  };

  SettingsModel copyWith({
    String? selectedDistrict,
    bool? isNepali,
    bool? notificationsEnabled,
    bool? districtAlertsEnabled,
    bool? onboardingComplete,
    bool? disclaimerAccepted,
  }) {
    return SettingsModel(
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      isNepali: isNepali ?? this.isNepali,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      districtAlertsEnabled:
          districtAlertsEnabled ?? this.districtAlertsEnabled,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      disclaimerAccepted: disclaimerAccepted ?? this.disclaimerAccepted,
    );
  }
}
