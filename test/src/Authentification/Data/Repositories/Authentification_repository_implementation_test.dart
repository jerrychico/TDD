import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/src/Authentification/Data/Datasource/authentification_remote_data_source.dart';
import 'package:tdd/src/Authentification/Data/Models/user_model.dart';
import 'package:tdd/src/Authentification/Data/Repositories/authentification_repository_implementation.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthentificationRemoteDataSource {}

void main() {
  late AuthentificationRemoteDataSource remoteDataSource;
  late AuthentificationRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthentificationRepositoryImplementation(remoteDataSource);
  });

  const tExecption = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  // creation des nouveaux utilisateur
  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.createdAt';
    const avatar = 'whatever.createdAt';

    test(
        'should call the [RemoteDataSource.createUser] and complete'
        ' successfully when the call to the remote source is successful',
     () async {
      // Arrange
      // Test interface et sa structure de données
      when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenAnswer((_) => Future.value());

      // act
      // Execute la fonction
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert ou verifier la nature des données
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source'
        ' is unsuccessful', () async {
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tExecption);

      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        equals(
          Left(
            APIFailure(
                message: tExecption.message, statusCode: tExecption.statusCode),
          ),
        ),
      );

      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<Users>] '
      ' when the call to the remote source is successful',
      () async {
        when(
          () => remoteDataSource.getUsers(),
        ).thenAnswer((_) async => []);


        final result = await repoImpl.getUsers();

        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test('verifier la gestion d\'erreur', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tExecption);
      final result = await repoImpl.getUsers();
      expect(
        result,
        equals(
          Left(
            APIFailure(
                message: tExecption.message, statusCode: tExecption.statusCode),
          ),
        ),
      );
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
