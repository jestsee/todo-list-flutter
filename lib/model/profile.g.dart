// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      id: json['id'] as String?,
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['updated_at'], const TimestampSerializer().fromJson),
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': _$JsonConverterToJson<String, DateTime>(
          instance.updatedAt, const TimestampSerializer().toJson),
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
