import '../../../common/domain/user_created_document.dart';

class GoalEntity implements UserCreatedDocument {
  int steps;
  int points;
  String title;

  @override
  final String id;

  @override
  final String userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  GoalEntity({
    required this.steps,
    required this.title,
    required this.points,
    required this.id,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });
}
