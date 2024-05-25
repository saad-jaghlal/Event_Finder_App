import 'package:event_finder_app/core/secrets/secretsbase.dart';
import 'package:event_finder_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:event_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:event_finder_app/features/auth/domain/repository/auth_repository.dart';
import 'package:event_finder_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:event_finder_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:event_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: SecretBase.supabaseUrl, anonKey: SecretBase.key);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
    serviceLocator.registerFactory<UserLogin>(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator() 
    ),
  );
}
