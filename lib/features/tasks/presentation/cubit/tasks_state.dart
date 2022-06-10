part of 'tasks_cubit.dart';

abstract class TasksState {
  final List<TaskEntity> tasks = [];
}

class TasksInitial extends TasksState {}

class TasksUpdated implements TasksState {
  @override
  List<TaskEntity> tasks = [];

  TasksUpdated({required this.tasks});
}
