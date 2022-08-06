import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetProfile {
  final ProfileCubit profileCubit;
  final GetProfileRepository getProfileRepository;
  final UseCaseExceptionHandler useCaseExceptionHandler;

  const GetProfile({
    required this.profileCubit,
    required this.getProfileRepository,
    required this.useCaseExceptionHandler,
  });

  Future<void> call({required String userId}) async {
    if (profileCubit.state is! ProfileLoaded) {
      profileCubit.setLoading();
    }

    getProfileRepository(userId: userId).then(
      (profile) {
        if (profile == null) {
          profileCubit.setProfileNotFoundOrUnloaded();
        } else {
          if (profileCubit.state.profile != profile) {
            profileCubit.setProfile(profile);
          }
        }
      },
    ).catchError((error) {
      useCaseExceptionHandler(error);
      return Future.value(null);
    });
  }
}
