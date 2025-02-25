import 'package:get_it/get_it.dart';
import 'package:tdd/src/Authentification/Data/Datasource/authentification_remote_data_source.dart';
import 'package:tdd/src/Authentification/Data/Repositories/authentification_repository_implementation.dart';
import 'package:tdd/src/Authentification/Domain/Repositories/Authentification_Repository.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/create_user.dart';
import 'package:tdd/src/Authentification/Domain/Usecase/get_users.dart';
import 'package:tdd/src/Authentification/presentation/cubit/authentification_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => AuthentificationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))
    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // repository
    ..registerLazySingleton<AuthentificationRepository>(
        () => AuthentificationRepositoryImplementation(sl()))

    // Datat source
    ..registerLazySingleton<AuthentificationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    
    // Externel dependencies
    ..registerLazySingleton(http.Client.new);
}
