import 'package:flutter/material.dart';
import 'package:tasky_clone/presentation/widgets/secondary_appbar.dart';

class Atask extends StatefulWidget {
  const Atask({super.key});

  @override
  State<Atask> createState() => _AtaskState();
}

class _AtaskState extends State<Atask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecodaryAppBar(
        title: "Task Details",
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.zero,
            menuPadding: EdgeInsets.zero,
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              )),
              PopupMenuItem(
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/task_image.png"),
            SizedBox(height: 25),
            Text(
              "Grocery Shopping App",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "This application is designed for super shops. By using\n"
              "this application they can enlist all their products in one\n"
              "place and can deliver. Customers will get a one-stop\n"
              "solution for their daily shopping.",
            ),
          ],
        ),
      ),
    );
  }
}
