import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

class ProfileEntity implements UserCreatedDocument {
  @override
  final String id, userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;
  final int points;
  int? experience;

  // TODO
  //   dailyStreak: DailyStreak;
  final bool areEcouragingMessagesDisabled;

  ProfileEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.areEcouragingMessagesDisabled,
    required this.points,
    this.updatedAt,
    this.experience,
  });
}
