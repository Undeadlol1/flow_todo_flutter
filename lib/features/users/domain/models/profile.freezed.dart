// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  int? get updatedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  DailyStreak get dailyStreak => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get points => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get experience => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get areEcouragingMessagesDisabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res>;
  $Res call(
      {int? updatedAt,
      String id,
      String userId,
      int createdAt,
      DailyStreak dailyStreak,
      @JsonKey(defaultValue: 0) int points,
      @JsonKey(defaultValue: 0) int experience,
      @JsonKey(defaultValue: false) bool areEcouragingMessagesDisabled});

  $DailyStreakCopyWith<$Res> get dailyStreak;
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res> implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  final Profile _value;
  // ignore: unused_field
  final $Res Function(Profile) _then;

  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? dailyStreak = freezed,
    Object? points = freezed,
    Object? experience = freezed,
    Object? areEcouragingMessagesDisabled = freezed,
  }) {
    return _then(_value.copyWith(
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
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
      dailyStreak: dailyStreak == freezed
          ? _value.dailyStreak
          : dailyStreak // ignore: cast_nullable_to_non_nullable
              as DailyStreak,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      experience: experience == freezed
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      areEcouragingMessagesDisabled: areEcouragingMessagesDisabled == freezed
          ? _value.areEcouragingMessagesDisabled
          : areEcouragingMessagesDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $DailyStreakCopyWith<$Res> get dailyStreak {
    return $DailyStreakCopyWith<$Res>(_value.dailyStreak, (value) {
      return _then(_value.copyWith(dailyStreak: value));
    });
  }
}

/// @nodoc
abstract class _$$_ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$_ProfileCopyWith(
          _$_Profile value, $Res Function(_$_Profile) then) =
      __$$_ProfileCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? updatedAt,
      String id,
      String userId,
      int createdAt,
      DailyStreak dailyStreak,
      @JsonKey(defaultValue: 0) int points,
      @JsonKey(defaultValue: 0) int experience,
      @JsonKey(defaultValue: false) bool areEcouragingMessagesDisabled});

  @override
  $DailyStreakCopyWith<$Res> get dailyStreak;
}

/// @nodoc
class __$$_ProfileCopyWithImpl<$Res> extends _$ProfileCopyWithImpl<$Res>
    implements _$$_ProfileCopyWith<$Res> {
  __$$_ProfileCopyWithImpl(_$_Profile _value, $Res Function(_$_Profile) _then)
      : super(_value, (v) => _then(v as _$_Profile));

  @override
  _$_Profile get _value => super._value as _$_Profile;

  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? dailyStreak = freezed,
    Object? points = freezed,
    Object? experience = freezed,
    Object? areEcouragingMessagesDisabled = freezed,
  }) {
    return _then(_$_Profile(
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
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
      dailyStreak: dailyStreak == freezed
          ? _value.dailyStreak
          : dailyStreak // ignore: cast_nullable_to_non_nullable
              as DailyStreak,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      experience: experience == freezed
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      areEcouragingMessagesDisabled: areEcouragingMessagesDisabled == freezed
          ? _value.areEcouragingMessagesDisabled
          : areEcouragingMessagesDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Profile with DiagnosticableTreeMixin implements _Profile {
  const _$_Profile(
      {this.updatedAt,
      required this.id,
      required this.userId,
      required this.createdAt,
      required this.dailyStreak,
      @JsonKey(defaultValue: 0)
          required this.points,
      @JsonKey(defaultValue: 0)
          required this.experience,
      @JsonKey(defaultValue: false)
          required this.areEcouragingMessagesDisabled});

  factory _$_Profile.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileFromJson(json);

  @override
  final int? updatedAt;
  @override
  final String id;
  @override
  final String userId;
  @override
  final int createdAt;
  @override
  final DailyStreak dailyStreak;
  @override
  @JsonKey(defaultValue: 0)
  final int points;
  @override
  @JsonKey(defaultValue: 0)
  final int experience;
  @override
  @JsonKey(defaultValue: false)
  final bool areEcouragingMessagesDisabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Profile(updatedAt: $updatedAt, id: $id, userId: $userId, createdAt: $createdAt, dailyStreak: $dailyStreak, points: $points, experience: $experience, areEcouragingMessagesDisabled: $areEcouragingMessagesDisabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Profile'))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('dailyStreak', dailyStreak))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('experience', experience))
      ..add(DiagnosticsProperty(
          'areEcouragingMessagesDisabled', areEcouragingMessagesDisabled));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Profile &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.dailyStreak, dailyStreak) &&
            const DeepCollectionEquality().equals(other.points, points) &&
            const DeepCollectionEquality()
                .equals(other.experience, experience) &&
            const DeepCollectionEquality().equals(
                other.areEcouragingMessagesDisabled,
                areEcouragingMessagesDisabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(dailyStreak),
      const DeepCollectionEquality().hash(points),
      const DeepCollectionEquality().hash(experience),
      const DeepCollectionEquality().hash(areEcouragingMessagesDisabled));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      __$$_ProfileCopyWithImpl<_$_Profile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {final int? updatedAt,
      required final String id,
      required final String userId,
      required final int createdAt,
      required final DailyStreak dailyStreak,
      @JsonKey(defaultValue: 0)
          required final int points,
      @JsonKey(defaultValue: 0)
          required final int experience,
      @JsonKey(defaultValue: false)
          required final bool areEcouragingMessagesDisabled}) = _$_Profile;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$_Profile.fromJson;

  @override
  int? get updatedAt;
  @override
  String get id;
  @override
  String get userId;
  @override
  int get createdAt;
  @override
  DailyStreak get dailyStreak;
  @override
  @JsonKey(defaultValue: 0)
  int get points;
  @override
  @JsonKey(defaultValue: 0)
  int get experience;
  @override
  @JsonKey(defaultValue: false)
  bool get areEcouragingMessagesDisabled;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      throw _privateConstructorUsedError;
}
