import 'package:mahu_home_services_app/features/user_booking/models/review.dart';

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String category;
  double averageRating;
  int totalReviews;
  final String serviceType;
  final String subType;
  final double basePrice;
  final String pricingModel;
  final int duration; // in hours
  final String image;
  final bool active;
  final String provider;
  final bool isApproved;
  final DateTime createdAt;
  final List<String> availableDays;
  final List<TimeSlot> availableSlots;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? businessName;
  final String place; // new field: place where service is provided
  final List<Review> reviews;
  final int v;
  final String currency;

  /// NEW FIELD
  final List<ServiceOption> options;

  ServiceModel({
    required this.id,
    required this.name,
    this.place = '',
    required this.totalReviews,
    required this.averageRating,
    required this.description,
    required this.category,
    required this.serviceType,
    required this.subType,
    required this.basePrice,
    this.currency = 'AED',
    required this.pricingModel,
    required this.reviews,
    required this.duration,
    required this.image,
    required this.active,
    required this.provider,
    required this.isApproved,
    required this.createdAt,
    required this.availableDays,
    required this.availableSlots,
    required this.businessName,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.v,
    required this.options,
  });

  ServiceModel copyWith({
    bool? active,
    List<ServiceOption>? options,
    String? currency,
  }) {
    return ServiceModel(
      id: id,
      name: name,
      description: description,
      category: category,
      serviceType: serviceType,
      subType: subType,
      basePrice: basePrice,
      currency: currency ?? this.currency,
      pricingModel: pricingModel,
      duration: duration,
      image: image,
      active: active ?? this.active,
      provider: provider,
      isApproved: isApproved,
      availableDays: availableDays,
      availableSlots: availableSlots,
      createdAt: createdAt,
      v: v,
      averageRating: averageRating,
      reviews: reviews,
      totalReviews: totalReviews,
      businessName: businessName,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      options: options ?? this.options,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    String providerId = '';
    String? businessName;
    String? firstName;
    String? lastName;
    String? avatar;

    if (json['provider'] != null) {
      if (json['provider'] is String) {
        providerId = json['provider'];
      } else if (json['provider'] is Map<String, dynamic>) {
        final providerData = json['provider'] as Map<String, dynamic>;
        providerId = providerData['_id'] ?? '';
        businessName = providerData['businessName'];

        if (providerData['profile'] != null &&
            providerData['profile'] is Map<String, dynamic>) {
          final profileData = providerData['profile'] as Map<String, dynamic>;
          firstName = profileData['firstName'];
          lastName = profileData['lastName'];
          avatar = profileData['avatar'];
        } else {
          firstName = providerData['firstName'];
          lastName = providerData['lastName'];
          avatar = providerData['avatar'];
        }
      }
    }

    return ServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      place: json['place'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'cleaning',
      serviceType: json['serviceType'] ?? 'one-time',
      subType: json['subType'] ?? 'normal',
      basePrice: (json['basePrice'] ?? 0).toDouble(),
  currency: (json['currency'] ?? 'AED') as String,
      pricingModel: json['pricingModel'] ?? 'fixed',
      duration: json['duration'] ?? 1,
      image: json['image'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      avatar: avatar,
      businessName: businessName,
      firstName: firstName,
      lastName: lastName,
      active: json['active'] ?? true,
      provider: providerId,
      isApproved: json['isApproved'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableSlots: (json['availableSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromJson(slot))
              .toList() ??
          [],
      options: (json['options'] as List<dynamic>?)
              ?.map((opt) => ServiceOption.fromJson(opt))
              .toList() ??
          [],
      v: json['__v'] ?? 0,
      reviews: [],
    );
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

class ServiceOption {
  final String id ;
  final String name;
  final String description;
  final double price;
  final String pricingModel; // fixed | hourly | recurring
  final bool active;
  final String appliesTo; // one-time | recurring

  ServiceOption({
    required this.name,
    required this.description,
    this.id = '',
    this.price = 0.0,
    this.pricingModel = 'fixed',
    this.active = true,
    this.appliesTo = 'one-time',
  });

  factory ServiceOption.fromJson(Map<String, dynamic> json) {
    return ServiceOption(
      name: json['name'] ?? '',
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      pricingModel: json['pricingModel'] ?? 'fixed',
      active: json['active'] ?? true,
      appliesTo: json['appliesTo'] ?? 'one-time',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'pricingModel': pricingModel,
      'active': active,
      'appliesTo': appliesTo,
    };
  }
}
