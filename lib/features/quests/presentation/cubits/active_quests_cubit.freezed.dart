// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'active_quests_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActiveQuestsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Quest> quests) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveQuestsStateCopyWith<$Res> {
  factory $ActiveQuestsStateCopyWith(
          ActiveQuestsState value, $Res Function(ActiveQuestsState) then) =
      _$ActiveQuestsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ActiveQuestsStateCopyWithImpl<$Res>
    implements $ActiveQuestsStateCopyWith<$Res> {
  _$ActiveQuestsStateCopyWithImpl(this._value, this._then);

  final ActiveQuestsState _value;
  // ignore: unused_field
  final $Res Function(ActiveQuestsState) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$ActiveQuestsStateCopyWithImpl<$Res>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, (v) => _then(v as _$_Loading));

  @override
  _$_Loading get _value => super._value as _$_Loading;
}

/// @nodoc

class _$_Loading extends _Loading {
  _$_Loading() : super._();

  @override
  String toString() {
    return 'ActiveQuestsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Quest> quests) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends ActiveQuestsState {
  factory _Loading() = _$_Loading;
  _Loading._() : super._();
}

/// @nodoc
abstract class _$$_loadedCopyWith<$Res> {
  factory _$$_loadedCopyWith(_$_loaded value, $Res Function(_$_loaded) then) =
      __$$_loadedCopyWithImpl<$Res>;
  $Res call({List<Quest> quests});
}

/// @nodoc
class __$$_loadedCopyWithImpl<$Res>
    extends _$ActiveQuestsStateCopyWithImpl<$Res>
    implements _$$_loadedCopyWith<$Res> {
  __$$_loadedCopyWithImpl(_$_loaded _value, $Res Function(_$_loaded) _then)
      : super(_value, (v) => _then(v as _$_loaded));

  @override
  _$_loaded get _value => super._value as _$_loaded;

  @override
  $Res call({
    Object? quests = freezed,
  }) {
    return _then(_$_loaded(
      quests == freezed
          ? _value._quests
          : quests // ignore: cast_nullable_to_non_nullable
              as List<Quest>,
    ));
  }
}

/// @nodoc

class _$_loaded extends _loaded {
  _$_loaded(final List<Quest> quests)
      : _quests = quests,
        super._();

  final List<Quest> _quests;
  @override
  List<Quest> get quests {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quests);
  }

  @override
  String toString() {
    return 'ActiveQuestsState.loaded(quests: $quests)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_loaded &&
            const DeepCollectionEquality().equals(other._quests, _quests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_quests));

  @JsonKey(ignore: true)
  @override
  _$$_loadedCopyWith<_$_loaded> get copyWith =>
      __$$_loadedCopyWithImpl<_$_loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Quest> quests) loaded,
  }) {
    return loaded(quests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
  }) {
    return loaded?.call(quests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Quest> quests)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(quests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _loaded extends ActiveQuestsState {
  factory _loaded(final List<Quest> quests) = _$_loaded;
  _loaded._() : super._();

  List<Quest> get quests => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_loadedCopyWith<_$_loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
