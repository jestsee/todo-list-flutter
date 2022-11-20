import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthBaseRepository {
  Future<void> signUpUser(String email, String password);
  Future<void> signInUser(String email, String password);
  Future<void> signOutUser();
  User? getCurrentUser();
}
