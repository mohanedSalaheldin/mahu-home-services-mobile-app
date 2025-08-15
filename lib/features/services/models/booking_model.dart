// booking_model.dart

class BookingModel {
  final String id;
  final AppUser user;
  final Service service;
  final String provider;
  final String serviceType;
  final Schedule? schedule;
  final String? details;
  final String status;
  final double price;
  final String paymentStatus;
  final DateTime createdAt;
  final int? v;
  final Address? address; // ✅ new

  BookingModel({
    required this.id,
    required this.user,
    required this.service,
    required this.provider,
    required this.serviceType,
    this.schedule,
    this.details,
    required this.status,
    required this.price,
    required this.paymentStatus,
    required this.createdAt,
    this.v,
    this.address, // ✅ new
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
          : null,
      details: json['details'] as String?,
      status: json['status'] as String,
      price: (json['price'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null, // ✅ handle address
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
      'price': price,
      'paymentStatus': paymentStatus,
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
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
    double? price,
    String? paymentStatus,
    DateTime? createdAt,
    int? v,
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
      price: price ?? this.price,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
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
  final DateTime startDate;
  final DateTime? endDate; // make nullable
  final String? recurrence; // support recurrence

  Schedule({
    required this.id,
    required this.startDate,
    this.endDate,
    this.recurrence,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: (json['id'] ?? json['_id'] ?? '') as String,
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      recurrence: json['recurrence'] as String?, // <--
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'recurrence': recurrence,
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }
}

