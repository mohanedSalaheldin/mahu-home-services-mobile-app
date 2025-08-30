// user_booking_model.dart
class UserBookingModel {
  final String service;
  final double price;
  final ScheduleModel schedule;
  final AddressModel address;
  final String? details;
  final int duration;
  final bool hasTools;

  UserBookingModel({
    required this.service,
    required this.price,
    required this.schedule,
    required this.address,
    this.details,
    required this.duration, 
    required this.hasTools,
  });

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'price': price,
      'duration': duration,
      'schedule': schedule.toJson(),
      'address': address.toJson(),
      'hasTools': hasTools,
      if (details != null) 'details': details,
    };
  }
}

class ScheduleModel {
  final String dayOfWeek;
  final String startTime;
  final String? endTime;
  final String? recurrence;
  final String? recurrenceEndDate;
  final String? timezone;
  final String? startDate;

  ScheduleModel({
    required this.dayOfWeek,
    required this.startTime,
    this.endTime,
    this.recurrence,
    this.recurrenceEndDate,
    this.timezone,
    this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (recurrence != null) 'recurrence': recurrence,
      if (recurrenceEndDate != null) 'recurrenceEndDate': recurrenceEndDate,
      if (timezone != null) 'timezone': timezone,
      if (startDate != null) 'startDate': startDate,
    };
  }
}

class AddressModel {
  final String street;
  final String city;
  final String state;
  final String? zipCode;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    this.zipCode,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      if (zipCode != null) 'zipCode': zipCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}