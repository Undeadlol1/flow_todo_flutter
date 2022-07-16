// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String,
      isDone: json['isDone'] as bool,
      userId: json['userId'] as String,
      dueAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['dueAt'] as int),
      createdAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['createdAt'] as int),
      title: json['name'] as String,
      note: json['note'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => TaskHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      doneAt: json['doneAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      repetitionLevel: json['repetitionLevel'] as int?,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'isDone': instance.isDone,
      'userId': instance.userId,
      'dueAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.dueAt),
      'createdAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.createdAt),
      'name': instance.title,
      'note': instance.note,
      'tags': instance.tags,
      'history': instance.history.map((e) => e.toJson()).toList(),
      'doneAt': instance.doneAt,
      'updatedAt': instance.updatedAt,
      'repetitionLevel': instance.repetitionLevel,
    };
