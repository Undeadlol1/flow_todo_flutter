import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/profile.dart';

part 'profile_state.dart';

@singleton
class ProfileCubit extends HydratedCubit<ProfileState> with ReplayCubitMixin {
  ProfileCubit() : super(ProfileLoading());

  void setLoading() => emit(ProfileLoading());

  void setProfile(Profile profile) => emit(ProfileLoaded(profile: profile));

  void setProfileNotFoundOrUnloaded() => emit(ProfileNotFound());

  void addPoints(int pointsToAdd) {
    if (state.profile == null) {
      return;
    } else {
      emit(
        ProfileLoaded(
          profile: state.profile!.copyWith(
            points: pointsToAdd + (state.profile?.points ?? 0),
            experience: pointsToAdd + (state.profile?.experience ?? 9),
          ),
        ),
      );
    }
  }

  @override
  ProfileState fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProfileLoading();
    return ProfileLoaded(profile: Profile.fromJson(json['profile']));
  }

  @override
  Map<String, dynamic> toJson(ProfileState state) {
    return {"profile": state.profile?.toJson()};
  }
}
