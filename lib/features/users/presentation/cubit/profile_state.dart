part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final Profile profile = Profile(
      id: '',
      userId: '',
      createdAt: 0,
      dailyStreak: DailyStreak(
        id: '',
        perDay: 3,
        userId: '',
        updatedAt: null,
        startsAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      points: 0,
      experience: 0,
      areEcouragingMessagesDisabled: true,);
}

class ProfileLoading extends ProfileState {}

class ProfileNotFound extends ProfileState {}

class ProfileLoaded implements ProfileState {
  @override
  final Profile profile;

  ProfileLoaded({required this.profile});
}
