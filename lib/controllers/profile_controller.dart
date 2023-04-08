import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/model/profile.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/extensions.dart';

import '../globals.dart';

class ProfileController extends StateNotifier<AsyncValue<Profile>> {
  final Ref _ref;
  final String? _userId;

  ProfileController(this._ref, this._userId) : super(const AsyncLoading()) {
    if (_userId != null) fetchProfile();
  }

  void setLoading() {
    state = const AsyncLoading();
  }

  Future<void> fetchProfile() async {
    try {
      state = const AsyncLoading();
      final profile = await _ref
          .read(profileRepositoryProvider)
          .fetchProfile(userId: _userId!);
      if (mounted) state = AsyncData(profile);
    } catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

  void updateProfilePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    setLoading();
    try {
      final imageUrl = await _ref
          .read(profileRepositoryProvider)
          .updateProfilePicture(imageFile);
      if (mounted) {
        state = AsyncData(state.value!.copyWith(avatarUrl: imageUrl));
      }
      snackbarKey.show(message: 'Profile picture updated');
    } on StorageException catch (e) {
      snackbarKey.showError(message: e.message);
    } catch (e) {
      snackbarKey.showError(message: e.toString());
    }
  }

  void updateName(String newName) async {
    try {
      final oldState = state.value;
      setLoading();
      await _ref.read(profileRepositoryProvider).updateName(newName);
      if (mounted) {
        state = AsyncData(oldState!.copyWith(name: newName));
      }
      snackbarKey.show(message: 'Name updated');
    } catch (e, st) {
      state = AsyncError(e, st);
      snackbarKey.showError(message: e.toString());
    }
  }
}
