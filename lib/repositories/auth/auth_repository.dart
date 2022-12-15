import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/provider/provider.dart';
import 'package:todo_list/repositories/auth/auth_base_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:todo_list/repositories/custom_exception.dart';

class AuthRepository implements AuthBaseRepository {
  final r.Ref _ref;

  const AuthRepository(this._ref);

  @override
  Stream<AuthState> get authStateChanges =>
      _ref.read(supabaseClientProvider).auth.onAuthStateChange;

  @override
  Future<void> signUpUser(String email, String password, String name) async {
    log('$email $password $name');
    try {
      final temp = await _ref.read(supabaseClientProvider).auth.signUp(
          email: email,
          password: password,
          data: {"name": name, "avatar_url": 'asd'});
      log(temp.session.toString());
      log(temp.user.toString());
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signInUser(String email, String password) async {
    try {
      final resp = await _ref
          .read(supabaseClientProvider)
          .auth
          .signInWithPassword(email: email, password: password);
          log(resp.user!.userMetadata.toString());
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await _ref.read(supabaseClientProvider).auth.signOut();
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _ref.read(supabaseClientProvider).auth.currentUser;
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
