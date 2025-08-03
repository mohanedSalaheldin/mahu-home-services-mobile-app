class UserBookingModel {
  final String service;
  final ScheduleModel schedule;
  final AddressModel address;
  final String details;

  UserBookingModel({
    required this.service,
    required this.schedule,
    required this.address,
    required this.details,
  });

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      service: json['service'],
      schedule: ScheduleModel.fromJson(json['schedule']),
      address: AddressModel.fromJson(json['address']),
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'schedule': schedule.toJson(),
      'address': address.toJson(),
      'details': details,
    };
  }
}

class ScheduleModel {
  final String startDate;
  final String? endDate;
  final String? recurrence;

  ScheduleModel({
    required this.startDate,
    this.endDate,
    this.recurrence,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
      recurrence: json['recurrence'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'startDate': startDate,
    };
    if (endDate != null) map['endDate'] = endDate!;
    if (recurrence != null) map['recurrence'] = recurrence!;
    return map;
  }
}

class AddressModel {
  final String street;
  final String city;
  final String state;
  final String? zipCode;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    this.zipCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'street': street,
      'city': city,
      'state': state,
    };
    if (zipCode != null) map['zipCode'] = zipCode!;
    return map;
  }
}
