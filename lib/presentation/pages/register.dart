import 'package:flutter/material.dart';
import 'package:tasky_clone/tasky_user.dart';
import 'package:tasky_clone/presentation/widgets/primary_button.dart';
import 'package:tasky_clone/presentation/widgets/primary_textformfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool password_obsecurity = true;
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController exp_ctrl = TextEditingController();
  TextEditingController address_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();

  final List<String> experienceLevels = [
    'Chose Experience Level',
    'Intermediate',
    'Advanced',
    'Expert',
  ];
  String? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width / 14,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/ART.png",
                height: MediaQuery.sizeOf(context).height / 3,
              ),
            ),
            Text(
              "Register",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            PrimaryTextformfield(
              obsecure: false,
              hint: "Name...",
              controller: name_ctrl,
            ),
            SizedBox(height: 10),
            PrimaryTextformfield(
              obsecure: false,
              hint: "Email...",
              controller: email_ctrl,
            ),
            SizedBox(height: 10),
            PrimaryTextformfield(
              obsecure: false,
              hint: "Years of experience",
              controller: exp_ctrl,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400, // لون الحدود
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.blue, // لون الحدود عند التركيز
                    width: 1.5,
                  ),
                ),
              ),
              hint: Text(
                'Choose experience Level',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              value: selectedLevel,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              isExpanded: true,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              items: experienceLevels.map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLevel = newValue;
                });
              },
            ),
            SizedBox(height: 10),
            // DropdownButton(
            //   isExpanded: true,
            //   items: [
            //     ...List.generate(
            //       experience_level.length,
            //       (index) {
            //         return DropdownMenuItem(
            //           child: Text(experience_level[index]),
            //         );
            //       },
            //     ),
            //   ],
            //   onChanged: (value) {},
            // ),
            PrimaryTextformfield(
              obsecure: false,
              hint: "Address...",
              controller: address_ctrl,
            ),
            SizedBox(height: 10),
            PrimaryTextformfield(
              obsecure: password_obsecurity,
              hint: "Password...",
              controller: password_ctrl,
              suffix: InkWell(
                child: password_obsecurity
                    ? Image.asset(
                        "assets/images/opened-eye.png",
                        height: 20,
                      )
                    : Image.asset(
                        "assets/images/closed-eye.png",
                        height: 20,
                      ),
                onTap: () {
                  setState(() {
                    password_obsecurity = !password_obsecurity;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            PrimaryButton(
                onPressed: () {
                  ExperienceLevel level = ExperienceLevel.values.firstWhere(
                    (e) => e.toString().split('.').last == selectedLevel,
                    orElse: () => ExperienceLevel.Intermediate,
                  );
                  TaskyUser tuser = TaskyUser(
                    name: name_ctrl.text,
                    email: email_ctrl.text,
                    password: password_ctrl.text,
                    address: address_ctrl.text,
                    experience_level: level,
                    years_of_experience: int.parse(exp_ctrl.text),
                  );
                  TaskyUser.signUp(tuser: tuser);
                  Navigator.pushReplacementNamed(context, "tasks");
                },
                text: "Sign Up"),
            SizedBox(height: 10),
            Center(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "login"),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have any account? ",
                        style: TextStyle(
                          color: Color(0xff7F7F7F),
                        ),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
