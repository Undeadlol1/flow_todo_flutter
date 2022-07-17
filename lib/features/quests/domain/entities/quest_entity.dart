import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

class QuestEntity implements UserCreatedDocument {
  final bool isDone;

  @override
  final String id;

  @override
  final String userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  QuestEntity({
    required this.id,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });
}
