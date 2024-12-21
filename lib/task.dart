class Task {
  String? image;
  String title;
  String? desc;
  String task_priority_choice;
  int data;
  String task_status_choice;

  Task({
    this.image,
    required this.title,
    this.desc,
    required this.task_priority_choice,
    required this.data,
    required this.task_status_choice,
  });
}
