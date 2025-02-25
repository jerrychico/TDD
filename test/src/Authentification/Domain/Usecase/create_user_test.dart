// what does class depends on
// Answer -- AuhentificationRepository
// how can we create a fake version of the dependence
// Answer -- use Mocktail
// How do we control what our dependencies do
// Answer -- using the mocktail's API
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/create_user.dart';

class MockAuthRepo extends Mock implements AuthentificationRepository {}

void main() {
  late CreateUser usecase;
  late AuthentificationRepository repository;

  // initialisation des fonctions
  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  // Etat d'une entites standard pour un cas, avec parametre
  const params = CreateUsersParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    // Arrange
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);
    // Assert
    expect(result, equals(const Right<Failure, void>(null)));

    // verifier appelle
    verify(() => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        )).called(1);

    // Verifier interaction
    verifyNoMoreInteractions(repository);
  });
}
