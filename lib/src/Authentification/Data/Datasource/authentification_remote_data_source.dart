import 'dart:convert';

import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/utils/constant.dart';
import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Data/Models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthentificationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = "/users";
const kGetUsersEndpoint = "/";

class AuthRemoteDataSrcImpl implements AuthentificationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response =
          await _client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
              body: jsonEncode({
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              }),
            headers: {
              'Context-Type': "application/json"
            }
          );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
  
}
