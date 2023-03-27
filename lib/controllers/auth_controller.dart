import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/extensions.dart';

class AuthController extends StateNotifier<UserState> {
  final Ref _ref;
  StreamSubscription<sb.AuthState>? _authStateChangesSubscription;

  AuthController(this._ref) : super(const UserState.initial()) {
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

  void handleError(String message) {
    state = UserState.error(message);
  }

  void appStarted() async {
    log('app started called');
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
      snackbarKey.show(
          message:
              'Your account has been created. Please check your email $email to activate your account.');
    } catch (e) {
      handleError(e.toString());
    }
  }

  void signIn(String email, String password) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).signInUser(email, password);
      snackbarKey.show(message: 'Successfully signed in');
    } catch (e) {
      handleError(e.toString());
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

// TODO belum ditest
  void updateName(String name) async {
    setLoading();
    try {
      await _ref.read(authRepositoryProvider).updateName(name);
    } catch (e) {
      snackbarKey.showError(message: e.toString());
    }
  }

  void updateProfilePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    setLoading();
    try {
      final imageUrl =
          await _ref.read(authRepositoryProvider).uploadPicture(imageFile);
      snackbarKey.show(message: 'Profile picture updated');
    } on StorageException catch (e) {
      snackbarKey.showError(message: e.message);
    } catch (e) {
      snackbarKey.showError(message: e.toString());
    }
  }
}
