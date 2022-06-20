import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/models/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
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
