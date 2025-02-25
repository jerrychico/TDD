// [#6]

import 'package:tdd/core/utils/typdef.dart';

// La fonction Call(): sert à appliquer l'action de nullation a cette methode
// elle est appelle automatiquement lorsque,lon execute la class
// le cas d'utilisation avec parametres
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

// le cas d'utilisation sans parametres
abstract class UsecaseWithOutParams<Type> {
  const UsecaseWithOutParams();
  ResultFuture<Type> call();
}