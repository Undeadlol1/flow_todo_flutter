// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter_by_tags_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FilterByTagsState {
  Set<String> get tags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilterByTagsStateCopyWith<FilterByTagsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterByTagsStateCopyWith<$Res> {
  factory $FilterByTagsStateCopyWith(
          FilterByTagsState value, $Res Function(FilterByTagsState) then) =
      _$FilterByTagsStateCopyWithImpl<$Res>;
  $Res call({Set<String> tags});
}

/// @nodoc
class _$FilterByTagsStateCopyWithImpl<$Res>
    implements $FilterByTagsStateCopyWith<$Res> {
  _$FilterByTagsStateCopyWithImpl(this._value, this._then);

  final FilterByTagsState _value;
  // ignore: unused_field
  final $Res Function(FilterByTagsState) _then;

  @override
  $Res call({
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_StateCopyWith<$Res>
    implements $FilterByTagsStateCopyWith<$Res> {
  factory _$$_StateCopyWith(_$_State value, $Res Function(_$_State) then) =
      __$$_StateCopyWithImpl<$Res>;
  @override
  $Res call({Set<String> tags});
}

/// @nodoc
class __$$_StateCopyWithImpl<$Res> extends _$FilterByTagsStateCopyWithImpl<$Res>
    implements _$$_StateCopyWith<$Res> {
  __$$_StateCopyWithImpl(_$_State _value, $Res Function(_$_State) _then)
      : super(_value, (v) => _then(v as _$_State));

  @override
  _$_State get _value => super._value as _$_State;

  @override
  $Res call({
    Object? tags = freezed,
  }) {
    return _then(_$_State(
      tags == freezed
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$_State implements _State {
  _$_State(final Set<String> tags) : _tags = tags;

  final Set<String> _tags;
  @override
  Set<String> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_tags);
  }

  @override
  String toString() {
    return 'FilterByTagsState(tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_State &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  _$$_StateCopyWith<_$_State> get copyWith =>
      __$$_StateCopyWithImpl<_$_State>(this, _$identity);
}

abstract class _State implements FilterByTagsState {
  factory _State(final Set<String> tags) = _$_State;

  @override
  Set<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$_StateCopyWith<_$_State> get copyWith =>
      throw _privateConstructorUsedError;
}
