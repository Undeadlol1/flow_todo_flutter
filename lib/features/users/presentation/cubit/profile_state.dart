part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileNotFound extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  ProfileLoaded({required this.profile});
}
