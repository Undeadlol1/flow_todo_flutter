// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'remote_config_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RemoteConfigState {
  bool get areTagsEnabled => throw _privateConstructorUsedError;
  bool get areQuestsEnabled => throw _privateConstructorUsedError;
  bool get isOnlyASingleSelectedTaskAllowed =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RemoteConfigStateCopyWith<RemoteConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteConfigStateCopyWith<$Res> {
  factory $RemoteConfigStateCopyWith(
          RemoteConfigState value, $Res Function(RemoteConfigState) then) =
      _$RemoteConfigStateCopyWithImpl<$Res>;
  $Res call(
      {bool areTagsEnabled,
      bool areQuestsEnabled,
      bool isOnlyASingleSelectedTaskAllowed});
}

/// @nodoc
class _$RemoteConfigStateCopyWithImpl<$Res>
    implements $RemoteConfigStateCopyWith<$Res> {
  _$RemoteConfigStateCopyWithImpl(this._value, this._then);

  final RemoteConfigState _value;
  // ignore: unused_field
  final $Res Function(RemoteConfigState) _then;

  @override
  $Res call({
    Object? areTagsEnabled = freezed,
    Object? areQuestsEnabled = freezed,
    Object? isOnlyASingleSelectedTaskAllowed = freezed,
  }) {
    return _then(_value.copyWith(
      areTagsEnabled: areTagsEnabled == freezed
          ? _value.areTagsEnabled
          : areTagsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      areQuestsEnabled: areQuestsEnabled == freezed
          ? _value.areQuestsEnabled
          : areQuestsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnlyASingleSelectedTaskAllowed: isOnlyASingleSelectedTaskAllowed ==
              freezed
          ? _value.isOnlyASingleSelectedTaskAllowed
          : isOnlyASingleSelectedTaskAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_StateCopyWith<$Res>
    implements $RemoteConfigStateCopyWith<$Res> {
  factory _$$_StateCopyWith(_$_State value, $Res Function(_$_State) then) =
      __$$_StateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool areTagsEnabled,
      bool areQuestsEnabled,
      bool isOnlyASingleSelectedTaskAllowed});
}

/// @nodoc
class __$$_StateCopyWithImpl<$Res> extends _$RemoteConfigStateCopyWithImpl<$Res>
    implements _$$_StateCopyWith<$Res> {
  __$$_StateCopyWithImpl(_$_State _value, $Res Function(_$_State) _then)
      : super(_value, (v) => _then(v as _$_State));

  @override
  _$_State get _value => super._value as _$_State;

  @override
  $Res call({
    Object? areTagsEnabled = freezed,
    Object? areQuestsEnabled = freezed,
    Object? isOnlyASingleSelectedTaskAllowed = freezed,
  }) {
    return _then(_$_State(
      areTagsEnabled: areTagsEnabled == freezed
          ? _value.areTagsEnabled
          : areTagsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      areQuestsEnabled: areQuestsEnabled == freezed
          ? _value.areQuestsEnabled
          : areQuestsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnlyASingleSelectedTaskAllowed: isOnlyASingleSelectedTaskAllowed ==
              freezed
          ? _value.isOnlyASingleSelectedTaskAllowed
          : isOnlyASingleSelectedTaskAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_State implements _State {
  const _$_State(
      {required this.areTagsEnabled,
      required this.areQuestsEnabled,
      required this.isOnlyASingleSelectedTaskAllowed});

  @override
  final bool areTagsEnabled;
  @override
  final bool areQuestsEnabled;
  @override
  final bool isOnlyASingleSelectedTaskAllowed;

  @override
  String toString() {
    return 'RemoteConfigState(areTagsEnabled: $areTagsEnabled, areQuestsEnabled: $areQuestsEnabled, isOnlyASingleSelectedTaskAllowed: $isOnlyASingleSelectedTaskAllowed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_State &&
            const DeepCollectionEquality()
                .equals(other.areTagsEnabled, areTagsEnabled) &&
            const DeepCollectionEquality()
                .equals(other.areQuestsEnabled, areQuestsEnabled) &&
            const DeepCollectionEquality().equals(
                other.isOnlyASingleSelectedTaskAllowed,
                isOnlyASingleSelectedTaskAllowed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(areTagsEnabled),
      const DeepCollectionEquality().hash(areQuestsEnabled),
      const DeepCollectionEquality().hash(isOnlyASingleSelectedTaskAllowed));

  @JsonKey(ignore: true)
  @override
  _$$_StateCopyWith<_$_State> get copyWith =>
      __$$_StateCopyWithImpl<_$_State>(this, _$identity);
}

abstract class _State implements RemoteConfigState {
  const factory _State(
      {required final bool areTagsEnabled,
      required final bool areQuestsEnabled,
      required final bool isOnlyASingleSelectedTaskAllowed}) = _$_State;

  @override
  bool get areTagsEnabled;
  @override
  bool get areQuestsEnabled;
  @override
  bool get isOnlyASingleSelectedTaskAllowed;
  @override
  @JsonKey(ignore: true)
  _$$_StateCopyWith<_$_State> get copyWith =>
      throw _privateConstructorUsedError;
}
