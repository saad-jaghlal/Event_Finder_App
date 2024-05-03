import 'package:event_finder_app/core/error/failures.dart';
import 'package:event_finder_app/core/usecase/usecase.dart';
import 'package:event_finder_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
     return await authRepository.signUpWithIt(
        email: params.email,
        password: params.password
        );
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams(
      {required this.email, required this.password});
}
