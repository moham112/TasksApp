import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_clone/business_logic/cubit/task_cubit.dart';
import 'package:tasky_clone/business_logic/cubit/user_cubit.dart';
import 'package:tasky_clone/data/repository/task_repository.dart';
import 'package:tasky_clone/data/repository/user_repository.dart';
import 'package:tasky_clone/data/web_services/tasks_firebase.dart';
import 'package:tasky_clone/data/web_services/user_firebase.dart';
import 'package:tasky_clone/presentation/pages/ATask.dart';
import 'package:tasky_clone/presentation/pages/add_edit_task.dart';
import 'package:tasky_clone/presentation/pages/intro.dart';
import 'package:tasky_clone/presentation/pages/login.dart';
import 'package:tasky_clone/presentation/pages/profile.dart';
import 'package:tasky_clone/presentation/pages/register.dart';
import 'package:tasky_clone/presentation/pages/splash_screen.dart';
import 'package:tasky_clone/presentation/pages/tasks.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tasky_clone/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // TaskyUser.listenToUserAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
          log("");
          Navigator.pushNamed(context, "login");
        } else {
          print('User is signed in!');
        }
      },
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(UserRepository(UserFirebase())),
        ),
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(TaskRepository(TasksFirebase())),
        ),
      ],
      child: MaterialApp(
        initialRoute: "splash",
        routes: {
          "splash": (context) => const SplashScreen(),
          "intro": (context) => const Intro(),
          "login": (context) => const Login(),
          "register": (context) => const Register(),
          "tasks": (context) => const Tasks(),
          "atasks": (context) => const Atask(),
          "add_edit_task": (context) => AddEditTask(),
          "profile": (context) => const Profile(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xff5F33E1),
          fontFamily: "DMSans",
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
