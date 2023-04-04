import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/model/timestamp_serializer.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const Profile._();
  const factory Profile({
    String? id,
    @JsonKey(name: 'updated_at') @TimestampSerializer() DateTime? updatedAt,
    @Default('') String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
}
