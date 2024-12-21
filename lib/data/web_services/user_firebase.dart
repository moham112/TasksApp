import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class UserFirebase {
  Future<Map<String, dynamic>> getUser(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> tuser = {};

    try {
      QuerySnapshot snapshot = await users.where('uid', isEqualTo: uid).get();
      if (snapshot.docs.isNotEmpty) {
        tuser = snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        Logger().i("is empty ${uid}");
      }
    } catch (error) {
      Logger().e("Error: $error");
    }

    return tuser;
  }
}
