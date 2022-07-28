import 'package:flow_todo_flutter_2022/features/quests/domain/entities/quest_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/services/milliseconds_to_datetime_property_converter.dart';
import '../entities/quest_type_entity.dart';

part 'quest.freezed.dart';
part 'quest.g.dart';

@freezed
@Implements<QuestEntity>()
class Quest with _$Quest {
  @JsonSerializable(explicitToJson: true)
  factory Quest({
    required String id,
    required bool isDone,
    required String userId,
    required QuestTypeEntity type,
    @MillisecondsToDateTimePropertyConverter() required DateTime createdAt,
    int? doneAt,
    int? updatedAt,
  }) = _Quest;

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);
}
