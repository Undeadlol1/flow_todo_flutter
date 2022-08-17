import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetExperience {
  final ProfileCubit profileCubit;
  final FirebaseAnalytics firebaseAnalytics;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  final UpsertProfileRepository upsertProfileRepository;
  const ResetExperience({
    required this.profileCubit,
    required this.firebaseAnalytics,
    required this.useCaseExceptionHandler,
    required this.upsertProfileRepository,
  });

  Future<void> call() async {
    try {
      final updatedProfile =
          profileCubit.state.profile!.copyWith(experience: 0);

      profileCubit.setProfile(updatedProfile);

      await upsertProfileRepository(updatedProfile);

      // TODO analytics abstraction.
      return firebaseAnalytics.logEvent(name: "experience_reset");
    } catch (error, stack) {
      profileCubit.undo();
      useCaseExceptionHandler(error, stack);
    }
  }
}
