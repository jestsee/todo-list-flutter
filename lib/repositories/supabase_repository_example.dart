import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository {
  final client = SupabaseClient(
      dotenv.env['SUPABASE_URL']!, dotenv.env['SUPABASE_SECRET']!);

  Future<void> signUpUser(context, {String? email, String? password}) async {
    debugPrint("email:$email password:$password");
    try {
      final data = await client.auth.signUp(email: email, password: password!);
      debugPrint(data.user?.toJson().toString());
      debugPrint("Sign up success! ${data.user?.toJson().toString()}");
    } catch (e) {
      debugPrint("Sign up failed! $e");
    }
  }

  Future<void> signInUser(context, {String? email, String? password}) async {
    debugPrint("email:$email password:$password");
    try {
      final data = await client.auth
          .signInWithPassword(email: email, password: password!);
      debugPrint("Sign in success! ${data.user?.toJson().toString()}");
    } catch (e) {
      debugPrint("Sign in failed! $e");
    }
  }

  Future<void> signOutUser(context) async {
    await client.auth.signOut();
    debugPrint("Signed out");
  }
}
