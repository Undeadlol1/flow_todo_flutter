part of 'authentification_cubit.dart';

@immutable
abstract class AuthentificationState {}

class AuthentificationLoading extends AuthentificationState {}

class NotAuthenticated extends AuthentificationState {}

class Authenticated extends AuthentificationState {
  final User user;
  Authenticated(this.user);
}
