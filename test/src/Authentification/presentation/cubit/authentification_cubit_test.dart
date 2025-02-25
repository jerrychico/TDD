import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/create_user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/get_users.dart';
import 'package:tdd/src/Authentification/presentation/cubit/authentification_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthentificationCubit cubit;

  const tCreateParams = CreateUsersParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    cubit = AuthentificationCubit(
      createUser: createUser,
      getUsers: getUsers,
    );

    registerFallbackValue(tCreateParams);
  });

  tearDown(() => cubit.close());

  test('Initial state should be [AuthentificationInitial]', () async {
    expect(cubit.state, const AuthentificationInitial());
  });

  group('createUser', () {
    blocTest<AuthentificationCubit, AuthentificationState>(
        'should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (createUser) => cubit.createUser(
              createdAt: tCreateParams.createdAt,
              name: tCreateParams.name,
              avatar: tCreateParams.avatar,
            ),
        expect: () => const [
              CreatingUser(),
              UserCreated(),
            ],
        verify: (_) {
          verify(() => createUser(tCreateParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthentificationCubit, AuthentificationState>(
        'should emit [CreatingUser, AuthentificationError] when successful',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Left(tAPIFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.createUser(
              createdAt: tCreateParams.createdAt,
              name: tCreateParams.name,
              avatar: tCreateParams.avatar,
            ),
        expect: () => [
              const CreatingUser(),
              AuthentificationError(tAPIFailure.errorMessage)
        ]);
  });

  group('getUsers', () {
    blocTest<AuthentificationCubit, AuthentificationState>(
      'Should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers())
            .thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) async => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([])
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
    );

    blocTest<AuthentificationCubit, AuthentificationState>(
      'should emit [GettingUser, AuthentificationError] when successful',
      build: () {
        when(() => getUsers()).thenAnswer(
              (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthentificationError(tAPIFailure.errorMessage)
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
    );
  });
}
