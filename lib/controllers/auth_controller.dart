import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider/provider.dart';

class AuthController extends StateNotifier<UserState> {
  final Ref _ref;
  StreamSubscription<AuthState>? _authStateChangesSubscription;

  AuthController(this._ref)
      : super(UserState.event(AuthState(AuthChangeEvent.signedOut, null))) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((event) {
      log('[authState changes] ${event.event.toString()}');
      state = UserState.event(event);
    });
  }

  @override
  void dispose() {
    log('dispose called');
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    log('app started called');
    state = const UserState.initial();
    final session = await _ref.read(authRepositoryProvider).initialSession;

    if (session != null) {
      state = UserState.event(AuthState(AuthChangeEvent.signedIn, session));
      return;
    }
    state = UserState.event(AuthState(AuthChangeEvent.signedOut, session));
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
