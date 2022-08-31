import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'remote_config_state.dart';
part 'remote_config_cubit.freezed.dart';

const _defaultState = RemoteConfigState(
  areTagsEnabled: false,
  isOnlyASingleSelectedTaskAllowed: true,
);

@singleton
class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit() : super(_defaultState);

  void reset() => emit(_defaultState);
  void update(RemoteConfigState remoteConfigState) => emit(remoteConfigState);
}
