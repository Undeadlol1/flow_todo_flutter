abstract class UserCreatedDocument {
  final String id;
  final num createdAt;
  final num? updatedAt;
  final String userId;

  UserCreatedDocument({
    required this.id,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });
}
