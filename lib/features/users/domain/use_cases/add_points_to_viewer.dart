import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_up_animation.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

import '../models/profile.dart';

// TODO rename to "AddExperienceToViewer"
@injectable
class AddPointsToViewer {
  final ProfileCubit profileCubit;
  final LevelUpAnimation levelUpAnimation;
  final UserLevelCalculator userLevelCalculator;
  final UpsertProfileRepository updateProfileRepository;
  const AddPointsToViewer({
    required this.profileCubit,
    required this.levelUpAnimation,
    required this.userLevelCalculator,
    required this.updateProfileRepository,
  });

  Future<void> call(int pointsToAdd) async {
    final profileState = profileCubit.state;

    try {
      if (profileState is ProfileLoaded) {
        final currentProfile = profileState.profile;
        final updatedProfile = currentProfile?.copyWith(
          points: currentProfile.points + pointsToAdd,
          experience: (currentProfile.experience) + pointsToAdd,
        );

        profileCubit.setProfile(updatedProfile!);

        if (willUserLevelUp(
          currentProfile: currentProfile!,
          updatedProfile: updatedProfile,
        )) {
          levelUpAnimation.show();
        }

        await updateProfileRepository(updatedProfile);
      } else {
        throw Exception('Profile not loaded');
      }
    } catch (e) {
      profileCubit.undo();
      rethrow;
    }
  }

  bool willUserLevelUp({
    required Profile currentProfile,
    required Profile updatedProfile,
  }) {
    final currentLevel = userLevelCalculator(currentProfile.experience).value;
    final levelOfUpdatedProfile =
        userLevelCalculator(updatedProfile.experience).value;
    return currentLevel != levelOfUpdatedProfile;
  }
}
