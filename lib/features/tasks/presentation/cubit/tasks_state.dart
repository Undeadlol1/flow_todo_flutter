part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {
  final List<Task> tasks = [];
}

class TasksInitial extends TasksState {}
