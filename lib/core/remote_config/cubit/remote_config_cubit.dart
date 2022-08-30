import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_state.dart';
part 'remote_config_cubit.freezed.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit() : super(RemoteConfigState.initial());
}
