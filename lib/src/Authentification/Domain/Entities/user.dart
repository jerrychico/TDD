// On utilise Equatable pour =>
// permettre de verifier les valeurs bien precis
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  const User(
      {required this.name,
      required this.id,
      required this.avatar,
      required this.createdAt});

  const User.empty()
      : this(
          id: '1',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );



  @override
  List<Object?> get props => [id, name, avatar, createdAt];

}
