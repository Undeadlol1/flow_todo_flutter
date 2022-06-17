// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskHistory _$TaskHistoryFromJson(Map<String, dynamic> json) => TaskHistory(
      actionType:
          $enumDecode(_$TaskHistoryActionTypeEnumMap, json['actionType']),
      createdAt: json['createdAt'] as int,
      taskId: json['taskId'] as String?,
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$TaskHistoryToJson(TaskHistory instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'actionType': _$TaskHistoryActionTypeEnumMap[instance.actionType],
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'taskId': instance.taskId,
      'userId': instance.userId,
    };

const _$TaskHistoryActionTypeEnumMap = {
  TaskHistoryActionType.doneTask: 'doneTask',
  TaskHistoryActionType.postpone: 'postpone',
  TaskHistoryActionType.stepForward: 'stepForward',
  TaskHistoryActionType.leapForward: 'leapForward',
  TaskHistoryActionType.updateName: 'updateName',
  TaskHistoryActionType.updateNote: 'updateNote',
  TaskHistoryActionType.doneSubtask: 'doneSubtask',
  TaskHistoryActionType.updateSubtask: 'updateSubtask',
  TaskHistoryActionType.addSubtask: 'addSubtask',
  TaskHistoryActionType.deleteSubtask: 'deleteSubtask',
};
