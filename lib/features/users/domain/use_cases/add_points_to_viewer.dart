import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class AddPointsToViewer {
  final ProfileCubit profileCubit;
  final UpsertProfileRepository updateProfileRepository;
  const AddPointsToViewer({
    required this.profileCubit,
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

        await updateProfileRepository(updatedProfile);
      } else {
        throw Exception('Profile not loaded');
      }
    } catch (e) {
      profileCubit.undo();
      rethrow;
    }
  }
}
