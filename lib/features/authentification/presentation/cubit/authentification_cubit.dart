import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  AuthentificationCubit() : super(AuthentificationLoading());

  void setUser(User user) {
    emit(Authenticated(user));
  }

  void setNotAuthenticated() {
    emit(NotAuthenticated());
  }
}
