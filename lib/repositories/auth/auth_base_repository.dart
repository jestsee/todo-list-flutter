import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthBaseRepository {
  Stream<AuthState> get authStateChanges;
  Future<void> signUpUser(String email, String password, String name);
  Future<void> signInUser(String email, String password);
  Future<void> signInOAuth(Provider provider);
  Future<void> signOutUser();
  Future<Session?> get initialSession;
  Session? get getCurrentSession;
  User? get getCurrentUser;
}
