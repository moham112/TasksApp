part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class NotFoundUser extends TaskState {}
