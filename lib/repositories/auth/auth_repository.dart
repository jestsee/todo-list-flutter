import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/provider.dart';
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
    try {
      await _ref.read(supabaseClientProvider).auth.signUp(
          email: email,
          password: password,
          data: {"name": name, "avatar_url": 'asd'});
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signInUser(String email, String password) async {
    try {
      await _ref
          .read(supabaseClientProvider)
          .auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signInOAuth(Provider provider) async {
    try {
      await _ref
          .read(supabaseClientProvider)
          .auth
          .signInWithOAuth(provider, redirectTo: 'io.supabase.todolist://login-callback/');
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await _ref.read(supabaseClientProvider).auth.signOut();
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<Session?> get initialSession async {
    try {
      return await SupabaseAuth.instance.initialSession;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
  @override
  Session? get getCurrentSession =>
      _ref.read(supabaseClientProvider).auth.currentSession;

  @override
  User? get getCurrentUser => getCurrentSession?.user;
}
