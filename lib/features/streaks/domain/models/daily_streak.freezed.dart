// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'daily_streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyStreak _$DailyStreakFromJson(Map<String, dynamic> json) {
  return _DailyStreak.fromJson(json);
}

/// @nodoc
mixin _$DailyStreak {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get perDay => throw _privateConstructorUsedError;
  @OptionalMillisecondsToDateTimePropertyConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @MillisecondsToDateTimePropertyConverter()
  DateTime get startsAt => throw _privateConstructorUsedError;
  @MillisecondsToDateTimePropertyConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyStreakCopyWith<DailyStreak> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStreakCopyWith<$Res> {
  factory $DailyStreakCopyWith(
          DailyStreak value, $Res Function(DailyStreak) then) =
      _$DailyStreakCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      int perDay,
      @OptionalMillisecondsToDateTimePropertyConverter() DateTime? updatedAt,
      @MillisecondsToDateTimePropertyConverter() DateTime startsAt,
      @MillisecondsToDateTimePropertyConverter() DateTime createdAt});
}

/// @nodoc
class _$DailyStreakCopyWithImpl<$Res> implements $DailyStreakCopyWith<$Res> {
  _$DailyStreakCopyWithImpl(this._value, this._then);

  final DailyStreak _value;
  // ignore: unused_field
  final $Res Function(DailyStreak) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? perDay = freezed,
    Object? updatedAt = freezed,
    Object? startsAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      perDay: perDay == freezed
          ? _value.perDay
          : perDay // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startsAt: startsAt == freezed
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_DailyStreakCopyWith<$Res>
    implements $DailyStreakCopyWith<$Res> {
  factory _$$_DailyStreakCopyWith(
          _$_DailyStreak value, $Res Function(_$_DailyStreak) then) =
      __$$_DailyStreakCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      int perDay,
      @OptionalMillisecondsToDateTimePropertyConverter() DateTime? updatedAt,
      @MillisecondsToDateTimePropertyConverter() DateTime startsAt,
      @MillisecondsToDateTimePropertyConverter() DateTime createdAt});
}

/// @nodoc
class __$$_DailyStreakCopyWithImpl<$Res> extends _$DailyStreakCopyWithImpl<$Res>
    implements _$$_DailyStreakCopyWith<$Res> {
  __$$_DailyStreakCopyWithImpl(
      _$_DailyStreak _value, $Res Function(_$_DailyStreak) _then)
      : super(_value, (v) => _then(v as _$_DailyStreak));

  @override
  _$_DailyStreak get _value => super._value as _$_DailyStreak;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? perDay = freezed,
    Object? updatedAt = freezed,
    Object? startsAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_DailyStreak(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      perDay: perDay == freezed
          ? _value.perDay
          : perDay // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startsAt: startsAt == freezed
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyStreak extends _DailyStreak {
  const _$_DailyStreak(
      {required this.id,
      required this.userId,
      required this.perDay,
      @OptionalMillisecondsToDateTimePropertyConverter() this.updatedAt,
      @MillisecondsToDateTimePropertyConverter() required this.startsAt,
      @MillisecondsToDateTimePropertyConverter() required this.createdAt})
      : super._();

  factory _$_DailyStreak.fromJson(Map<String, dynamic> json) =>
      _$$_DailyStreakFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final int perDay;
  @override
  @OptionalMillisecondsToDateTimePropertyConverter()
  final DateTime? updatedAt;
  @override
  @MillisecondsToDateTimePropertyConverter()
  final DateTime startsAt;
  @override
  @MillisecondsToDateTimePropertyConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'DailyStreak(id: $id, userId: $userId, perDay: $perDay, updatedAt: $updatedAt, startsAt: $startsAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyStreak &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.perDay, perDay) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.startsAt, startsAt) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(perDay),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(startsAt),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_DailyStreakCopyWith<_$_DailyStreak> get copyWith =>
      __$$_DailyStreakCopyWithImpl<_$_DailyStreak>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyStreakToJson(
      this,
    );
  }
}

abstract class _DailyStreak extends DailyStreak {
  const factory _DailyStreak(
      {required final String id,
      required final String userId,
      required final int perDay,
      @OptionalMillisecondsToDateTimePropertyConverter()
          final DateTime? updatedAt,
      @MillisecondsToDateTimePropertyConverter()
          required final DateTime startsAt,
      @MillisecondsToDateTimePropertyConverter()
          required final DateTime createdAt}) = _$_DailyStreak;
  const _DailyStreak._() : super._();

  factory _DailyStreak.fromJson(Map<String, dynamic> json) =
      _$_DailyStreak.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  int get perDay;
  @override
  @OptionalMillisecondsToDateTimePropertyConverter()
  DateTime? get updatedAt;
  @override
  @MillisecondsToDateTimePropertyConverter()
  DateTime get startsAt;
  @override
  @MillisecondsToDateTimePropertyConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_DailyStreakCopyWith<_$_DailyStreak> get copyWith =>
      throw _privateConstructorUsedError;
}
