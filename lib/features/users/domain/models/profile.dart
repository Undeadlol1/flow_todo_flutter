import 'package:json_annotation/json_annotation.dart';

import '../entities/profile_entity.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile implements ProfileEntity {
  @override
  int? experience, points, updatedAt;

  @override
  bool areEcouragingMessagesDisabled;

  @override
  final int createdAt;

  @override
  final String id, userId;

  Profile({
    this.points,
    this.updatedAt,
    this.experience,
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.areEcouragingMessagesDisabled,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
