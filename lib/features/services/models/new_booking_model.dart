// booking_model.dart
// 'foundation' import removed - not needed here

class BookingNewModel {
  final String id;
  final String userId;
  final Service service;
  final Provider provider;
  final String serviceType;
  final Schedule schedule;
  final Address address;
  final String status;
  final double price;
  final String paymentStatus;
  final DateTime? confirmedAt;
  final DateTime? respondedAt;
  final DateTime bookingDate;
  final String dayOfWeek;
  final int duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? details;

  BookingNewModel({
    required this.id,
    required this.userId,
    required this.service,
    required this.provider,
    required this.serviceType,
    required this.schedule,
    required this.address,
    required this.status,
    required this.price,
    required this.paymentStatus,
    this.confirmedAt,
    this.respondedAt,
    required this.bookingDate,
    required this.dayOfWeek,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    this.details,
  });

  factory BookingNewModel.fromJson(Map<String, dynamic> json) {
    return BookingNewModel(
      id: json['_id'] ?? json['id'] ?? '',
      userId: _parseUserId(json['user']),
      service: Service.fromJson(_parseService(json['service'])),
      provider: Provider.fromJson(_parseProvider(json['provider'])),
      serviceType: json['serviceType'] ?? '',
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      status: json['status'] ?? 'pending',
      price: _parseDouble(json['price']),
      paymentStatus: json['paymentStatus'] ?? 'pending',
      confirmedAt: _parseDateTime(json['confirmedAt']),
      respondedAt: _parseDateTime(json['respondedAt']),
      bookingDate: _parseDateTime(json['bookingDate']) ?? DateTime.now(),
      dayOfWeek: json['dayOfWeek'] ?? '',
      duration: _parseInt(json['duration']),
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(json['updatedAt']) ?? DateTime.now(),
      details: json['details'],
    );
  }

  static String _parseUserId(dynamic user) {
    if (user is String) return user;
    if (user is Map<String, dynamic>) return user['_id'] ?? user['id'] ?? '';
    return '';
  }

  static Map<String, dynamic> _parseService(dynamic service) {
    if (service is Map<String, dynamic>) return service;
    if (service is String) return {'_id': service, 'name': 'Unknown Service'};
    return {'_id': '', 'name': 'Unknown Service'};
  }

  static Map<String, dynamic> _parseProvider(dynamic provider) {
    if (provider is Map<String, dynamic>) return provider;
    return {
      '_id': '',
      'profile': {'firstName': '', 'lastName': '', 'avatar': ''}
    };
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

class Service {
  final String id;
  final String name;
  final String currency;

  Service({required this.id, required this.name, this.currency = 'AED'});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? 'Unknown Service',
      currency: json['currency'] ?? json['currencyCode'] ?? 'AED',
    );
  }
}

class Provider {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;

  Provider({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    final profile =
        json['profile'] is Map<String, dynamic> ? json['profile'] : {};
    return Provider(
      id: json['_id'] ?? json['id'] ?? '',
      firstName: profile['firstName'] ?? '',
      lastName: profile['lastName'] ?? '',
      avatar: profile['avatar'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName'.trim();
}

class Schedule {
  final DateTime startDate;
  final DateTime? endDate;
  final String startTime;
  final String endTime;
  final List<DateTime> excludedDates;
  final String id;

  Schedule({
    required this.startDate,
    this.endDate,
    required this.startTime,
    required this.endTime,
    required this.excludedDates,
    required this.id,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      startDate:
          DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      excludedDates: (json['excludedDates'] as List<dynamic>? ?? [])
          .map((e) => DateTime.parse(e))
          .toList(),
      id: json['_id'] ?? json['id'] ?? '',
    );
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String? zipCode;
  final List<double> coordinates;

  Address({
    required this.street,
    required this.city,
    required this.state,
    this.zipCode,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'],
      coordinates: (json['coordinates'] as List<dynamic>? ?? [])
          .map((e) {
            if (e is double) return e;
            if (e is int) return e.toDouble();
            if (e is String) return double.tryParse(e) ?? 0.0;
            return 0.0;
          }).toList(),
    );
  }
}
