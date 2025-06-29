abstract class CleaningServiceBase {
  final String providerId;
  final String name;
  final String description;
  final String subType;
  final int estimatedDuration;
  final String imageUrl;

  CleaningServiceBase({
    required this.providerId,
    required this.name,
    required this.description,
    required this.subType,
    required this.estimatedDuration,
    required this.imageUrl,
  });
}
