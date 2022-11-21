import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthBaseRepository {
  Stream<AuthState> get authStateChanges;
  Future<void> signUpUser(String email, String password);
  Future<void> signInUser(String email, String password);
  Future<void> signOutUser();
  User? getCurrentUser();
}
