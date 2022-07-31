// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      updatedAt: json['updatedAt'] as int?,
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as int,
      dailyStreak:
          DailyStreak.fromJson(json['dailyStreak'] as Map<String, dynamic>),
      experience: json['experience'] as int? ?? 0,
      points: json['points'] as int? ?? 0,
      areEcouragingMessagesDisabled:
          json['areEcouragingMessagesDisabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'dailyStreak': instance.dailyStreak.toJson(),
      'experience': instance.experience,
      'points': instance.points,
      'areEcouragingMessagesDisabled': instance.areEcouragingMessagesDisabled,
    };
