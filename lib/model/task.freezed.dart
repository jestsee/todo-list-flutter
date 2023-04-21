// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String? get id => throw _privateConstructorUsedError;
  int? get notificationId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  int? get groupId => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get deadline => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get locationNotification => throw _privateConstructorUsedError;
  Priority get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @TimestampSerializer()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'subtask')
  List<Subtask>? get subtasks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String? id,
      int? notificationId,
      String title,
      @JsonKey(name: 'group_id') int? groupId,
      double? longitude,
      double? latitude,
      @TimestampSerializer() DateTime? deadline,
      @TimestampSerializer() DateTime? locationNotification,
      Priority priority,
      @JsonKey(name: 'created_at') @TimestampSerializer() DateTime? createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'subtask') List<Subtask>? subtasks});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? notificationId = freezed,
    Object? title = null,
    Object? groupId = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? deadline = freezed,
    Object? locationNotification = freezed,
    Object? priority = null,
    Object? createdAt = freezed,
    Object? createdBy = null,
    Object? subtasks = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationId: freezed == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      locationNotification: freezed == locationNotification
          ? _value.locationNotification
          : locationNotification // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      subtasks: freezed == subtasks
          ? _value.subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<Subtask>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? notificationId,
      String title,
      @JsonKey(name: 'group_id') int? groupId,
      double? longitude,
      double? latitude,
      @TimestampSerializer() DateTime? deadline,
      @TimestampSerializer() DateTime? locationNotification,
      Priority priority,
      @JsonKey(name: 'created_at') @TimestampSerializer() DateTime? createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'subtask') List<Subtask>? subtasks});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$_Task>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? notificationId = freezed,
    Object? title = null,
    Object? groupId = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? deadline = freezed,
    Object? locationNotification = freezed,
    Object? priority = null,
    Object? createdAt = freezed,
    Object? createdBy = null,
    Object? subtasks = freezed,
  }) {
    return _then(_$_Task(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationId: freezed == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      locationNotification: freezed == locationNotification
          ? _value.locationNotification
          : locationNotification // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      subtasks: freezed == subtasks
          ? _value._subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<Subtask>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Task extends _Task with DiagnosticableTreeMixin {
  const _$_Task(
      {this.id,
      this.notificationId,
      required this.title,
      @JsonKey(name: 'group_id') this.groupId,
      this.longitude,
      this.latitude,
      @TimestampSerializer() this.deadline,
      @TimestampSerializer() this.locationNotification,
      this.priority = Priority.low,
      @JsonKey(name: 'created_at') @TimestampSerializer() this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'subtask') final List<Subtask>? subtasks = const []})
      : _subtasks = subtasks,
        super._();

  factory _$_Task.fromJson(Map<String, dynamic> json) => _$$_TaskFromJson(json);

  @override
  final String? id;
  @override
  final int? notificationId;
  @override
  final String title;
  @override
  @JsonKey(name: 'group_id')
  final int? groupId;
  @override
  final double? longitude;
  @override
  final double? latitude;
  @override
  @TimestampSerializer()
  final DateTime? deadline;
  @override
  @TimestampSerializer()
  final DateTime? locationNotification;
  @override
  @JsonKey()
  final Priority priority;
  @override
  @JsonKey(name: 'created_at')
  @TimestampSerializer()
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  final List<Subtask>? _subtasks;
  @override
  @JsonKey(name: 'subtask')
  List<Subtask>? get subtasks {
    final value = _subtasks;
    if (value == null) return null;
    if (_subtasks is EqualUnmodifiableListView) return _subtasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(id: $id, notificationId: $notificationId, title: $title, groupId: $groupId, longitude: $longitude, latitude: $latitude, deadline: $deadline, locationNotification: $locationNotification, priority: $priority, createdAt: $createdAt, createdBy: $createdBy, subtasks: $subtasks)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('notificationId', notificationId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('deadline', deadline))
      ..add(DiagnosticsProperty('locationNotification', locationNotification))
      ..add(DiagnosticsProperty('priority', priority))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('createdBy', createdBy))
      ..add(DiagnosticsProperty('subtasks', subtasks));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.locationNotification, locationNotification) ||
                other.locationNotification == locationNotification) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._subtasks, _subtasks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      notificationId,
      title,
      groupId,
      longitude,
      latitude,
      deadline,
      locationNotification,
      priority,
      createdAt,
      createdBy,
      const DeepCollectionEquality().hash(_subtasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  const factory _Task(
      {final String? id,
      final int? notificationId,
      required final String title,
      @JsonKey(name: 'group_id')
          final int? groupId,
      final double? longitude,
      final double? latitude,
      @TimestampSerializer()
          final DateTime? deadline,
      @TimestampSerializer()
          final DateTime? locationNotification,
      final Priority priority,
      @JsonKey(name: 'created_at')
      @TimestampSerializer()
          final DateTime? createdAt,
      @JsonKey(name: 'created_by')
          required final String createdBy,
      @JsonKey(name: 'subtask')
          final List<Subtask>? subtasks}) = _$_Task;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  String? get id;
  @override
  int? get notificationId;
  @override
  String get title;
  @override
  @JsonKey(name: 'group_id')
  int? get groupId;
  @override
  double? get longitude;
  @override
  double? get latitude;
  @override
  @TimestampSerializer()
  DateTime? get deadline;
  @override
  @TimestampSerializer()
  DateTime? get locationNotification;
  @override
  Priority get priority;
  @override
  @JsonKey(name: 'created_at')
  @TimestampSerializer()
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'subtask')
  List<Subtask>? get subtasks;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}
