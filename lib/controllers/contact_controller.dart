import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactController extends StateNotifier<AsyncValue<List<Contact>?>> {
  ContactController() : super(const AsyncData(null)) {
    getContact();
  }

  void getContact() async {
    try {
      bool permission = await FlutterContacts.requestPermission();
      if (!permission) return Future.error('Contact permissions are denied');

      state = const AsyncLoading();
      final contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      state = AsyncData(contacts);
    } catch (e, st) {
      AsyncError(e, st);
    }
  }
}
