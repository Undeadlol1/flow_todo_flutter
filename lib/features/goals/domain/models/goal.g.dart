// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goal _$$_GoalFromJson(Map<String, dynamic> json) => _$_Goal(
      steps: json['steps'] as int,
      points: json['points'] as int,
      title: json['title'] as String,
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$$_GoalToJson(_$_Goal instance) => <String, dynamic>{
      'steps': instance.steps,
      'points': instance.points,
      'title': instance.title,
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
