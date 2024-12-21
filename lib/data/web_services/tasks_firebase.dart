import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:logger/logger.dart';

class TasksFirebase {
  Future<List<Map<String, dynamic>>> getTasksForSpecificUser(String uid) async {
    List<Map<String, dynamic>> tasks = [];
    final task_cr = FirebaseFirestore.instance.collection("tasks");

    await task_cr.where("owner", isEqualTo: uid).get().then((QuerySnapshot qs) {
      qs.docs.forEach(
        (element) {
          final task = element.data() as Map<String, dynamic>;
          task['id'] = element.id;
          tasks.add(task);
        },
      );
    });

    return tasks;
  }
}
