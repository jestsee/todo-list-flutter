import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
    (ref) => AuthController(ref)..appStarted());

class AuthController extends StateNotifier<User?> {
  final Ref _ref;

  StreamSubscription<AuthState>? _authStateChangesSubscription;

  AuthController(this._ref) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen((event) => state = event.session?.user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _ref.read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      log('Belum sign in');
    }
  }

  void signOut() async {
    await _ref.read(authRepositoryProvider).signOutUser();
  }
}
