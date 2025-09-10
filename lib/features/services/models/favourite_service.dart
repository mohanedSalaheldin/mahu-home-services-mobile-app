class BookingServiceModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String serviceType;
  final String? subType;
  final double basePrice;
  final String pricingModel;
  final int duration;
  final String image;
  final bool active;
  final String provider;
  final bool isApproved;
  final DateTime createdAt;
  final List<String> availableDays;
  final List<TimeSlot> availableSlots;
  final int v;

  // Provider details (nested object)
  final String? providerAvatar;
  final String? providerFirstName;
  final String? providerLastName;
  final String? providerBusinessName;
  final String? providerCategory;

  BookingServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.serviceType,
    this.subType,
    required this.basePrice,
    required this.pricingModel,
    required this.duration,
    required this.image,
    required this.active,
    required this.provider,
    required this.isApproved,
    required this.createdAt,
    required this.availableDays,
    required this.availableSlots,
    required this.v,
    this.providerAvatar,
    this.providerFirstName,
    this.providerLastName,
    this.providerBusinessName,
    this.providerCategory,
  });

  factory BookingServiceModel.fromJson(Map<String, dynamic> json) {
    // Extract provider data if it exists
    final providerData = json['provider'] is Map<String, dynamic>
        ? json['provider'] as Map<String, dynamic>
        : null;

    return BookingServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      serviceType: json['serviceType'] ?? '',
      subType: json['subType'],
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      pricingModel: json['pricingModel'] ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      image: json['image'] ?? '',
      active: json['active'] ?? false,
      provider: json['provider'] is String
          ? json['provider']
          : providerData?['_id'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableSlots: (json['availableSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromJson(slot))
              .toList() ??
          [],
      v: (json['__v'] as num?)?.toInt() ?? 0,
      providerAvatar: providerData?['avatar'],
      providerFirstName: providerData?['firstName'],
      providerLastName: providerData?['lastName'],
      providerBusinessName: providerData?['businessName'],
      providerCategory: providerData?['serviceProviderCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'category': category,
      'serviceType': serviceType,
      'subType': subType,
      'basePrice': basePrice,
      'pricingModel': pricingModel,
      'duration': duration,
      'image': image,
      'active': active,
      'provider': provider,
      'isApproved': isApproved,
      'createdAt': createdAt.toIso8601String(),
      'availableDays': availableDays,
      'availableSlots': availableSlots.map((slot) => slot.toJson()).toList(),
      '__v': v,
    };
  }

  // Helper getters for backward compatibility
  String get avatar => providerAvatar ?? '';
  String get firstName => providerFirstName ?? '';
  String get lastName => providerLastName ?? '';
  String get businessName => providerBusinessName ?? '';
}

class TimeSlot {
  final String startTime;
  final String endTime;
  final String? id;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    this.id,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      if (id != null) '_id': id,
    };
  }
}
