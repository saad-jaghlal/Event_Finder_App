import 'package:event_finder_app/core/error/exceptions.dart';
import 'package:event_finder_app/core/error/failures.dart';
import 'package:event_finder_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:event_finder_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> logInWithIt(
      {required String email, required String password}) {
    // TODO: implement logInWithIt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithIt({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWith(
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerExcption catch (e) {
      return left(e.message as Failure);
    }
  }
}
