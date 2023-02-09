// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtask.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Subtask _$SubtaskFromJson(Map<String, dynamic> json) {
  return _Subtask.fromJson(json);
}

/// @nodoc
mixin _$Subtask {
  String get text => throw _privateConstructorUsedError;
  bool get checked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubtaskCopyWith<Subtask> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskCopyWith<$Res> {
  factory $SubtaskCopyWith(Subtask value, $Res Function(Subtask) then) =
      _$SubtaskCopyWithImpl<$Res, Subtask>;
  @useResult
  $Res call({String text, bool checked});
}

/// @nodoc
class _$SubtaskCopyWithImpl<$Res, $Val extends Subtask>
    implements $SubtaskCopyWith<$Res> {
  _$SubtaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? checked = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubtaskCopyWith<$Res> implements $SubtaskCopyWith<$Res> {
  factory _$$_SubtaskCopyWith(
          _$_Subtask value, $Res Function(_$_Subtask) then) =
      __$$_SubtaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool checked});
}

/// @nodoc
class __$$_SubtaskCopyWithImpl<$Res>
    extends _$SubtaskCopyWithImpl<$Res, _$_Subtask>
    implements _$$_SubtaskCopyWith<$Res> {
  __$$_SubtaskCopyWithImpl(_$_Subtask _value, $Res Function(_$_Subtask) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? checked = null,
  }) {
    return _then(_$_Subtask(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Subtask extends _Subtask with DiagnosticableTreeMixin {
  const _$_Subtask({required this.text, required this.checked}) : super._();

  factory _$_Subtask.fromJson(Map<String, dynamic> json) =>
      _$$_SubtaskFromJson(json);

  @override
  final String text;
  @override
  final bool checked;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Subtask(text: $text, checked: $checked)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Subtask'))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('checked', checked));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Subtask &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.checked, checked) || other.checked == checked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, checked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubtaskCopyWith<_$_Subtask> get copyWith =>
      __$$_SubtaskCopyWithImpl<_$_Subtask>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubtaskToJson(
      this,
    );
  }
}

abstract class _Subtask extends Subtask {
  const factory _Subtask(
      {required final String text, required final bool checked}) = _$_Subtask;
  const _Subtask._() : super._();

  factory _Subtask.fromJson(Map<String, dynamic> json) = _$_Subtask.fromJson;

  @override
  String get text;
  @override
  bool get checked;
  @override
  @JsonKey(ignore: true)
  _$$_SubtaskCopyWith<_$_Subtask> get copyWith =>
      throw _privateConstructorUsedError;
}
