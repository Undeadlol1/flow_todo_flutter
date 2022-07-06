import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

final taskFixture = Task(
  id: 'task fixture id 123',
  tags: [],
  history: [],
  isDone: false,
  title: 'title',
  userId: 'userId',
  note: 'a task note',
  dueAt: DateTime.now(),
  createdAt: DateTime.now(),
);
