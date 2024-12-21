class Task {
  String? id;
  late String image;
  late String title;
  late String desc;
  late String priority;
  late String due_date;
  late String status;
  Task({
    this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.due_date,
    required this.status,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    try {
      return Task(
        id: map['id'],
        image: map['image'] ?? '',
        title: map['title'] ?? 'Untitled',
        desc: map['desc'] ?? '',
        due_date: map['due_date'] ?? '',
        priority: map['priority'],
        status: map['status'] ?? 'pending',
      );
    } catch (e) {
      throw Exception("Invalid task data: $map");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "title": title,
      "desc": desc,
      "due_date": due_date,
      "priority": priority,
      "status": status,
    };
  }
}
