// Update your UserBookingModel
class UserBookingModel {
  final String service;
  final ScheduleModel schedule;
  final AddressModel address;
  final String? details;
  final double price; // Add price field

  UserBookingModel({
    required this.service,
    required this.schedule,
    required this.address,
    this.details,
    required this.price, // Add price parameter
  });
}

// Update ScheduleModel
class ScheduleModel {
  final String dayOfWeek;
  final String startTime;
  final String? endTime;
  final String? recurrence;
  final String? recurrenceEndDate;
  final String? details;

  ScheduleModel({
    required this.dayOfWeek,
    required this.startTime,
    this.endTime,
    this.recurrence,
    this.recurrenceEndDate,
    this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (recurrence != null) 'recurrence': recurrence,
      if (recurrenceEndDate != null) 'recurrenceEndDate': recurrenceEndDate,
      if (details != null) 'details': details,
    };
  }
}

// Update AddressModel
class AddressModel {
  final String street;
  final String city;
  final String state;
  final String? zipCode;
  final double? latitude;
  final double? longitude;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      if (zipCode != null) 'zipCode': zipCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
