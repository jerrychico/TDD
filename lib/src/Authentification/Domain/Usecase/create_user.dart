import 'package:equatable/equatable.dart';
import 'package:tdd/core/usecase/usecase.dart';
import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';

// #4
// le cas d'utilisation sur: create user
class CreateUser extends UsecaseWithParams<void, CreateUsersParams> {
  const CreateUser(this._repository);

  final AuthentificationRepository _repository;

  // la fonction createUser meme
  @override
  ResultVoid call(CreateUsersParams params) async =>
      _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUsersParams extends Equatable {

  const CreateUsersParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String createdAt, name, avatar;


  const CreateUsersParams.empty() :
      this(
        createdAt: '_empty.createdAt',
        name: '_empty.name',
        avatar: '_empty.avatar',
      );

  @override
  List<Object?> get props => [name, createdAt, avatar];
}
