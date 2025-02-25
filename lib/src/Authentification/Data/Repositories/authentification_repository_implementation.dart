import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Data/Datasource/authentification_remote_data_source.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';

class AuthentificationRepositoryImplementation
    extends AuthentificationRepository {
  const AuthentificationRepositoryImplementation(this._remoteDataSource);

  final AuthentificationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromExeception(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromExeception(e),
      );
    }
  }
}
