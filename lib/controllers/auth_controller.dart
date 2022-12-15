import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, User?>((ref) => AuthController(ref)..appStarted());

class AuthController extends StateNotifier<User?> {
  final Ref _ref;

  StreamSubscription<AuthState>? _authStateChangesSubscription;

  AuthController(this._ref) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((event) {
      log('[auth state] ${event.event.toString()} ${event.session?.user}');
      state = event.session?.user;
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _ref.read(authRepositoryProvider).currentUser;
    log('app started $user');
  }

  void signUp(String email, String password, String name) async {
    await _ref.read(authRepositoryProvider).signUpUser(email, password, name);
  }

  void signIn(String email, String password) async {
    await _ref.read(authRepositoryProvider).signInUser(email, password);
  }

  void signOut() async {
    await _ref.read(authRepositoryProvider).signOutUser();
  }
}
