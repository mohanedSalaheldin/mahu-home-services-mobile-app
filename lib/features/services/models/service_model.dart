class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String serviceType;
  final String subType;
  final double basePrice;
  final String pricingModel;
  final int duration; // in minutes
  final String image;
  final bool active;
  final String provider;
  final bool isApproved;
  final DateTime createdAt;
  final List<String> availableDays;
  final List<TimeSlot> availableSlots;
  final int v;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.serviceType,
    required this.subType,
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
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'cleaning',
      serviceType: json['serviceType'] ?? 'one-time',
      subType: json['subType'] ?? 'normal',
      basePrice: (json['basePrice'] ?? 0).toDouble(),
      pricingModel: json['pricingModel'] ?? 'fixed',
      duration: json['duration'] ?? 60,
      image: json['image'] ?? '',
      active: json['active'] ?? true,
      provider: json['provider'] is Map
          ? json['provider']['_id'] ?? ''
          : json['provider'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableSlots: (json['availableSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromJson(slot))
              .toList() ??
          [],
      v: json['__v'] ?? 0,
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
}

class TimeSlot {
  final String id;
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['_id'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
