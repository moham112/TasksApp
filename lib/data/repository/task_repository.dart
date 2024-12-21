import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:tasky_clone/data/models/task.dart';
import 'package:tasky_clone/data/web_services/tasks_firebase.dart';

class TaskRepository {
  final TasksFirebase tasksFirebase;

  TaskRepository(this.tasksFirebase);

  Future<List<Task>> getAllTasks() async {
    List<Map<String, dynamic>> listOfRawTasks = await TasksFirebase()
        .getTasksForSpecificUser(FirebaseAuth.instance.currentUser!.uid);
    final mtasks = listOfRawTasks.map((e) => Task.fromMap(e)).toList();

    return mtasks;
  }

  Future<void> submitTask(Map<String, dynamic> map) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    tasks.add({
      "owner": map['owner'],
      "image": map['image'],
      "title": map['title'],
      "desc": map['desc'],
      "due_date": map['due_date'],
      "priority": map['priority'],
      "status": map['status'],
    });
  }

  Future<void> editTask(String docId,Task task) async {
    try {
      DocumentReference doc_ref =
          FirebaseFirestore.instance.collection("tasks").doc(docId);
      await doc_ref.update(
       task.toJson()
      );
    } on Exception catch (e) {
      Logger().e(e.toString());
    }
  }
}
