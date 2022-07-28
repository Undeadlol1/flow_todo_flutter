// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Quest _$QuestFromJson(Map<String, dynamic> json) {
  return _Quest.fromJson(json);
}

/// @nodoc
mixin _$Quest {
  String get id => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  QuestTypeEntity get type => throw _privateConstructorUsedError;
  @MillisecondsToDateTimePropertyConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get doneAt => throw _privateConstructorUsedError;
  int? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestCopyWith<Quest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestCopyWith<$Res> {
  factory $QuestCopyWith(Quest value, $Res Function(Quest) then) =
      _$QuestCopyWithImpl<$Res>;
  $Res call(
      {String id,
      bool isDone,
      String userId,
      QuestTypeEntity type,
      @MillisecondsToDateTimePropertyConverter() DateTime createdAt,
      int? doneAt,
      int? updatedAt});
}

/// @nodoc
class _$QuestCopyWithImpl<$Res> implements $QuestCopyWith<$Res> {
  _$QuestCopyWithImpl(this._value, this._then);

  final Quest _value;
  // ignore: unused_field
  final $Res Function(Quest) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? isDone = freezed,
    Object? userId = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? doneAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestTypeEntity,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      doneAt: doneAt == freezed
          ? _value.doneAt
          : doneAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_QuestCopyWith<$Res> implements $QuestCopyWith<$Res> {
  factory _$$_QuestCopyWith(_$_Quest value, $Res Function(_$_Quest) then) =
      __$$_QuestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      bool isDone,
      String userId,
      QuestTypeEntity type,
      @MillisecondsToDateTimePropertyConverter() DateTime createdAt,
      int? doneAt,
      int? updatedAt});
}

/// @nodoc
class __$$_QuestCopyWithImpl<$Res> extends _$QuestCopyWithImpl<$Res>
    implements _$$_QuestCopyWith<$Res> {
  __$$_QuestCopyWithImpl(_$_Quest _value, $Res Function(_$_Quest) _then)
      : super(_value, (v) => _then(v as _$_Quest));

  @override
  _$_Quest get _value => super._value as _$_Quest;

  @override
  $Res call({
    Object? id = freezed,
    Object? isDone = freezed,
    Object? userId = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? doneAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Quest(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestTypeEntity,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      doneAt: doneAt == freezed
          ? _value.doneAt
          : doneAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Quest implements _Quest {
  _$_Quest(
      {required this.id,
      required this.isDone,
      required this.userId,
      required this.type,
      @MillisecondsToDateTimePropertyConverter() required this.createdAt,
      this.doneAt,
      this.updatedAt});

  factory _$_Quest.fromJson(Map<String, dynamic> json) =>
      _$$_QuestFromJson(json);

  @override
  final String id;
  @override
  final bool isDone;
  @override
  final String userId;
  @override
  final QuestTypeEntity type;
  @override
  @MillisecondsToDateTimePropertyConverter()
  final DateTime createdAt;
  @override
  final int? doneAt;
  @override
  final int? updatedAt;

  @override
  String toString() {
    return 'Quest(id: $id, isDone: $isDone, userId: $userId, type: $type, createdAt: $createdAt, doneAt: $doneAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Quest &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.isDone, isDone) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.doneAt, doneAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(isDone),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(doneAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_QuestCopyWith<_$_Quest> get copyWith =>
      __$$_QuestCopyWithImpl<_$_Quest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuestToJson(this);
  }
}

abstract class _Quest implements Quest {
  factory _Quest(
      {required final String id,
      required final bool isDone,
      required final String userId,
      required final QuestTypeEntity type,
      @MillisecondsToDateTimePropertyConverter()
          required final DateTime createdAt,
      final int? doneAt,
      final int? updatedAt}) = _$_Quest;

  factory _Quest.fromJson(Map<String, dynamic> json) = _$_Quest.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get isDone => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  QuestTypeEntity get type => throw _privateConstructorUsedError;
  @override
  @MillisecondsToDateTimePropertyConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  int? get doneAt => throw _privateConstructorUsedError;
  @override
  int? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QuestCopyWith<_$_Quest> get copyWith =>
      throw _privateConstructorUsedError;
}
