import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:todo_list/globals.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/utils.dart';

class AuthController extends StateNotifier<UserState> {
  final Ref _ref;
  StreamSubscription<sb.AuthState>? _authStateChangesSubscription;

  AuthController(this._ref)
      : super(
            UserState.event(sb.AuthState(sb.AuthChangeEvent.signedOut, null))) {
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

  void setLoading() {
    state = const UserState.loading();
  }

  void appStarted() async {
    log('app started called');
    state = const UserState.initial();
    final session = await _ref.read(authRepositoryProvider).initialSession;

    if (session != null) {
      state =
          UserState.event(sb.AuthState(sb.AuthChangeEvent.signedIn, session));
      return;
    }
    state =
        UserState.event(sb.AuthState(sb.AuthChangeEvent.signedOut, session));
  }

  void signUp(String email, String password, String name) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signUpUser(email, password, name);
    } catch (e) {
      snackbarKey.showError(message: e.toString());
      state = UserState.event(sb.AuthState(sb.AuthChangeEvent.signedOut, null));
    }
  }

  void signIn(String email, String password) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signInUser(email, password);
    } catch (e) {
      snackbarKey.showError(message: e.toString());
      state = UserState.event(sb.AuthState(sb.AuthChangeEvent.signedOut, null));
    }
  }

  void signInGithub() async {
    await _ref.read(authRepositoryProvider).signInOAuth(sb.Provider.github);
  }

  void signOut() async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signOutUser();
    } catch (e) {
      snackbarKey.showError(message: e.toString());
      state = UserState.event(sb.AuthState(sb.AuthChangeEvent.signedIn,
          _ref.read(authRepositoryProvider).getCurrentSession));
    }
  }
}