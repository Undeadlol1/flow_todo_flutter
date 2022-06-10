import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

final taskFixture = Task(
  id: 'id',
  tags: [],
  history: [],
  isDone: false,
  title: 'title',
  userId: 'userId',
  dueAt: DateTime.now().millisecondsSinceEpoch,
  createdAt: DateTime.now().millisecondsSinceEpoch,
);
