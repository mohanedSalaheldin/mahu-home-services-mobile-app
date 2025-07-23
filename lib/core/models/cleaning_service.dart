
class CleaningService {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final int duration;
  final double rating;
  final int reviews;
  final String imageUrl;
  bool isFavorite;
  final List<String> subServices;
  final String serviceType;
  final String subType;

  CleaningService({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.duration,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.isFavorite = false,
    required this.subServices,
    required this.serviceType,
    required this.subType,
  });
}