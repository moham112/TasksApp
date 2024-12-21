import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_clone/business_logic/cubit/task_cubit.dart';
import 'package:tasky_clone/core/constants.dart';
import 'package:tasky_clone/data/models/task.dart';
import 'package:tasky_clone/presentation/widgets/task_element.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  void initState() {
    BlocProvider.of<TaskCubit>(context).getAllTasksForUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<TaskCubit>(context).getAllTasksForUser();

    return Scaffold(
      appBar: PrimaryAppBar(),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            List<Task> mtasks = state.tasks;
            mtasks.toString();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        "My Tasks",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            setState(() {
                              BlocProvider.of<TaskCubit>(context)
                                  .getAllTasksForUser();
                            });
                          },
                          child: Icon(Icons.refresh))
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(task_status.length, (index) {
                      return InkWell(
                        onTap: () {
                          if (task_status[index] == "Finished") {
                          } else if (task_status[index] == "Waiting") {
                          } else if (task_status[index] == "InProgress") {}
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Text(
                            task_status[index],
                            style: TextStyle(
                              color:
                                  index == 0 ? Colors.white : Color(0xff7C7C80),
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: index == 0
                                ? Theme.of(context).primaryColor
                                : Color(0xffF0ECFF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    })
                  ],
                ),
                SizedBox(height: 20),
                if (mtasks.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: mtasks.length,
                      itemBuilder: (context, index) {
                        return TaskElement(
                          id: mtasks[index].id,
                          image: "assets/images/task_image.png",
                          title: mtasks[index].title,
                          desc: mtasks[index].desc,
                          status: mtasks[index].status,
                          priority: mtasks[index].priority,
                          date: mtasks[index].due_date,
                        );
                      },
                    ),
                  )
                else
                  Image.asset("assets/images/no-tasks.jpg")
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: Color(0xffEBE5FF),
              shape: CircleBorder(),
            ),
            onPressed: () {},
            child: Image.asset(
              "assets/images/qr.png",
              width: 25,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Color(0xff5F33E1),
                onPressed: () {
                  Navigator.pushNamed(context, "add_edit_task");
                },
                child: Image.asset("assets/images/plus.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
