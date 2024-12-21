import 'package:logger/logger.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskyUser {
  String name;
  String email;
  int? years_of_experience;
  ExperienceLevel? experience_level;
  String? address;
  String password;

  // @deprecated
  // static void listenToUserAuthentication(BuildContext context) async {
  //   FirebaseAuth.instance.authStateChanges().listen(
  //     (User? user) {
  //       if (user != null) {
  //       } else {
  //         Logger().e("changed");
  //         Navigator.pushNamed(context, "splash");
  //       }
  //     },
  //   );
  // }

  TaskyUser({
    required this.name,
    required this.email,
    this.years_of_experience,
    this.experience_level,
    this.address,
    required this.password,
  });

  static bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  static void signUp({required TaskyUser tuser}) async {
    UserCredential uc =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: tuser.email,
      password: tuser.password,
    );

    // TaskyUser tuser = TaskyUser(
    //   name: tuser.name,
    //   email: uc.user.email,
    //   password: tuser.password,
    //   address: tuser.address,
    //   experience_level: tuser.experience_level,
    //   years_of_experience: tuser.years_of_experience
    // );
    if (uc.user != null)
      registerUserdata(tuser, FirebaseAuth.instance.currentUser!.uid);
  }

  static Future<void> singIn(String email, String password) async {
    UserCredential uc = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // uc.user == null ? print("failed") : print("successfully");
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static void registerUserdata(TaskyUser user, String uid) async {
    CollectionReference users_cr =
        FirebaseFirestore.instance.collection("users");

    await users_cr.add(
      {
        "uid": uid,
        "name": user.name,
        "years_of_experience": user.years_of_experience,
        "experince_level": user.experience_level!.name,
        "address": user.address,
      },
    ).then(
      (value) {
        print("successfully - $value");
      },
    ).catchError(
      (error) {
        Logger().e("There is an error - $error");
      },
    );
  }
}

enum ExperienceLevel {
  Intermediate,
  Advanced,
  Expert,
}
