import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tasky_clone/data/models/tasky_user.dart';
import 'package:tasky_clone/data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository taskyUserRepository;
  late ATaskyUser taskyUser;

  Future<ATaskyUser> getCurretUser() async {
    emit(UserLoading());
    await taskyUserRepository
        .getUser(FirebaseAuth.instance.currentUser!.uid)
        .then((user) {
      emit(UserLoaded(user));
      this.taskyUser = user;
    });

    return taskyUser;
  }

  UserCubit(this.taskyUserRepository) : super(UserInitial());
}
