import 'package:flow_todo_flutter_2022/core/services/milliseconds_to_datetime_property_converter.dart';
import 'package:flow_todo_flutter_2022/core/services/optional_milliseconds_to_datetime_property_converter.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/entities/daily_streak_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_streak.freezed.dart';
part 'daily_streak.g.dart';

@freezed
@Implements<DailyStreakEntity>()
class DailyStreak with _$DailyStreak {
  const DailyStreak._();

  const factory DailyStreak({
    required String id,
    required String userId,
    required int perDay,
    @OptionalMillisecondsToDateTimePropertyConverter() DateTime? updatedAt,
    @MillisecondsToDateTimePropertyConverter() required DateTime startsAt,
    @MillisecondsToDateTimePropertyConverter() required DateTime createdAt,
  }) = _DailyStreak;

  factory DailyStreak.fromJson(Map<String, Object?> json) =>
      _$DailyStreakFromJson(json);

  bool isInterrupted() {
    final streakStartedDaysAgo =
        DateTime.now().difference(updatedAt ?? DateTime.now()).inDays;

    if (streakStartedDaysAgo <= 1) return false;
    return !_wasStreakUpdatedToday();
  }

  bool shouldStreakIncrement({required final int tasksDoneToday}) {
    final bool isTaskGoalReached = tasksDoneToday >= perDay;

    if (isTaskGoalReached) {
      if (updatedAt == null) {
        return true;
      }

      return !_wasStreakUpdatedToday();
    }

    return false;
  }

  bool _wasStreakUpdatedToday() {
    if (updatedAt == null) return false;

    return updatedAt!.difference(_getBeginningOfToday()).inHours.sign >= 0;
  }

  DateTime _getBeginningOfToday() {
    final now = DateTime.now();
    final yesterdayMidnight = DateTime(now.year, now.month, now.day);
    return yesterdayMidnight;
  }
}
