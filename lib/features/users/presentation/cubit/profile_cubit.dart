import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/profile.dart';

part 'profile_state.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> with ReplayCubitMixin {
  ProfileCubit() : super(ProfileLoading());

  void setProfile(Profile profile) {
    emit(ProfileLoaded(profile: profile));
  }

  void setLoading() {
    emit(ProfileLoading());
  }

  void setProfileNotFoundOrUnloaded() {
    emit(ProfileNotFound());
  }
}
