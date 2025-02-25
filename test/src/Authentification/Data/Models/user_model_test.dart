import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Data/Models/user_model.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('should be a subclass of [User] entity', () {
    // Arrange
    // Act
    // Assert
    expect(tModel, isA<User>());
  });
  group('fromMap', () {
    test(
        'should return a [UserModel] with the Right data',
        ()  {
          // Arrange
          final result = UserModel.fromMap(tMap);
          // Assert
          expect(result, equals(tModel));
        });
  });
  group('fromJson', () {
    test(
        'should return a [UserModel] with the Right data',
            ()  {
          // Arrange
          final result = UserModel.fromJson(tJson);
          // Assert
          expect(result, equals(tModel));
        });
  });
  group('toMap', () {
    test(
        'should return a [toMap] with the Right data',
            ()  {
          // Arrange
          final result = tModel.toMap();
          // Assert
          expect(result, equals(tMap));
        });
  });
  group('toJson', () {
    test(
        'should return a [toJSon] with the Right data',
            ()  {
          // Arrange
          final result = tModel.toJson();
          final tJson = jsonEncode({
            "id": "1",
            "avatar": "_empty.avatar",
            "createdAt": "_empty.createdAt",
            "name": "_empty.name",
          });
          // Assert
          expect(result, equals(tJson));
        });
  });
  group('copyWith', () {
    test(
        'should return a [copyWith] with the Right data',
            ()  {
          // Arrange
          final result = tModel.copyWith(name: 'paul');
          // Assert
          expect(result.name, equals('paul'));
        });
  });
}
