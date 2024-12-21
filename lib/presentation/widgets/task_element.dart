import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_clone/business_logic/cubit/task_cubit.dart';
import 'package:tasky_clone/data/models/task.dart';
import 'package:tasky_clone/presentation/pages/ATask.dart';
import 'package:tasky_clone/presentation/pages/add_edit_task.dart';
import 'package:tasky_clone/tasky_user.dart';

class TaskElement extends StatelessWidget {
  String? id;
  String? image;
  String title;
  String status;
  String? desc;
  String priority;
  String date;

  TaskElement({
    this.id,
    this.image,
    required this.title,
    required this.status,
    this.desc,
    required this.priority,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     // builder: () => Atask()
          //   ),
          // );
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(image!),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      TaskStatus(status: status)
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    desc!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      TaskPriority(priority: priority),
                      Spacer(),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: PopupMenuButton(
                  onSelected: (item) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          Task(
                            image: this.image!,
                            title: this.title,
                            desc: this.desc!,
                            priority: this.priority,
                            due_date: this.date,
                            status: this.status,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTask(
                                task: Task(
                                  id: this.id,
                                  image: this.image!,
                                  title: this.title,
                                  desc: this.desc!,
                                  priority: priority,
                                  due_date: this.date,
                                  status: this.status,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ];
                  },
                  child: Image.asset("assets/images/3pts.png")),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case "Finished":
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(
            "Finished",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xffFF7D53),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xffFFE4F2),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      case "InProgress":
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(status,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff0087FF),
              )),
          decoration: BoxDecoration(
            color: Color(0xffE3F2FF),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      case "Waiting":
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(status,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff5F33E1),
              )),
          decoration: BoxDecoration(
            color: Color(0xffF0ECFF),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      default:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(status,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff5F33E1),
              )),
          decoration: BoxDecoration(
            color: Color(0xffF0ECFF),
            borderRadius: BorderRadius.circular(5),
          ),
        );
    }
  }
}

class TaskPriority extends StatelessWidget {
  const TaskPriority({
    super.key,
    required this.priority,
  });

  final String priority;

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      case "Low":
        return Row(
          children: [
            Image.asset("assets/images/cyan-flag.png"),
            SizedBox(width: 5),
            Text(
              priority,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff0087FF),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      case "Medium":
        return Row(
          children: [
            Image.asset("assets/images/violet-flag.png"),
            SizedBox(width: 5),
            Text(
              priority,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff5F33E1),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      case "Heigh":
        return Row(
          children: [
            Image.asset("assets/images/orange-flag.png"),
            SizedBox(width: 5),
            Text(
              priority,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xffFF7D53),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      default:
        return Row(
          children: [
            Image.asset("assets/images/cyan-flag.png"),
            SizedBox(width: 5),
            Text(
              priority,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff5F33E1),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
    }
  }
}

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Logo",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        InkWell(
          onTap: () async {
            Navigator.pushNamed(context, "profile");
          },
          child: Image.asset("assets/images/person.png"),
        ),
        SizedBox(width: 20),
        InkWell(
            onTap: () {
              BlocProvider.of<TaskCubit>(context).tasks.clear();
              TaskyUser.signOut();
              Navigator.pushReplacementNamed(context, "splash");
            },
            child: Image.asset("assets/images/exit.png")),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
