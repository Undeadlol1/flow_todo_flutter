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

    final today = DateTime.now().millisecondsSinceEpoch;
    final differenceInDaysBetweenUpdateAndCreation =
        DateTime.fromMillisecondsSinceEpoch(updatedAt ?? today)
            .difference(DateTime.fromMillisecondsSinceEpoch(createdAt))
            .inDays;

    return differenceInDaysBetweenUpdateAndCreation + 1;
  }

  bool isBroken() {
    final int updatedDaysAgo = _getStreakUpdatedDaysAgo();

    if (updatedDaysAgo == 1) return false;
    return updatedDaysAgo > 1;
  }

  bool shouldUpdate({required final int tasksDoneToday}) {
    final bool isTaskGoalReached = tasksDoneToday >= perDay;
    final bool wasStreakUpdatedToday = _getStreakUpdatedDaysAgo() == 0;
    0;

    if (!isTaskGoalReached) {
      return false;
    } else {
      return isTaskGoalReached && !wasStreakUpdatedToday;
    }
  }

  int _getStreakUpdatedDaysAgo() {
    final today = DateTime.now();
    return today
        .difference(
          DateTime.fromMillisecondsSinceEpoch(
            updatedAt ?? today.millisecondsSinceEpoch,
          ),
        )
        .inDays;
  }
}
