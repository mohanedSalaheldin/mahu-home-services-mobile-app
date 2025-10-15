class Plan {
  final String id;
  final String name;
  final String description;
  final double price;
  final int? duration;
  final List<String> features;
  final bool isActive;
  final int? periodInDays;
  final double? percentage;
  final int? maxServices;
  final int? maxEmployees;
  final int? maxBookings;
  final int? maxExports;
  final int? maxPlatformAds;
  final int? maxSocialMediaAds;
  final int? maxWorkingCities;
  final bool? multicountriesAllowed;
  final bool? onlinePaymentAllowed;
  final String? subscriptionLogo;
  final DateTime createdAt;
  final int? subscriptionsCount;
  final bool? isExpired;
  final int? daysUntilExpiration;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
    required this.features,
    required this.createdAt,
    this.duration,
    this.periodInDays,
    this.percentage,
    this.maxServices,
    this.maxEmployees,
    this.maxBookings,
    this.maxExports,
    this.maxPlatformAds,
    this.maxSocialMediaAds,
    this.maxWorkingCities,
    this.multicountriesAllowed,
    this.onlinePaymentAllowed,
    this.subscriptionLogo,
    this.subscriptionsCount,
    this.isExpired,
    this.daysUntilExpiration,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] as int?,
      features: List<String>.from(json['features'] ?? []),
      isActive: json['isActive'] ?? false,
      periodInDays: json['periodInDays'] as int?,
      percentage: json['percentage'] != null
          ? (json['percentage'] as num).toDouble()
          : null,
      maxServices: json['maxServices'] as int?,
      maxEmployees: json['maxEmployees'] as int?,
      maxBookings: json['maxBookings'] as int?,
      maxExports: json['maxExports'] as int?,
      maxPlatformAds: json['maxPlatformAds'] as int?,
      maxSocialMediaAds: json['maxSocialMediaAds'] as int?,
      maxWorkingCities: json['maxWorkingCities'] as int?,
      multicountriesAllowed: json['multicountriesAllowed'] as bool?,
      onlinePaymentAllowed: json['onlinePaymentAllowed'] as bool?,
      subscriptionLogo: json['subscriptionLogo'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      subscriptionsCount: json['subscriptionsCount'] as int?,
      isExpired: json['isExpired'] as bool?,
      daysUntilExpiration: json['daysUntilExpiration'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'features': features,
      'isActive': isActive,
      'periodInDays': periodInDays,
      'percentage': percentage,
      'maxServices': maxServices,
      'maxEmployees': maxEmployees,
      'maxBookings': maxBookings,
      'maxExports': maxExports,
      'maxPlatformAds': maxPlatformAds,
      'maxSocialMediaAds': maxSocialMediaAds,
      'maxWorkingCities': maxWorkingCities,
      'multicountriesAllowed': multicountriesAllowed,
      'onlinePaymentAllowed': onlinePaymentAllowed,
      'subscriptionLogo': subscriptionLogo,
      'createdAt': createdAt.toIso8601String(),
      'subscriptionsCount': subscriptionsCount,
      'isExpired': isExpired,
      'daysUntilExpiration': daysUntilExpiration,
    };
  }
}