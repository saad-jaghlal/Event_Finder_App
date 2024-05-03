
import 'package:event_finder_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
   Future<Either<Failure,String>> signUpWithIt({
    required String email ,
    required String password,
  });
  Future<Either<Failure,String>> logInWithIt({
    required String email ,
    required String password,
  });
}