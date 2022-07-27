import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:uuid/uuid.dart';

final taskFixture2 = Task(
  tags: [],
  history: [],
  isDone: false,
  note: 'a note',
  title: 'title 2',
  userId: 'userId 2',
  dueAt: DateTime.now(),
  createdAt: DateTime.now(),
  id: const Uuid().v4(),
);
