import 'dart:convert';

import 'package:tdd/core/utils/typdef.dart';
import 'package:tdd/src/Authentification/Domain/Entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt
  });

  // convertir un string en object json
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  //
  UserModel copyWith({
    String? avatar,
    String? id,
    String? name,
    String? createdAt
  }) {
    return UserModel(name: name ?? this.name,
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,);
  }


  // faire une boucle pour acceder au element de l'object
  UserModel.fromMap(DataMap map)
      : this(
      avatar: map['avatar'] as String,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
      id: map['id'] as String);

  const UserModel.empty() : this(
      id: '1',
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar',
    );

  DataMap toMap() =>
  {
    'id': id,
    'avatar': avatar,
    'createdAt': createdAt,
    'name': name};

  String toJson() => jsonEncode(toMap());

}
