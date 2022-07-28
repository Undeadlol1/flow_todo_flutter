import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/entities/quest_type_entity.dart';

class QuestEntity implements UserCreatedDocument {
  final bool isDone;

  int? doneAt;

  @override
  final String id;

  @override
  final String userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  final  QuestTypeEntity type;

  QuestEntity({
    required this.id,
    required this.isDone,
    required this.userId,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });
}
