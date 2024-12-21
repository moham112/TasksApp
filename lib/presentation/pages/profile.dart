import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_clone/business_logic/cubit/user_cubit.dart';
import 'package:tasky_clone/data/models/tasky_user.dart';
import 'package:tasky_clone/presentation/widgets/profile_element.dart';
import 'package:tasky_clone/presentation/widgets/secondary_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ATaskyUser? user;
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getCurretUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecodaryAppBar(
        title: "Profile",
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            user = (state).tasky_user;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  ProfileElement(
                    title: "NAME",
                    data: user!.name,
                  ),
                  SizedBox(height: 10),
                  ProfileElement(
                    title: "email".toUpperCase(),
                    data: user!.email!,
                  ),
                  SizedBox(height: 10),
                  ProfileElement(
                    title: "Level".toUpperCase(),
                    data: user!.experienceLevel.toString(),
                  ),
                  SizedBox(height: 10),
                  ProfileElement(
                    title: "years of experience".toUpperCase(),
                    data: user!.years_of_exp.toString(),
                  ),
                  SizedBox(height: 10),
                  ProfileElement(
                    title: "location".toUpperCase(),
                    data: user!.address!,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
