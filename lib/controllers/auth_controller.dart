import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider/provider.dart';

class AuthController extends StateNotifier<UserState> {
  final Ref _ref;

  StreamSubscription<AuthState>? _authStateChangesSubscription;

  AuthController(this._ref) : super(const UserState.initial()) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((event) {
      log('[authState changes] ${event.event.toString()}');
      state = UserState.event(event: event.event);
    });
  }

  @override
  void dispose() {
    log('dispose called');
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _ref.read(authRepositoryProvider).getCurrentUser();
      log('Belum sign in');
  }

  void signUp(String email, String password, String name) async {
    try {
      state = const UserState.loading();
      await _ref.read(authRepositoryProvider).signUpUser(email, password, name);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  void signIn(String email, String password) async {
    try {
      state = const UserState.loading();
      final resp =
          await _ref.read(authRepositoryProvider).signInUser(email, password);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  void signOut() async {
    state = const UserState.loading();
    await _ref.read(authRepositoryProvider).signOutUser();
  }
}
