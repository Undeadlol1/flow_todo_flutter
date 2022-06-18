// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      note: json['note'] as String? ?? '',
      title: json['name'] as String,
      dueAt: json['dueAt'] as int,
      isDone: json['isDone'] as bool,
      userId: json['userId'] as String,
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => TaskHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] as int,
      doneAt: json['doneAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      repetitionLevel: json['repetitionLevel'] as int?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.title,
      'note': instance.note,
      'isDone': instance.isDone,
      'repetitionLevel': instance.repetitionLevel,
      'dueAt': instance.dueAt,
      'doneAt': instance.doneAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tags': instance.tags,
      'history': instance.history.map((e) => e.toJson()).toList(),
    };
