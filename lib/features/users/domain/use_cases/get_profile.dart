import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';

class GetProfile {
  final ProfileCubit profileCubit;
  final GetProfileRepository getProfileRepository;
  const GetProfile({
    required this.profileCubit,
    required this.getProfileRepository,
  });

  Future<void> call({required String userId}) async {
    profileCubit.setLoading();

    final profile = await getProfileRepository(userId: userId);

    if (profile != null) {
      profileCubit.setProfile(profile);
    } else {
      profileCubit.setProfileNotFound();
    }
  }
}
