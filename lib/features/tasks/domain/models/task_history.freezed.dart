// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskHistory _$TaskHistoryFromJson(Map<String, dynamic> json) {
  return _TaskHistory.fromJson(json);
}

/// @nodoc
mixin _$TaskHistory {
  TaskHistoryActionType get actionType => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  int? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskHistoryCopyWith<TaskHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskHistoryCopyWith<$Res> {
  factory $TaskHistoryCopyWith(
          TaskHistory value, $Res Function(TaskHistory) then) =
      _$TaskHistoryCopyWithImpl<$Res>;
  $Res call(
      {TaskHistoryActionType actionType,
      int createdAt,
      String? taskId,
      String? userId,
      String? comment,
      int? updatedAt});
}

/// @nodoc
class _$TaskHistoryCopyWithImpl<$Res> implements $TaskHistoryCopyWith<$Res> {
  _$TaskHistoryCopyWithImpl(this._value, this._then);

  final TaskHistory _value;
  // ignore: unused_field
  final $Res Function(TaskHistory) _then;

  @override
  $Res call({
    Object? actionType = freezed,
    Object? createdAt = freezed,
    Object? taskId = freezed,
    Object? userId = freezed,
    Object? comment = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      actionType: actionType == freezed
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as TaskHistoryActionType,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      taskId: taskId == freezed
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_TaskHistoryCopyWith<$Res>
    implements $TaskHistoryCopyWith<$Res> {
  factory _$$_TaskHistoryCopyWith(
          _$_TaskHistory value, $Res Function(_$_TaskHistory) then) =
      __$$_TaskHistoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {TaskHistoryActionType actionType,
      int createdAt,
      String? taskId,
      String? userId,
      String? comment,
      int? updatedAt});
}

/// @nodoc
class __$$_TaskHistoryCopyWithImpl<$Res> extends _$TaskHistoryCopyWithImpl<$Res>
    implements _$$_TaskHistoryCopyWith<$Res> {
  __$$_TaskHistoryCopyWithImpl(
      _$_TaskHistory _value, $Res Function(_$_TaskHistory) _then)
      : super(_value, (v) => _then(v as _$_TaskHistory));

  @override
  _$_TaskHistory get _value => super._value as _$_TaskHistory;

  @override
  $Res call({
    Object? actionType = freezed,
    Object? createdAt = freezed,
    Object? taskId = freezed,
    Object? userId = freezed,
    Object? comment = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_TaskHistory(
      actionType: actionType == freezed
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as TaskHistoryActionType,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      taskId: taskId == freezed
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TaskHistory implements _TaskHistory {
  const _$_TaskHistory(
      {required this.actionType,
      required this.createdAt,
      this.taskId,
      this.userId,
      this.comment,
      this.updatedAt});

  factory _$_TaskHistory.fromJson(Map<String, dynamic> json) =>
      _$$_TaskHistoryFromJson(json);

  @override
  final TaskHistoryActionType actionType;
  @override
  final int createdAt;
  @override
  final String? taskId;
  @override
  final String? userId;
  @override
  final String? comment;
  @override
  final int? updatedAt;

  @override
  String toString() {
    return 'TaskHistory(actionType: $actionType, createdAt: $createdAt, taskId: $taskId, userId: $userId, comment: $comment, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskHistory &&
            const DeepCollectionEquality()
                .equals(other.actionType, actionType) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.taskId, taskId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actionType),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(taskId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_TaskHistoryCopyWith<_$_TaskHistory> get copyWith =>
      __$$_TaskHistoryCopyWithImpl<_$_TaskHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskHistoryToJson(this);
  }
}

abstract class _TaskHistory implements TaskHistory {
  const factory _TaskHistory(
      {required final TaskHistoryActionType actionType,
      required final int createdAt,
      final String? taskId,
      final String? userId,
      final String? comment,
      final int? updatedAt}) = _$_TaskHistory;

  factory _TaskHistory.fromJson(Map<String, dynamic> json) =
      _$_TaskHistory.fromJson;

  @override
  TaskHistoryActionType get actionType => throw _privateConstructorUsedError;
  @override
  int get createdAt => throw _privateConstructorUsedError;
  @override
  String? get taskId => throw _privateConstructorUsedError;
  @override
  String? get userId => throw _privateConstructorUsedError;
  @override
  String? get comment => throw _privateConstructorUsedError;
  @override
  int? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TaskHistoryCopyWith<_$_TaskHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
