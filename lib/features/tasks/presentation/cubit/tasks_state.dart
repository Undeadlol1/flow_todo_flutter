part of 'tasks_cubit.dart';

abstract class TasksState {
  final List<Task> tasks = [];
}

class TasksInitial extends TasksState {}

class TasksUpdated implements TasksState {
  @override
  List<Task> tasks = [];

  TasksUpdated({required this.tasks});
}
