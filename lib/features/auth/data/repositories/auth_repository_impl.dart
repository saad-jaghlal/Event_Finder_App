import 'package:event_finder_app/core/error/exceptions.dart';
import 'package:event_finder_app/core/error/failures.dart';
import 'package:event_finder_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:event_finder_app/features/auth/domain/entities/user.dart';
import 'package:event_finder_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> logInWithIt({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.logInWith(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithIt({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWith(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExcption catch (e) {
      return left(e.message as Failure);
    }
  }
}
