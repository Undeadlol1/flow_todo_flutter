import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';

class ProfileEntity implements UserCreatedDocument {
  @override
  final String id, userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;
  final int points;
  int? experience;

  final DailyStreak dailyStreak;
  final bool areEcouragingMessagesDisabled;

  ProfileEntity({
    required this.id,
    required this.userId,
    required this.points,
    required this.createdAt,
    required this.dailyStreak,
    required this.areEcouragingMessagesDisabled,
    this.updatedAt,
    this.experience,
  });
}
