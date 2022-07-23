import 'package:flow_todo_flutter_2022/features/streaks/domain/entities/daily_streak_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_streak.freezed.dart';
part 'daily_streak.g.dart';

@freezed
@Implements<DailyStreakEntity>()
class DailyStreak with _$DailyStreak {
  const DailyStreak._();

  const factory DailyStreak({
    int? updatedAt,
    required String id,
    required String userId,
    required int perDay,
    required int startsAt,
    required int createdAt,
  }) = _DailyStreak;

  factory DailyStreak.fromJson(Map<String, Object?> json) =>
      _$DailyStreakFromJson(json);

  int getDaysInARow() {
    if (updatedAt == null) return 0;

    final differenceInDaysBetweenUpdateAndStart =
        DateTime.fromMillisecondsSinceEpoch(updatedAt!)
            .difference(
              DateTime.fromMillisecondsSinceEpoch(startsAt),
            )
            .inDays;

    return differenceInDaysBetweenUpdateAndStart + 1;
  }

  bool isInterrupted() {
    if (updatedAt == null) return true;
    return !_wasStreakUpdatedToday();
  }

  bool shouldStreakIncrement({required final int tasksDoneToday}) {
    final bool isTaskGoalReached = tasksDoneToday >= perDay;

    if (updatedAt == null && isTaskGoalReached) {
      return true;
    }

    if (_wasStreakUpdatedToday()) {
      return false;
    }

    return isTaskGoalReached && isInterrupted();
  }

  bool _wasStreakUpdatedToday() {
    if (updatedAt == null) return false;

    final today = DateTime.now();
    final difference =
        today.difference(DateTime.fromMillisecondsSinceEpoch(updatedAt!));

    return difference.inDays == 0;
  }
}
