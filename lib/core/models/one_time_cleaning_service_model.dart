import 'package:mahu_home_services_app/core/models/cleaning_service_base.dart';

class OneTimeCleaningServiceModel extends CleaningServiceBase {
  final String pricingModel; // 'fixed' or 'imageBased'
  final double? basePrice;
  final String? imageInstructions;

  OneTimeCleaningServiceModel({
    required super.providerId,
    required super.name,
    required super.description,
    required super.subType,
    required super.estimatedDuration,
    required super.imageUrl,
    required this.pricingModel,
    this.basePrice,
    this.imageInstructions,
  });

  factory OneTimeCleaningServiceModel.fromJson(Map<String, dynamic> json) {
    return OneTimeCleaningServiceModel(
      providerId: json['providerId'],
      name: json['name'],
      description: json['description'],
      subType: json['subType'],
      estimatedDuration: json['estimatedDuration'],
      imageUrl: json['imageUrl'],
      pricingModel: json['pricingModel'],
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      imageInstructions: json['imageInstructions'],
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
      'pricingModel': pricingModel,
      'basePrice': basePrice,
      'imageInstructions': imageInstructions,
    };
  }
}
