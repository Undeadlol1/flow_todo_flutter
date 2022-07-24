import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:injectable/injectable.dart';

import '../../../common/services/get_todays_date.dart';
import '../../../tasks/presentation/cubit/tasks_done_today_cubit.dart';
import '../../../users/data/update_profile_repository.dart';
import '../../../users/domain/models/profile.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';

@lazySingleton
class IncrementDailyStreak {
  final ProfileCubit profileCubit;
  final GetTodaysDate getTodaysDate;
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  final UpdateProfileRepository updateProfile;
  const IncrementDailyStreak({
    required this.profileCubit,
    required this.getTodaysDate,
    required this.tasksDoneTodayCubit,
    required this.updateProfile,
  });

  Future<void> call() async {
    if (_shouldDailyStreakIncrement()) {
      return updateProfile(_getUpdatedProfile());
    }
  }

  int get _tasksDoneToday => tasksDoneTodayCubit.state.tasks.length;
  DailyStreak? get _streak => profileCubit.state.profile?.dailyStreak;

  bool _shouldDailyStreakIncrement() {
    return _streak?.shouldStreakIncrement(
          tasksDoneToday: _tasksDoneToday,
        ) ??
        false;
  }

  Profile _getUpdatedProfile() {
    final streak = _streak!;
    final today = getTodaysDate();

    final updatedProfile = profileCubit.state.profile!.copyWith(
      dailyStreak: streak.copyWith(
        startsAt: streak.isInterrupted() ? today : streak.startsAt,
        updatedAt: today.millisecondsSinceEpoch,
      ),
    );

    return updatedProfile;
  }
}
