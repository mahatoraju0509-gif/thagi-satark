class AgencyModel {
  final String id;
  final String nameNp;
  final String nameEn;
  final String type;
  final String licenseNumber;
  final bool isRegistered;
  final bool isBlacklisted;
  final String registeredWith;
  final String address;
  final String phone;
  final String website;
  final String established;
  final String? blacklistReason;
  final List<String> destinations;
  final List<String> countries;
  final List<String> areasCovered;
  final String workersSent;
  final String totalMembers;
  final String totalSavings;
  final String totalPolicies;
  final String claimRatio;
  final String successRate;
  final String branches;
  final String atms;
  final String transactions;

  const AgencyModel({
    required this.id,
    required this.nameNp,
    required this.nameEn,
    required this.type,
    required this.licenseNumber,
    required this.isRegistered,
    required this.isBlacklisted,
    required this.registeredWith,
    required this.address,
    required this.phone,
    this.website = '',
    this.established = '',
    this.blacklistReason,
    this.destinations = const [],
    this.countries = const [],
    this.areasCovered = const [],
    this.workersSent = '',
    this.totalMembers = '',
    this.totalSavings = '',
    this.totalPolicies = '',
    this.claimRatio = '',
    this.successRate = '',
    this.branches = '',
    this.atms = '',
    this.transactions = '',
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) => AgencyModel(
    id: json['id'] as String,
    nameNp: json['name_np'] as String,
    nameEn: json['name_en'] as String,
    type: json['type'] as String,
    licenseNumber: json['license_number'] as String,
    isRegistered: json['is_registered'] as bool,
    isBlacklisted: json['is_blacklisted'] as bool,
    registeredWith: json['registered_with'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    website: json['website'] as String? ?? '',
    established: json['established'] as String? ?? '',
    blacklistReason: json['blacklist_reason'] as String?,
    destinations: json['destinations'] != null
        ? List<String>.from(json['destinations'] as List)
        : [],
    countries: json['countries'] != null
        ? List<String>.from(json['countries'] as List)
        : [],
    areasCovered: json['areas_covered'] != null
        ? List<String>.from(json['areas_covered'] as List)
        : [],
    workersSent: json['workers_sent'] as String? ?? '',
    totalMembers: json['total_members'] as String? ?? '',
    totalSavings: json['total_savings'] as String? ?? '',
    totalPolicies: json['total_policies'] as String? ?? '',
    claimRatio: json['claim_ratio'] as String? ?? '',
    successRate: json['success_rate'] as String? ?? '',
    branches: json['branches'] as String? ?? '',
    atms: json['atms'] as String? ?? '',
    transactions: json['transactions'] as String? ?? '',
  );
}
