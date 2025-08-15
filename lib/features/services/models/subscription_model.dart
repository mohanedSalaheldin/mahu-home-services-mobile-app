class Subscription {
  final String id;
  final String userId;
  final Plan plan;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.plan,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['_id'],
      userId: json['user'],
      plan: Plan.fromJson(json['plan']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Plan {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final List<String> features;
  final bool isActive;
  final int maxServices;
  final int maxBookings;
  final DateTime createdAt;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.features,
    required this.isActive,
    required this.maxServices,
    required this.maxBookings,
    required this.createdAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      features: List<String>.from(json['features']),
      isActive: json['isActive'],
      maxServices: json['maxServices'],
      maxBookings: json['maxBookings'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}