import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:todo_list/globals.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/extensions.dart';

class AuthController extends StateNotifier<AsyncValue<sb.AuthState?>> {
  final Ref _ref;
  StreamSubscription<sb.AuthState>? _authStateChangesSubscription;

  AuthController(this._ref) : super(const AsyncData(null)) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen(((event) {
      log('[auth state] ${event.event.name}');
      if (event.event == sb.AuthChangeEvent.userUpdated) {
        _ref.read(profileControllerProvider.notifier).setProfile(
            name: event.session?.user.userMetadata?['name'],
            avatarUrl: event.session?.user.userMetadata?['avatar_url']);
        return;
      }
      state = AsyncData(event);
    }));
  }

  @override
  void dispose() {
    log('dispose called');
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void setLoading() {
    state = const AsyncLoading();
  }

  void appStarted() async {
    log('app started');
    final session = await _ref.read(authRepositoryProvider).initialSession;

    if (session != null) {
      state = AsyncData(sb.AuthState(sb.AuthChangeEvent.signedIn, session));
      return;
    }
    state = AsyncData(sb.AuthState(sb.AuthChangeEvent.signedOut, session));
  }

  void signUp(String email, String password, String name) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signUpUser(email, password, name);
      snackbarKey.show(
          message:
              'Your account has been created. Please check your email $email to activate your account.');
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void signIn(String email, String password) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signInUser(email, password);
      snackbarKey.show(message: 'Successfully signed in');
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void signInGithub() async {
    await _ref.read(authRepositoryProvider).signInOAuth(sb.Provider.github);
    snackbarKey.show(message: 'Successfully signed in');
  }

  void signOut() async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signOutUser();
      snackbarKey.show(message: 'Signed out');
    } catch (e) {
      snackbarKey.showError(message: e.toString());
    }
  }
}
