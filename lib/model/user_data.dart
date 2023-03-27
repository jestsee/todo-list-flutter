import 'package:supabase_flutter/supabase_flutter.dart';

class UserData extends AuthState {
  final String? avatarUrl;
  final String name;
  UserData(super.event, super.session, {required this.name, this.avatarUrl});

  UserData copyWith(
      {String? avatarUrl,
      String? name,
      AuthChangeEvent? event,
      Session? session}) {
    return UserData(event ?? this.event, session ?? this.session,
        name: name ?? this.name, avatarUrl: avatarUrl ?? this.avatarUrl);
  }
}
