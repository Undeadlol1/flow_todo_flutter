// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_worked_on_today_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_loading _$$_loadingFromJson(Map<String, dynamic> json) => _$_loading(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_loadingToJson(_$_loading instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_loaded _$$_loadedFromJson(Map<String, dynamic> json) => _$_loaded(
      (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_loadedToJson(_$_loaded instance) => <String, dynamic>{
      'tasks': instance.tasks,
      'runtimeType': instance.$type,
    };
