// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'selected_tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectedTasksState {
  List<Task> get tasks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectedTasksStateCopyWith<SelectedTasksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedTasksStateCopyWith<$Res> {
  factory $SelectedTasksStateCopyWith(
          SelectedTasksState value, $Res Function(SelectedTasksState) then) =
      _$SelectedTasksStateCopyWithImpl<$Res>;
  $Res call({List<Task> tasks});
}

/// @nodoc
class _$SelectedTasksStateCopyWithImpl<$Res>
    implements $SelectedTasksStateCopyWith<$Res> {
  _$SelectedTasksStateCopyWithImpl(this._value, this._then);

  final SelectedTasksState _value;
  // ignore: unused_field
  final $Res Function(SelectedTasksState) _then;

  @override
  $Res call({
    Object? tasks = freezed,
  }) {
    return _then(_value.copyWith(
      tasks: tasks == freezed
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc
abstract class _$$_StateCopyWith<$Res>
    implements $SelectedTasksStateCopyWith<$Res> {
  factory _$$_StateCopyWith(_$_State value, $Res Function(_$_State) then) =
      __$$_StateCopyWithImpl<$Res>;
  @override
  $Res call({List<Task> tasks});
}

/// @nodoc
class __$$_StateCopyWithImpl<$Res>
    extends _$SelectedTasksStateCopyWithImpl<$Res>
    implements _$$_StateCopyWith<$Res> {
  __$$_StateCopyWithImpl(_$_State _value, $Res Function(_$_State) _then)
      : super(_value, (v) => _then(v as _$_State));

  @override
  _$_State get _value => super._value as _$_State;

  @override
  $Res call({
    Object? tasks = freezed,
  }) {
    return _then(_$_State(
      tasks == freezed
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$_State implements _State {
  const _$_State(final List<Task> tasks) : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'SelectedTasksState(tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_State &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  _$$_StateCopyWith<_$_State> get copyWith =>
      __$$_StateCopyWithImpl<_$_State>(this, _$identity);
}

abstract class _State implements SelectedTasksState {
  const factory _State(final List<Task> tasks) = _$_State;

  @override
  List<Task> get tasks;
  @override
  @JsonKey(ignore: true)
  _$$_StateCopyWith<_$_State> get copyWith =>
      throw _privateConstructorUsedError;
}
