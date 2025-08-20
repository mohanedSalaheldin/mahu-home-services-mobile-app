class ProviderPerformanceModel {
  final int totalBookings;
  final int completed;
  final int cancelled;
  final double totalEarnings;
  final double completionRate;
  final double averageRating;

  ProviderPerformanceModel({
    required this.totalBookings,
    required this.completed,
    required this.cancelled,
    required this.totalEarnings,
    required this.completionRate,
    required this.averageRating,
  });

  factory ProviderPerformanceModel.fromJson(Map<String, dynamic> json) {
    num _toNum(dynamic value) {
      if (value is int) return value;
      if (value is double) return value;
      if (value is String) return num.tryParse(value) ?? 0;
      return 0;
    }

    return ProviderPerformanceModel(
      totalBookings: _toNum(json['totalBookings']).toInt(),
      completed: _toNum(json['completed']).toInt(),
      cancelled: _toNum(json['cancelled']).toInt(),
      totalEarnings: _toNum(json['totalEarnings']).toDouble(),
      completionRate: _toNum(json['completionRate']).toDouble(),
      averageRating: _toNum(json['averageRating']).toDouble(),
    );
  }
}
