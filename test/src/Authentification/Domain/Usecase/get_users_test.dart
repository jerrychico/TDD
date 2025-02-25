import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/get_users.dart';
import 'package:flutter_test/flutter_test.dart';

import 'Authentification_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthentificationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tReponse = [User.empty()];
  test('should call the [AuthRepo.getUsers] and return [List<User>]', () async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(tReponse));

    // Act:
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(tReponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });


}
