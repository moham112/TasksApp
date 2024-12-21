import 'package:flutter/material.dart';
import 'package:tasky_clone/presentation/widgets/primary_button.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/ART.png",
            ),
            const Text(
              "Task Management &\nTo-Do List",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!",
              style: TextStyle(
                height: 1.75,
                color: Color(0xff6E6A7C),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "login");
                },
                text: "Let's Started",
                image: Image.asset("assets/images/arrow-left.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
