class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String serviceType;
  final String subType;
  final int basePrice;
  final String pricingModel;
  final int duration;
  final String image;
  final bool active;
  final String provider;
  final bool isApproved;
  final DateTime createdAt;
  final int v;

  ServiceModel({
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
    required this.createdAt,
    required this.v,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      serviceType: json['serviceType'] ?? '',
      subType: json['subType'] ?? '',
      basePrice: json['basePrice'] ?? 0,
      pricingModel: json['pricingModel'] ?? '',
      duration: json['duration'] ?? 0,
      image: json['image'] ?? '',
      active: json['active'] ?? false,
      provider: json['provider'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
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
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
    };
  }
}
