class Review {
  final String id;
  final String userId;
  final String userName;
  final int rating;
  final String feedback;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.feedback,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    // Handle different response structures
    final user = json['user'];
    final userId = user is Map<String, dynamic>
        ? user['_id']?.toString()
        : user?.toString();

    return Review(
      id: json['_id']?.toString() ?? '',
      userId: userId ?? '',
      userName: json['userName']?.toString() ?? 'Anonymous',
      rating: (json['rating'] ?? 0).toInt(),
      feedback: json['feedback']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
    );
  }
}
