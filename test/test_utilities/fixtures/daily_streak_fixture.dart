import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';

final dailyStreakFixture = DailyStreak(
  perDay: 3,
  updatedAt: null,
  id: 'someId123',
  userId: 'someUserId123',
  startsAt: DateTime.now().millisecondsSinceEpoch,
  createdAt: DateTime.now().millisecondsSinceEpoch,
);
