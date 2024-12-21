import 'package:flutter/material.dart';
import 'package:tasky_clone/tasky_user.dart';
import 'package:tasky_clone/presentation/widgets/primary_button.dart';
import 'package:tasky_clone/presentation/widgets/primary_textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool password_obsecurity = true;
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/ART.png",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width / 11,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 15),
                  PrimaryTextformfield(
                    controller: email_ctrl,
                    obsecure: false,
                    hint: "Email",
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    controller: password_ctrl,
                    obsecure: password_obsecurity,
                    hint: "Password",
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          password_obsecurity = !password_obsecurity;
                        });
                      },
                      child: password_obsecurity
                          ? Image.asset(
                              "assets/images/opened-eye.png",
                              height: 20,
                            )
                          : Image.asset(
                              "assets/images/closed-eye.png",
                              height: 20,
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  PrimaryButton(
                      onPressed: () async {
                        await TaskyUser.singIn(
                            email_ctrl.text, password_ctrl.text);
                        Navigator.pushReplacementNamed(context, "tasks");
                      },
                      text: "Sign In"),
                  SizedBox(height: 15),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "register");
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Didn't have any account? ",
                              style: TextStyle(
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up here",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
