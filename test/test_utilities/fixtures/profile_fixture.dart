import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';

const _userId = 'userId123';

const profileFixture = Profile(
  id: 'id123',
  points: 0,
  createdAt: 0,
  userId: _userId,
  areEcouragingMessagesDisabled: false,
  dailyStreak: DailyStreak(
    id: 'id',
    perDay: 3,
    startsAt: 0,
    createdAt: 0,
    userId: _userId,
  ),
);
