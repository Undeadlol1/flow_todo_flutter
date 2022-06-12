import '../entities/profile_entity.dart';

class Profile implements ProfileEntity {
  @override
  int? experience, points, updatedAt;

  @override
  bool areEcouragingMessagesDisabled;

  @override
  final int createdAt;

  @override
  final String id, userId;

  Profile({
    this.points,
    this.updatedAt,
    this.experience,
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.areEcouragingMessagesDisabled,
  });
}
