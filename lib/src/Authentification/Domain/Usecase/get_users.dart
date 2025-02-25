// [#6]
import 'package:tdd/core/usecase/usecase.dart';
import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';

class GetUsers extends UsecaseWithOutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthentificationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}