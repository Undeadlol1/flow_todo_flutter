import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetProfile {
  final ProfileCubit profileCubit;
  final GetProfileRepository getProfileRepository;
  const GetProfile({
    required this.profileCubit,
    required this.getProfileRepository,
  });

  Future<void> call({required String userId}) async {
    if (profileCubit.state is! ProfileLoaded) {
      profileCubit.setLoading();
    }

    return getProfileRepository(userId: userId).then(
      (profile) {
        if (profile == null) {
          profileCubit.setProfileNotFoundOrUnloaded();
        } else {
          if (profileCubit.state.profile != profile) {
            profileCubit.setProfile(profile);
          }
        }
      },
    );
  }
}
