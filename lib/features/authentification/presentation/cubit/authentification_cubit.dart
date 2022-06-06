import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/user.dart';
import 'package:meta/meta.dart';

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
