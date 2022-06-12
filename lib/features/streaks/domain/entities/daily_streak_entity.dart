import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

class DailyStreakEntity implements UserCreatedDocument {
  @override
  final String id, userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  int? startsAt;

  int? perDay;

  DailyStreakEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    this.perDay,
    this.startsAt,
    this.updatedAt,
  });
}
