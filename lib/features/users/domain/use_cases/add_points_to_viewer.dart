import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';

class AddPointsToViewer {
  final ProfileCubit profileCubit;
  final UpdateProfileRepository updateProfileRepository;
  const AddPointsToViewer({
    required this.profileCubit,
    required this.updateProfileRepository,
  });

  Future<void> call({
    required Profile profile,
    required int pointsToAdd,
  }) async {
    final updatedProfile =
        profile.copyWith(points: profile.points + pointsToAdd);

    profileCubit.setProfile(updatedProfile);

    await updateProfileRepository(updatedProfile);
  }
}
