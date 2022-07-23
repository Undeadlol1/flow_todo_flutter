// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_streak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyStreak _$$_DailyStreakFromJson(Map<String, dynamic> json) =>
    _$_DailyStreak(
      updatedAt: json['updatedAt'] as int?,
      id: json['id'] as String,
      userId: json['userId'] as String,
      perDay: json['perDay'] as int,
      startsAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['startsAt'] as int),
      createdAt: const MillisecondsToDateTimePropertyConverter()
          .fromJson(json['createdAt'] as int),
    );

Map<String, dynamic> _$$_DailyStreakToJson(_$_DailyStreak instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'userId': instance.userId,
      'perDay': instance.perDay,
      'startsAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.startsAt),
      'createdAt': const MillisecondsToDateTimePropertyConverter()
          .toJson(instance.createdAt),
    };
