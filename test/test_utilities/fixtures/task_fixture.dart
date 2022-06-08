import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';

final taskFixture = Task(
  id: 'id',
  history: [],
  isDone: false,
  title: 'title',
  userId: 'userId',
  dueAt: DateTime.now().millisecondsSinceEpoch,
  createdAt: DateTime.now().millisecondsSinceEpoch,
);
