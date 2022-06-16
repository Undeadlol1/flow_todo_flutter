part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final Profile? profile;

  const ProfileState({this.profile});
}

class ProfileLoading extends ProfileState {}

class ProfileNotFound extends ProfileState {}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required profile}) : super(profile: profile);
}
