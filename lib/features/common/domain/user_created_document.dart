abstract class UserCreatedDocument {
  final num createdAt;
  final num? updatedAt;
  final String userId;

  UserCreatedDocument({
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });
}
