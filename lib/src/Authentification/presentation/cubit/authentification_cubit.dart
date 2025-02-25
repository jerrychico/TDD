import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/create_user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/get_users.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  AuthentificationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,super(const AuthentificationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String createdAt, required String name, required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUsersParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold(
            (failure) => emit(AuthentificationError(failure.errorMessage)),
            (_) => emit(const UserCreated())
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
            (failure) => emit(AuthentificationError(failure.errorMessage)),
            (users) => emit(UsersLoaded(users))
    );
  }
}
