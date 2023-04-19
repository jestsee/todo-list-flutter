import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/model/profile.dart';

import '../custom_exception.dart';

class ProfileRepository {
  final SupabaseClient supabase;

  const ProfileRepository(this.supabase);

  Future<Profile> fetchProfile({required String userId}) async {
    try {
      final profile =
          await supabase.from('profiles').select('*').eq('id', userId);
      return Profile.fromJson(profile[0]);
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  Future<String> updateProfilePicture(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      // upload image
      await Supabase.instance.client.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: file.mimeType),
          );

      // generate url
      final imageUrlResponse = await Supabase.instance.client.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      log('[img url] $imageUrlResponse');

      // update user's data
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(data: {'avatar_url': imageUrlResponse}));

      return imageUrlResponse;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  Future<void> updateName(String newName) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(data: {'name': newName}),
      );
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
