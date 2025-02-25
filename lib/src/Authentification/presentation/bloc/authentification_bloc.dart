import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/create_user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/get_users.dart';

part 'authentification_event.dart';

part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthentificationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserEvent);
  }

  //
  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthentificationState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUsersParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
        (failure) => emit(AuthentificationError(failure.errorMessage)),
        (_) => emit(const UserCreated())
    );
  }

  Future<void> _getUserEvent(
      GetUserEvent event,
      Emitter<AuthentificationState> emit
      ) async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
            (failure) => emit(AuthentificationError(failure.errorMessage)),
            (users) => emit(UsersLoaded(users))
    );
  }
}
