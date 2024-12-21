import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_clone/business_logic/cubit/task_cubit.dart';
import 'package:tasky_clone/data/models/task.dart';
import 'package:tasky_clone/data/repository/task_repository.dart';
import 'package:tasky_clone/data/web_services/tasks_firebase.dart';
import 'package:tasky_clone/presentation/widgets/primary_button.dart';
import 'package:tasky_clone/presentation/widgets/primary_textformfield.dart';
import 'package:tasky_clone/presentation/widgets/secondary_appbar.dart';
import 'package:image_picker/image_picker.dart';

class AddEditTask extends StatefulWidget {
  Task? task;

  AddEditTask({super.key, this.task});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  String? _id;
  String? _selectedPriority;
  String? _selectedStatus;
  DateTime? _selectedDate;
  TextEditingController title_ctrl = TextEditingController();
  TextEditingController desc_ctrl = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final List<String> _priorities = [
    "Low",
    "Medium",
    "Heigh",
  ];
  final List<String> _status = [
    "InProgress",
    "Waiting",
    "Finished",
  ];

  Future<void> _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    if (widget.task != null) {
      _id = widget.task!.id!;
      title_ctrl.text = widget.task!.title;
      desc_ctrl.text = widget.task!.desc;
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
      _selectedDate = DateTime.tryParse(widget.task!.due_date);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SecodaryAppBar(
        title: "Add new task",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            InkWell(
              onTap: _pickImage,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/add_img.png"),
                    SizedBox(width: 10),
                    Text(
                      "Add Img",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Task Title"),
            SizedBox(height: 7),
            PrimaryTextformfield(
              controller: title_ctrl,
              obsecure: false,
              hint: "Enter title here...",
            ),
            SizedBox(height: 10),
            Text("Task Description"),
            SizedBox(height: 7),
            TextFormField(
              controller: desc_ctrl,
              minLines: 6,
              maxLines: 6,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                hintText: "Enter description here",
                hintStyle: const TextStyle(
                  color: Color(0xffBABABA),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Priority"),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF0ECFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPriority,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.purple),
                  hint: Row(
                    children: [
                      const Text(
                        "Choose Priority",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  items: _priorities.map((String priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Row(
                        children: [
                          Text(
                            priority,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Status"),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF0ECFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.purple),
                  hint: Row(
                    children: [
                      const Text(
                        "Choose Status",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  items: _status.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Row(
                        children: [
                          Text(
                            status,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Due Date"),
            SizedBox(height: 5),
            InkWell(
              onTap: _pickDueDate,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Choose due date..."
                          : "${_selectedDate?.toLocal().toString().split(' ')[0]}",
                      style: TextStyle(
                        color: _selectedDate == null
                            ? Colors.grey
                            : Colors.deepPurple,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.purple),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            PrimaryButton(
                onPressed: () {
                  if (widget.task == null) {
                    TaskRepository(TasksFirebase()).submitTask({
                      "owner": FirebaseAuth.instance.currentUser!.uid,
                      "image": "assets/images/task_image.png",
                      "title": title_ctrl.text,
                      "desc": desc_ctrl.text,
                      "due_date": formatDate(_selectedDate!),
                      "priority": _selectedPriority,
                      "status": "InProgress",
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Sucessfully Added - ${title_ctrl.text}"),
                      duration: Duration(seconds: 3),
                    ));
                  } else {
                    TaskRepository(TasksFirebase()).editTask(
                        this._id!,
                        Task(
                          image: "assets/images/task_image.png",
                          title: title_ctrl.text,
                          desc: desc_ctrl.text,
                          due_date: "",
                          priority: _selectedPriority!,
                          status: _selectedStatus!,
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      elevation: 4,
                      backgroundColor: Colors.white,
                      content: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.green.shade400,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Sucessfully Edited - ${title_ctrl.text}",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 3),
                    ));
                  }
                  //TODO !! which one?
                  // Navigator.pushReplacementNamed(context, "tasks"); //InitState
                  BlocProvider.of<TaskCubit>(context).getAllTasksForUser();
                  Navigator.pop(context);
                },
                text: widget.task == null ? "Add task" : "Edit task"),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  String formatDate(DateTime date) {
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String year = '${date.year}';
    return '$month/$day/$year';
  }
}
