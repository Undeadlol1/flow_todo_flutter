import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:uuid/uuid.dart';

final taskFixture2 = Task(
  dueAt: 0,
  tags: [],
  history: [],
  createdAt: 0,
  isDone: false,
  title: 'title 2',
  userId: 'userId 2',
  id: const Uuid().v4(),
);
