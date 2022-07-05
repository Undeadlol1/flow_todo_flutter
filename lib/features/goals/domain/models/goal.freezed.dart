// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  int get steps => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  int? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res>;
  $Res call(
      {int steps,
      int points,
      String title,
      String id,
      String userId,
      int createdAt,
      int? updatedAt});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res> implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  final Goal _value;
  // ignore: unused_field
  final $Res Function(Goal) _then;

  @override
  $Res call({
    Object? steps = freezed,
    Object? points = freezed,
    Object? title = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      steps: steps == freezed
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$_GoalCopyWith(_$_Goal value, $Res Function(_$_Goal) then) =
      __$$_GoalCopyWithImpl<$Res>;
  @override
  $Res call(
      {int steps,
      int points,
      String title,
      String id,
      String userId,
      int createdAt,
      int? updatedAt});
}

/// @nodoc
class __$$_GoalCopyWithImpl<$Res> extends _$GoalCopyWithImpl<$Res>
    implements _$$_GoalCopyWith<$Res> {
  __$$_GoalCopyWithImpl(_$_Goal _value, $Res Function(_$_Goal) _then)
      : super(_value, (v) => _then(v as _$_Goal));

  @override
  _$_Goal get _value => super._value as _$_Goal;

  @override
  $Res call({
    Object? steps = freezed,
    Object? points = freezed,
    Object? title = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Goal(
      steps: steps == freezed
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Goal implements _Goal {
  const _$_Goal(
      {required this.steps,
      required this.points,
      required this.title,
      required this.id,
      required this.userId,
      required this.createdAt,
      this.updatedAt});

  factory _$_Goal.fromJson(Map<String, dynamic> json) => _$$_GoalFromJson(json);

  @override
  final int steps;
  @override
  final int points;
  @override
  final String title;
  @override
  final String id;
  @override
  final String userId;
  @override
  final int createdAt;
  @override
  final int? updatedAt;

  @override
  String toString() {
    return 'Goal(steps: $steps, points: $points, title: $title, id: $id, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Goal &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            const DeepCollectionEquality().equals(other.points, points) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(steps),
      const DeepCollectionEquality().hash(points),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_GoalCopyWith<_$_Goal> get copyWith =>
      __$$_GoalCopyWithImpl<_$_Goal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoalToJson(this);
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {required final int steps,
      required final int points,
      required final String title,
      required final String id,
      required final String userId,
      required final int createdAt,
      final int? updatedAt}) = _$_Goal;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$_Goal.fromJson;

  @override
  int get steps => throw _privateConstructorUsedError;
  @override
  int get points => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  int get createdAt => throw _privateConstructorUsedError;
  @override
  int? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GoalCopyWith<_$_Goal> get copyWith => throw _privateConstructorUsedError;
}
