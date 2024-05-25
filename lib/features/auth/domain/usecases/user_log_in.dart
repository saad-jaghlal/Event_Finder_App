import 'package:event_finder_app/core/error/failures.dart';
import 'package:event_finder_app/core/usecase/usecase.dart';
import 'package:event_finder_app/features/auth/domain/entities/user.dart';
import 'package:event_finder_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authRepository.logInWithIt(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
