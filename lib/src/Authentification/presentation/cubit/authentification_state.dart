part of 'authentification_cubit.dart';

abstract class AuthentificationState extends Equatable {
  const AuthentificationState();

  @override
  List<Object> get props => [];
}

class AuthentificationInitial extends AuthentificationState {
  const AuthentificationInitial();
}


class CreatingUser extends AuthentificationState {
  const CreatingUser();
}

class GettingUsers extends AuthentificationState {
  const GettingUsers();
}

class UserCreated extends AuthentificationState {
  const UserCreated();
}

class UsersLoaded extends AuthentificationState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthentificationError extends AuthentificationState {
  const AuthentificationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}