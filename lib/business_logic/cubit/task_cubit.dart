import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_clone/data/models/task.dart';
import 'package:tasky_clone/data/repository/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskRepository taskRepository;
  List<Task> tasks = [];

  List<Task> getAllTasksForUser() {
    taskRepository.getAllTasks().then(
      (tasks) {
        emit(TasksLoaded(tasks));
        this.tasks = tasks;
      },
    );

    return this.tasks;
  }

  TaskCubit(this.taskRepository) : super(TaskInitial());
}
