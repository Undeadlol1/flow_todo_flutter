import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

// TODO rename
abstract class SerializableDocument extends UserCreatedDocument {
  SerializableDocument({
    required super.id,
    required super.userId,
    required super.createdAt,
  });

  fromJson(Map<String, Object?> json);
  Map<String, dynamic> toJson();
}
