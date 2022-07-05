import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/goal_entity.dart';

part 'goal.g.dart';
part 'goal.freezed.dart';

@freezed
@Implements<GoalEntity>()
class Goal with _$Goal {
  const factory Goal({
    required int steps,
    required int points,
    required String title,
    required String id,
    required String userId,
    required int createdAt,
    int? updatedAt,
  }) = _Goal;

  factory Goal.fromJson(Map<String, Object?> json) => _$GoalFromJson(json);
}
