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
      valueToAchieve: json['valueToAchieve'] as int,
      achievementProgress: json['achievementProgress'] as int,
      initialValue: json['initialValue'] as int?,
      doneAt: json['doneAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      isPartOfTutorial: json['isPartOfTutorial'] as bool?,
      createdAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['createdAt'] as int),
    );

Map<String, dynamic> _$$_QuestToJson(_$_Quest instance) => <String, dynamic>{
      'id': instance.id,
      'isDone': instance.isDone,
      'userId': instance.userId,
      'type': _$QuestTypeEntityEnumMap[instance.type],
      'valueToAchieve': instance.valueToAchieve,
      'achievementProgress': instance.achievementProgress,
      'initialValue': instance.initialValue,
      'doneAt': instance.doneAt,
      'updatedAt': instance.updatedAt,
      'isPartOfTutorial': instance.isPartOfTutorial,
      'createdAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.createdAt),
    };

const _$QuestTypeEntityEnumMap = {
  QuestTypeEntity.reachLevel: 'reachLevel',
  QuestTypeEntity.createTasks: 'createTasks',
  QuestTypeEntity.completeTasks: 'completeTasks',
};
