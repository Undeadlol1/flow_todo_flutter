// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Quest _$$_QuestFromJson(Map<String, dynamic> json) => _$_Quest(
      id: json['id'] as String,
      isDone: json['isDone'] as bool,
      userId: json['userId'] as String,
      type: $enumDecode(_$QuestTypeEntityEnumMap, json['type']),
      createdAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['createdAt'] as int),
      doneAt: json['doneAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      isPartOfTutorial: json['isPartOfTutorial'] as bool?,
    );

Map<String, dynamic> _$$_QuestToJson(_$_Quest instance) => <String, dynamic>{
      'id': instance.id,
      'isDone': instance.isDone,
      'userId': instance.userId,
      'type': _$QuestTypeEntityEnumMap[instance.type],
      'createdAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.createdAt),
      'doneAt': instance.doneAt,
      'updatedAt': instance.updatedAt,
      'isPartOfTutorial': instance.isPartOfTutorial,
    };

const _$QuestTypeEntityEnumMap = {
  QuestTypeEntity.reachLevel: 'reachLevel',
  QuestTypeEntity.createTasks: 'createTasks',
  QuestTypeEntity.completeTasks: 'completeTasks',
};
