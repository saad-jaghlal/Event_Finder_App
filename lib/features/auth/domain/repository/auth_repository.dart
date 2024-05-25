
import 'package:event_finder_app/core/error/failures.dart';
import 'package:event_finder_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
   Future<Either<Failure,User>> signUpWithIt({
    required String email ,
    required String password,
  });
  Future<Either<Failure,User>> logInWithIt({
    required String email ,
    required String password,
  });
}