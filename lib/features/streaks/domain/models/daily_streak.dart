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
    final differenceInDaysBetweenUpdateAndStart =
        DateTime.fromMillisecondsSinceEpoch(updatedAt ?? today)
            .difference(DateTime.fromMillisecondsSinceEpoch(startsAt))
            .inDays;

    return differenceInDaysBetweenUpdateAndStart + 1;
  }

  bool isInterrupted() {
    return !_wasStreakUpdatedSinceYesterdayMidnight();
  }

  bool shouldStreakIncrement({required final int tasksDoneToday}) {
    print('was updated today: ${_wasStreakUpdatedSinceYesterdayMidnight()}');
    final bool isTaskGoalReached = tasksDoneToday >= perDay;

    if (updatedAt == null && isTaskGoalReached) {
      return true;
    }

    if (_wasStreakUpdatedSinceYesterdayMidnight()) {
      return false;
    }

    return isTaskGoalReached && isInterrupted();
  }

  bool _wasStreakUpdatedSinceYesterdayMidnight() {
    final today = DateTime.now();
    final yesterdayMidnight = DateTime(today.year, today.month, today.day);

    final bool wasStreakStartedYesterday =
        DateTime.fromMillisecondsSinceEpoch(startsAt)
                .difference(DateTime.now())
                .inDays ==
            1;

    final updatedAgo = yesterdayMidnight.difference(
      DateTime.fromMillisecondsSinceEpoch(
        updatedAt ?? today.millisecondsSinceEpoch,
      ),
    );

    print('today: ${today.toString()}');
    print('yesterdayMidnight: ${yesterdayMidnight.toString()}');
    print(
      'updatedAt: ${updatedAt != null ? DateTime.fromMillisecondsSinceEpoch(updatedAt!) : 'is null'}',
    );
    print('updatedAgo: ${updatedAgo.toString()}');
    print('updatedAgo.inHours: ${updatedAgo.inHours.toString()}');

    if (updatedAt == null && wasStreakStartedYesterday) {
      return true;
    }

    return updatedAgo.inHours <= 24 ? true : false;
  }
}
