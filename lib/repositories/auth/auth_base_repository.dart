import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthBaseRepository {
  Stream<AuthState> get authStateChanges;
  Session? get currentSession;
  User? get currentUser;
  Future<void> signUpUser(String email, String password, String name);
  Future<void> signInUser(String email, String password);
  Future<void> signOutUser();
}
