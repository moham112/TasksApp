import 'package:flutter/material.dart';
import 'package:tasky_clone/tasky_user.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      TaskyUser.isAuthenticated()
          ? Navigator.pushReplacementNamed(context, "tasks")
          : Navigator.pushReplacementNamed(context, "intro");
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: MediaQuery.sizeOf(context).width / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
