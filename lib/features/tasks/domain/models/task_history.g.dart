// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskHistory _$$_TaskHistoryFromJson(Map<String, dynamic> json) =>
    _$_TaskHistory(
      actionType:
          $enumDecode(_$TaskHistoryActionTypeEnumMap, json['actionType']),
      createdAt: json['createdAt'] as int,
      taskId: json['taskId'] as String?,
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$$_TaskHistoryToJson(_$_TaskHistory instance) =>
    <String, dynamic>{
      'actionType': _$TaskHistoryActionTypeEnumMap[instance.actionType]!,
      'createdAt': instance.createdAt,
      'taskId': instance.taskId,
      'userId': instance.userId,
      'comment': instance.comment,
      'updatedAt': instance.updatedAt,
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
