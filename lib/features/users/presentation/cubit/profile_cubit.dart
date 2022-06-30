import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/profile.dart';

part 'profile_state.dart';

@singleton
class ProfileCubit extends HydratedCubit<ProfileState> with ReplayCubitMixin {
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

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProfileLoading();
    return ProfileLoaded(profile: Profile.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return state.profile?.toJson();
  }
}
