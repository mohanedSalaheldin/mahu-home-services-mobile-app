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
  final List<Review> reviews;
  final int v;

  ServiceModel({
    required this.id,
    required this.name,
    required this.totalReviews,
    required this.averageRating,
    required this.description,
    required this.category,
    required this.serviceType,
    required this.subType,
    required this.basePrice,
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
  });

  // In your ServiceModel class
  ServiceModel copyWith({
    bool? active,
    // Add other fields as needed
  }) {
    return ServiceModel(
      id: id,
      name: name,
      description: description,
      category: category,
      serviceType: serviceType,
      subType: subType,
      basePrice: basePrice,
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
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    // Handle provider data based on the actual response structure
    String providerId = '';
    String? businessName;
    String? firstName;
    String? lastName;
    String? avatar;

    if (json['provider'] != null) {
      if (json['provider'] is String) {
        // If provider is just an ID string
        providerId = json['provider'];
      } else if (json['provider'] is Map<String, dynamic>) {
        final providerData = json['provider'] as Map<String, dynamic>;
        providerId = providerData['_id'] ?? '';
        businessName = providerData['businessName'];

        // Check if profile data exists in the response
        if (providerData['profile'] != null &&
            providerData['profile'] is Map<String, dynamic>) {
          final profileData = providerData['profile'] as Map<String, dynamic>;
          firstName = profileData['firstName'];
          lastName = profileData['lastName'];
          avatar = profileData['avatar'];
        } else {
          // If no profile data, try to get from top level or use defaults
          firstName = providerData['firstName'];
          lastName = providerData['lastName'];
          avatar = providerData['avatar'];
        }
      }
    }

    return ServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'cleaning',
      serviceType: json['serviceType'] ?? 'one-time',
      subType: json['subType'] ?? 'normal',
      basePrice: (json['basePrice'] ?? 0).toDouble(),
      pricingModel: json['pricingModel'] ?? 'fixed',
      duration: json['duration'] ?? 1,
      image: json['image'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      avatar: avatar, // Use the extracted avatar
      businessName: businessName, // Use the extracted businessName
      firstName: firstName, // Use the extracted firstName
      lastName: lastName, // Use the extracted lastName
      active: json['active'] ?? true,
      provider: providerId, // Use the extracted provider ID
      isApproved: json['isApproved'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableSlots: (json['availableSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromJson(slot))
              .toList() ??
          [],
      v: json['__v'] ?? 0, reviews: [],
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
