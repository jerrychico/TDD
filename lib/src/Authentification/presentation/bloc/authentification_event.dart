part of 'authentification_bloc.dart';

abstract class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object?> get props => [];
}

// la sturcture des event en cours
class CreateUserEvent extends AuthentificationEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createdAt, name, avatar];
}

class GetUserEvent extends AuthentificationEvent {
  const GetUserEvent();
}