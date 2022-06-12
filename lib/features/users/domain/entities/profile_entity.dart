import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

class ProfileEntity implements UserCreatedDocument {
  @override
  final String id, userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  int? points, experience;

  // TODO
  //   dailyStreak: DailyStreak;
  final bool areEcouragingMessagesDisabled;

  ProfileEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.areEcouragingMessagesDisabled,
    this.points,
    this.updatedAt,
    this.experience,
  });
}
