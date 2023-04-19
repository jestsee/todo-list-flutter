import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/auth/auth_base_repository.dart';
import 'package:todo_list/repositories/custom_exception.dart';

class AuthRepository implements AuthBaseRepository {
  const AuthRepository();

  @override
  Stream<AuthState> get authStateChanges =>
      Supabase.instance.client.auth.onAuthStateChange;

  @override
  Future<void> signUpUser(String email, String password, String name) async {
    try {
      await Supabase.instance.client.auth.signUp(
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
      await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signInOAuth(Provider provider) async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(provider,
          redirectTo: 'io.supabase.todolist://login-callback/');
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await Supabase.instance.client.auth.signOut();
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

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      await Supabase.instance.client.rpc('change_user_password', params: {
        'current_plain_password': oldPassword,
        'new_plain_password': newPassword
      });
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Session? get getCurrentSession =>
      Supabase.instance.client.auth.currentSession;

  @override
  User? get getCurrentUser => getCurrentSession?.user;
  String get name => (getCurrentUser!.userMetadata)!['name'];
  String get avatarUrl => (getCurrentUser!.userMetadata)!['avatar_url'];
}
