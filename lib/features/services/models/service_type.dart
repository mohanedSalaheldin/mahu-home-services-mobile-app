enum ServiceType {
  oneTime,
  recurring,
}

extension ServiceTypeExtension on ServiceType {
  String get displayName {
    switch (this) {
      case ServiceType.oneTime:
        return 'One-Time Cleaning';
      case ServiceType.recurring:
        return 'Recurring Cleaning';
    }
  }
}

enum ServiceSubType {
  standard,
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
      case ServiceSubType.standard:
        return 'Standard Cleaning';
    }
  }
}

enum PricingModel {
  fixed,
  photoBased,
}