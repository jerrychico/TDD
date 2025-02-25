// #2 on utilise comme un interface
// on descrire la structure des fonction

import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';

abstract class AuthentificationRepository {
  const AuthentificationRepository();

  // En réalite:
  // Future<(Exception, void)> ou Future<Either<Failure, void>> ou le type ResultVoid
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
