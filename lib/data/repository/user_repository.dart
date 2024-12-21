import 'package:tasky_clone/data/models/tasky_user.dart';
import 'package:tasky_clone/data/web_services/user_firebase.dart';

class UserRepository {
  final UserFirebase userFirebase;

  UserRepository(this.userFirebase);

  Future<ATaskyUser> getUser(String uid) async {
    final user = await userFirebase.getUser(uid);
    ATaskyUser fuser = ATaskyUser.fromJson(user);
    return fuser;
  }
}
