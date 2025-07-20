class Service {
  final String name;
  final String description;
  final String category;
  final String serviceType;
  final String subType;
  final double basePrice;
  final int duration; // in minutes
  final String pricingModel;
  final String imgUrl; // now required
  final List<String> availableAreas;

  Service({
    required this.name,
    required this.description,
    required this.category,
    required this.serviceType,
    required this.subType,
    required this.basePrice,
    required this.duration,
    required this.pricingModel,
    required this.imgUrl,
    required this.availableAreas,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      serviceType: json['serviceType'],
      subType: json['subType'],
      basePrice: (json['basePrice'] as num).toDouble(),
      duration: json['duration'],
      pricingModel: json['pricingModel'],
      imgUrl: json['imgUrl'],
      availableAreas: List<String>.from(json['availableAreas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'serviceType': serviceType,
      'subType': subType,
      'basePrice': basePrice,
      'duration': duration,
      'pricingModel': pricingModel,
      'imgUrl': imgUrl,
      'availableAreas': availableAreas,
    };
  }
}
