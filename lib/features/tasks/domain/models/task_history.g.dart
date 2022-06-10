// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskHistory _$TaskHistoryFromJson(Map<String, dynamic> json) => TaskHistory(
      actionType: json['actionType'] as String,
      createdAt: json['createdAt'] as int,
      taskId: json['taskId'] as String?,
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$TaskHistoryToJson(TaskHistory instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'actionType': instance.actionType,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'taskId': instance.taskId,
      'userId': instance.userId,
    };
