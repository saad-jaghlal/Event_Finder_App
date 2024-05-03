import 'dart:js_interop';

import 'package:event_finder_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWith({
    required String email,
    required String password,
  });
  Future<String> logInWith({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<String> logInWith({
    required String email,
    required String password,
  }) {
    // TODO: implement logInWith
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWith({
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
      return response.user!.id;
    } catch (e) {
      throw  ServerExcption(e.toString());
    }
  }
}
