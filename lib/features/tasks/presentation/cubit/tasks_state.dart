part of 'tasks_cubit.dart';

abstract class TasksState {
  final List<Task> tasks = [];
}

class TasksLoading extends TasksState {}

// TODO rename to TasksLoaded
class TasksUpdated implements TasksState {
  @override
  List<Task> tasks = [];

  TasksUpdated({required this.tasks});
}
