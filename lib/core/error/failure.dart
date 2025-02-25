// #3 gestion des erreurs
import 'package:equatable/equatable.dart';
import 'package:tdd/core/error/exceptions.dart';

// structure de l'erreur de base
abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

// erreur generer pas l'api
class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromExeception(APIException exception): this(message: exception.message, statusCode: exception.statusCode);
}



