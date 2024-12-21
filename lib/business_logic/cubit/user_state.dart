part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final ATaskyUser tasky_user;

  UserLoaded(this.tasky_user);
}

class UserLoading extends UserState {}
