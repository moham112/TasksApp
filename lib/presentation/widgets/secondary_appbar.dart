import 'package:flutter/material.dart';

class SecodaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;

  SecodaryAppBar({
    required this.title,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset("assets/images/arrow-right.png"),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
