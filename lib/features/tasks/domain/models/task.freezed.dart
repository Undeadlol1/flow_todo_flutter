// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @_MillisecondsToDateTimeConverter()
  DateTime get dueAt => throw _privateConstructorUsedError;
  @_MillisecondsToDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get note => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<TaskHistory> get history => throw _privateConstructorUsedError;
  int? get doneAt => throw _privateConstructorUsedError;
  int? get updatedAt => throw _privateConstructorUsedError;
  int? get repetitionLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res>;
  $Res call(
      {String id,
      bool isDone,
      String userId,
      @_MillisecondsToDateTimeConverter() DateTime dueAt,
      @_MillisecondsToDateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'name') String title,
      @JsonKey(defaultValue: '') String note,
      @JsonKey(defaultValue: []) List<String> tags,
      @JsonKey(defaultValue: []) List<TaskHistory> history,
      int? doneAt,
      int? updatedAt,
      int? repetitionLevel});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res> implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  final Task _value;
  // ignore: unused_field
  final $Res Function(Task) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? isDone = freezed,
    Object? userId = freezed,
    Object? dueAt = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? note = freezed,
    Object? tags = freezed,
    Object? history = freezed,
    Object? doneAt = freezed,
    Object? updatedAt = freezed,
    Object? repetitionLevel = freezed,
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
      dueAt: dueAt == freezed
          ? _value.dueAt
          : dueAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<TaskHistory>,
      doneAt: doneAt == freezed
          ? _value.doneAt
          : doneAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionLevel: repetitionLevel == freezed
          ? _value.repetitionLevel
          : repetitionLevel // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      bool isDone,
      String userId,
      @_MillisecondsToDateTimeConverter() DateTime dueAt,
      @_MillisecondsToDateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'name') String title,
      @JsonKey(defaultValue: '') String note,
      @JsonKey(defaultValue: []) List<String> tags,
      @JsonKey(defaultValue: []) List<TaskHistory> history,
      int? doneAt,
      int? updatedAt,
      int? repetitionLevel});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, (v) => _then(v as _$_Task));

  @override
  _$_Task get _value => super._value as _$_Task;

  @override
  $Res call({
    Object? id = freezed,
    Object? isDone = freezed,
    Object? userId = freezed,
    Object? dueAt = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? note = freezed,
    Object? tags = freezed,
    Object? history = freezed,
    Object? doneAt = freezed,
    Object? updatedAt = freezed,
    Object? repetitionLevel = freezed,
  }) {
    return _then(_$_Task(
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
      dueAt: dueAt == freezed
          ? _value.dueAt
          : dueAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      history: history == freezed
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<TaskHistory>,
      doneAt: doneAt == freezed
          ? _value.doneAt
          : doneAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionLevel: repetitionLevel == freezed
          ? _value.repetitionLevel
          : repetitionLevel // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Task implements _Task {
  const _$_Task(
      {required this.id,
      required this.isDone,
      required this.userId,
      @_MillisecondsToDateTimeConverter() required this.dueAt,
      @_MillisecondsToDateTimeConverter() required this.createdAt,
      @JsonKey(name: 'name') required this.title,
      @JsonKey(defaultValue: '') required this.note,
      @JsonKey(defaultValue: []) required final List<String> tags,
      @JsonKey(defaultValue: []) required final List<TaskHistory> history,
      this.doneAt,
      this.updatedAt,
      this.repetitionLevel})
      : _tags = tags,
        _history = history;

  factory _$_Task.fromJson(Map<String, dynamic> json) => _$$_TaskFromJson(json);

  @override
  final String id;
  @override
  final bool isDone;
  @override
  final String userId;
  @override
  @_MillisecondsToDateTimeConverter()
  final DateTime dueAt;
  @override
  @_MillisecondsToDateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey(name: 'name')
  final String title;
  @override
  @JsonKey(defaultValue: '')
  final String note;
  final List<String> _tags;
  @override
  @JsonKey(defaultValue: [])
  List<String> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<TaskHistory> _history;
  @override
  @JsonKey(defaultValue: [])
  List<TaskHistory> get history {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  final int? doneAt;
  @override
  final int? updatedAt;
  @override
  final int? repetitionLevel;

  @override
  String toString() {
    return 'Task(id: $id, isDone: $isDone, userId: $userId, dueAt: $dueAt, createdAt: $createdAt, title: $title, note: $note, tags: $tags, history: $history, doneAt: $doneAt, updatedAt: $updatedAt, repetitionLevel: $repetitionLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.isDone, isDone) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.dueAt, dueAt) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.note, note) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other.doneAt, doneAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.repetitionLevel, repetitionLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(isDone),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(dueAt),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(note),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(doneAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(repetitionLevel));

  @JsonKey(ignore: true)
  @override
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskToJson(this);
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      required final bool isDone,
      required final String userId,
      @_MillisecondsToDateTimeConverter() required final DateTime dueAt,
      @_MillisecondsToDateTimeConverter() required final DateTime createdAt,
      @JsonKey(name: 'name') required final String title,
      @JsonKey(defaultValue: '') required final String note,
      @JsonKey(defaultValue: []) required final List<String> tags,
      @JsonKey(defaultValue: []) required final List<TaskHistory> history,
      final int? doneAt,
      final int? updatedAt,
      final int? repetitionLevel}) = _$_Task;

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get isDone => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  @_MillisecondsToDateTimeConverter()
  DateTime get dueAt => throw _privateConstructorUsedError;
  @override
  @_MillisecondsToDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get title => throw _privateConstructorUsedError;
  @override
  @JsonKey(defaultValue: '')
  String get note => throw _privateConstructorUsedError;
  @override
  @JsonKey(defaultValue: [])
  List<String> get tags => throw _privateConstructorUsedError;
  @override
  @JsonKey(defaultValue: [])
  List<TaskHistory> get history => throw _privateConstructorUsedError;
  @override
  int? get doneAt => throw _privateConstructorUsedError;
  @override
  int? get updatedAt => throw _privateConstructorUsedError;
  @override
  int? get repetitionLevel => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}
