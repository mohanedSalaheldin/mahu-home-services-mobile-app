enum ServiceType {
  oneTime,
  recurring,
}

extension ServiceTypeExtension on ServiceType {
  String get displayName {
    switch (this) {
      case ServiceType.oneTime:
        return 'One-Time Charge';
      case ServiceType.recurring:
        return 'Recurring Charge';
    }
  }
}

enum ServiceSubType {
  normal,
  deep,
  postConstruction,
}

extension ServiceSubTypeExtension on ServiceSubType {
  String get displayName {
    switch (this) {
      case ServiceSubType.deep:
        return 'Deep Cleaning';
      case ServiceSubType.postConstruction:
        return 'Post-Construction Cleaning';
      case ServiceSubType.normal:
        return 'Normal Cleaning';
    }
  }
}

enum RecurrencePattern {
  monthly,
  weekly,
}

extension RecurrencePatternExtension on RecurrencePattern {
  String get displayName {
    switch (this) {
      case RecurrencePattern.monthly:
        return 'Monthly';
      case RecurrencePattern.weekly:
        return 'Weekly';
    }
  }
}

enum PricingModel {
  fixed,
  photoBased,
}
