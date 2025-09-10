// booking_model.dart

class BookingModel {
  final String id;
  final AppUser user;
  final Service service;
  final String provider;
  final String serviceType;
  final Schedule? schedule; // Changed from nullable to required
  final String? details;
  late final String status;
  final int duration; // Changed from String to int
  final double price;
  final String paymentStatus;
  final DateTime? confirmedAt;
  final DateTime? respondedAt;
  final DateTime bookingDate;
  final String dayOfWeek;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v;
  final Address address; // Changed from nullable to required
  final Option option; // Added Option field

  BookingModel({
    required this.id,
    required this.user,
    required this.service,
    required this.provider,
    required this.serviceType,
    this.schedule,
    this.details,
    required this.status,
    required this.duration,
    required this.price,
    required this.paymentStatus,
    this.confirmedAt,
    this.respondedAt,
    required this.bookingDate,
    required this.dayOfWeek,
    required this.createdAt,
    required this.updatedAt,
    this.v,
    required this.address,
    required this.option,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: (json['id'] ?? json['_id']) as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      provider: json['provider'] as String,
      serviceType: json['serviceType'] as String,
      schedule: json['schedule'] != null
          ? Schedule.fromJson(json['schedule'] as Map<String, dynamic>)
          : Schedule(
              id: '', excludedDates: []), // Provide default empty schedule
      details: json['details'] as String?,
      status: json['status'] as String,
      duration: (json['duration'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'] as String)
          : null,
      respondedAt: json['respondedAt'] != null
          ? DateTime.parse(json['respondedAt'] as String)
          : null,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      dayOfWeek: json['dayOfWeek'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      option: Option.fromJson(json['options'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'service': service.toJson(),
      'provider': provider,
      'serviceType': serviceType,
      'schedule': schedule?.toJson(),
      'details': details,
      'status': status,
      'duration': duration,
      'price': price,
      'paymentStatus': paymentStatus,
      'confirmedAt': confirmedAt?.toIso8601String(),
      'respondedAt': respondedAt?.toIso8601String(),
      'bookingDate': bookingDate.toIso8601String(),
      'dayOfWeek': dayOfWeek,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'address': address.toJson(),
      'options': option.toJson(),
      'id': id,
    };
  }

  BookingModel copyWith({
    String? id,
    AppUser? user,
    Service? service,
    String? provider,
    String? serviceType,
    Schedule? schedule,
    String? details,
    String? status,
    int? duration,
    double? price,
    String? paymentStatus,
    DateTime? confirmedAt,
    DateTime? respondedAt,
    DateTime? bookingDate,
    String? dayOfWeek,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    Address? address,
    Option? option,
  }) {
    return BookingModel(
      id: id ?? this.id,
      user: user ?? this.user,
      service: service ?? this.service,
      provider: provider ?? this.provider,
      serviceType: serviceType ?? this.serviceType,
      schedule: schedule ?? this.schedule,
      details: details ?? this.details,
      status: status ?? this.status,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      bookingDate: bookingDate ?? this.bookingDate,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      address: address ?? this.address,
      option: option ?? this.option,
    );
  }
}

// Add the Option class
class Option {
  final bool hasTools;

  Option({
    required this.hasTools,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      hasTools: json['hasTools'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasTools': hasTools,
    };
  }
}

class AppUser {
  final String id;
  final UserProfile profile;
  final String email;
  final String phone;
  final String role;
  final String? businessName;
  final String? businessRegistration;
  final List<String> services;
  final bool isVerified;
  final String? serviceProviderCategory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v;

  AppUser({
    required this.id,
    required this.profile,
    required this.email,
    required this.phone,
    required this.role,
    this.businessName,
    this.businessRegistration,
    required this.services,
    required this.isVerified,
    this.serviceProviderCategory,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: (json['id'] ?? json['_id']) as String,
      profile: UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      businessName: json['businessName'] as String?,
      businessRegistration: json['businessRegistration'] as String?,
      services: (json['services'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      isVerified: json['isVerified'] as bool? ?? false,
      serviceProviderCategory: json['serviceProviderCategory'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profile': profile.toJson(),
      'email': email,
      'phone': phone,
      'role': role,
      'businessName': businessName,
      'businessRegistration': businessRegistration,
      'services': services,
      'isVerified': isVerified,
      'serviceProviderCategory': serviceProviderCategory,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'id': id,
    };
  }
}

class UserProfile {
  final String firstName;
  final String lastName;
  final String? avatar;

  UserProfile({
    required this.firstName,
    required this.lastName,
    this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }
}

class Service {
  final String id;
  final String name;
  final String description;
  final String category;
  final String serviceType;
  final String subType;
  final double basePrice;
  final String pricingModel;
  final int duration;
  final String image;
  final bool active;
  final String provider;
  final bool isApproved;
  final List<String> availableDays;
  final List<AvailableSlot> availableSlots;
  final DateTime createdAt;
  final int? v;
  final double averageRating;
  final List<Review> reviews;
  final int totalReviews;

  Service({
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
    required this.availableDays,
    required this.availableSlots,
    required this.createdAt,
    this.v,
    required this.averageRating,
    required this.reviews,
    required this.totalReviews,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: (json['id'] ?? json['_id']) as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      serviceType: json['serviceType'] as String,
      subType: json['subType'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      pricingModel: json['pricingModel'] as String,
      duration: (json['duration'] as num).toInt(),
      image: json['image'] as String,
      active: json['active'] as bool? ?? false,
      provider: json['provider'] as String,
      isApproved: json['isApproved'] as bool? ?? false,
      availableDays: (json['availableDays'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      availableSlots: (json['availableSlots'] as List<dynamic>? ?? const [])
          .map((e) => AvailableSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviews: (json['reviews'] as List<dynamic>? ?? const [])
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
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
      'availableDays': availableDays,
      'availableSlots': availableSlots.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
      'averageRating': averageRating,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'totalReviews': totalReviews,
      'id': id,
    };
  }
}

class AvailableSlot {
  final String startTime;
  final String endTime;
  final String id;

  AvailableSlot({
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  factory AvailableSlot.fromJson(Map<String, dynamic> json) {
    return AvailableSlot(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      id: (json['id'] ?? json['_id']) as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      '_id': id,
      'id': id,
    };
  }
}

class Schedule {
  final String id;
  final DateTime? startDate; // Make nullable
  final DateTime? endDate; // Make nullable
  final String? startTime; // Make nullable
  final String? endTime; // Make nullable
  final List<dynamic> excludedDates;

  Schedule({
    required this.id,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    required this.excludedDates,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: (json['id'] ?? json['_id'] ?? '') as String,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      excludedDates: json['excludedDates'] as List<dynamic>? ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'id': id,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'excludedDates': excludedDates,
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final List<double> coordinates;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
      coordinates: (json['coordinates'] as List<dynamic>? ?? const [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'coordinates': coordinates,
    };
  }
}

// Add Review class
class Review {
  final String user;
  final String userName;
  final int rating;
  final String feedback;
  final String id;
  final DateTime createdAt;

  Review({
    required this.user,
    required this.userName,
    required this.rating,
    required this.feedback,
    required this.id,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json['user'] as String,
      userName: json['userName'] as String,
      rating: (json['rating'] as num).toInt(),
      feedback: json['feedback'] as String,
      id: (json['id'] ?? json['_id']) as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'userName': userName,
      'rating': rating,
      'feedback': feedback,
      '_id': id,
      'id': id,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
