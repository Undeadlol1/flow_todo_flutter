// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      points: json['points'] as int?,
      updatedAt: json['updatedAt'] as int?,
      experience: json['experience'] as int?,
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as int,
      areEcouragingMessagesDisabled:
          json['areEcouragingMessagesDisabled'] as bool,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'experience': instance.experience,
      'points': instance.points,
      'updatedAt': instance.updatedAt,
      'areEcouragingMessagesDisabled': instance.areEcouragingMessagesDisabled,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'userId': instance.userId,
    };
