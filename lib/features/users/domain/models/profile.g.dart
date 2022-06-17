// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      updatedAt: json['updatedAt'] as int?,
      experience: json['experience'] as int?,
      points: json['points'] as int,
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as int,
      dailyStreak:
          DailyStreak.fromJson(json['dailyStreak'] as Map<String, dynamic>),
      areEcouragingMessagesDisabled:
          json['areEcouragingMessagesDisabled'] as bool,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'experience': instance.experience,
      'points': instance.points,
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'dailyStreak': instance.dailyStreak.toJson(),
      'areEcouragingMessagesDisabled': instance.areEcouragingMessagesDisabled,
    };
