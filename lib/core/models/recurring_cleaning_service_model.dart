import 'package:mahu_home_services_app/core/models/cleaning_service_base.dart';

class RecurringCleaningServiceModel extends CleaningServiceBase {
  final String frequency; // weekly, monthly
  final double basePrice;

  RecurringCleaningServiceModel({
    required super.providerId,
    required super.name,
    required super.description,
    required super.subType,
    required super.estimatedDuration,
    required super.imageUrl,
    required this.frequency,
    required this.basePrice,
  });

  factory RecurringCleaningServiceModel.fromJson(Map<String, dynamic> json) {
    return RecurringCleaningServiceModel(
      providerId: json['providerId'],
      name: json['name'],
      description: json['description'],
      subType: json['subType'],
      estimatedDuration: json['estimatedDuration'],
      imageUrl: json['imageUrl'],
      frequency: json['frequency'],
      basePrice: (json['basePrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerId': providerId,
      'name': name,
      'description': description,
      'subType': subType,
      'estimatedDuration': estimatedDuration,
      'imageUrl': imageUrl,
      'frequency': frequency,
      'basePrice': basePrice,
    };
  }
}

