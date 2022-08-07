import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/entities/profile_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
@Implements<ProfileEntity>()
class Profile with _$Profile {
  // https://stackoverflow.com/a/71516177
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Profile({
    int? updatedAt,
    required String id,
    required String userId,
    required int createdAt,
    required DailyStreak dailyStreak,
    @JsonKey(defaultValue: 0) required int points,
    @JsonKey(defaultValue: 0) required int experience,
    @JsonKey(defaultValue: false) required bool areEcouragingMessagesDisabled,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
}
