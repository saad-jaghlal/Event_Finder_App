// import 'dart:js_interop';

import 'package:event_finder_app/core/error/exceptions.dart';
import 'package:event_finder_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWith({
    required String email,
    required String password,
  });
  Future<UserModel> logInWith({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> logInWith({
    required String email,
    required String password,
  }) async {
      try {
      final response = await supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,
          );
      if (response.user == null) {
        throw const ServerExcption("User is null!");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw  ServerExcption(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWith({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {'email': email, 'password': password});
      if (response.user == null) {
        throw const ServerExcption("User is null!");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw  ServerExcption(e.toString());
    }
  }
}
