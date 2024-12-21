import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_clone/tasky_user.dart';

class ATaskyUser {
  late String id;
  late String name;
  late String? email;
  int? years_of_exp;
  ExperienceLevel? experienceLevel;
  String? address;
  late String password;

  ATaskyUser({
    required this.id,
    required this.name,
    required this.email,
    this.years_of_exp,
    this.experienceLevel,
    this.address,
    required this.password,
  });

  factory ATaskyUser.fromJson(Map<String, dynamic> json) {
    return ATaskyUser(
      id: json['uid'],
      name: json['name'],
      email: FirebaseAuth.instance.currentUser!.email,
      password: '',
      years_of_exp: json['years_of_experience'],
      address: json['address'],
      experienceLevel: ExperienceLevel.values.firstWhere(
        (e) => e.toString().split('.').last == json['experince_level'],
        orElse: () => ExperienceLevel.Intermediate,
      ),
    );
  }
}

/*
  id = json['uid'];
    name = json['name'];
    email = FirebaseAuth.instance.currentUser!.email;
    years_of_exp = json['years_of_experience'];
    experienceLevel = ExperienceLevel.values.firstWhere(
      (e) => e.toString().split('.').last == json['experince_level'],
      orElse: () => ExperienceLevel.Intermediate,
    );
    address = json['address'];
    password = '';
*/
