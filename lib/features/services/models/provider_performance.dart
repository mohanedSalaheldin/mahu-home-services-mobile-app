class ProviderPerformanceModel {
  final int totalBookings;
  final int completed;
  final int cancelled;
  final double completionRate;
  final double averageRating;
  final double totalEarnings;

  ProviderPerformanceModel({
    required this.totalBookings,
    required this.totalEarnings,
    required this.completed,
    required this.cancelled,
    required this.completionRate,
    required this.averageRating,
  });

  factory ProviderPerformanceModel.fromJson(Map<String, dynamic> json) {
    return ProviderPerformanceModel(
      totalBookings: json['totalBookings'] ?? 0,
      totalEarnings: json['totalEarnings'] ?? 0,
      completed: json['completed'] ?? 0,
      cancelled: json['cancelled'] ?? 0,
      completionRate: (json['completionRate'] ?? 0).toDouble(),
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '0.0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBookings': totalBookings,
      'totalEarnings': totalEarnings,
      'completed': completed,
      'cancelled': cancelled,
      'completionRate': completionRate,
      'averageRating': averageRating.toStringAsFixed(1),
    };
  }
}
