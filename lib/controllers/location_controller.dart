import 'dart:async';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/extensions.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/services/notification_service.dart';

const fetchBackground = "fetchBackground";

class LocationController extends StateNotifier<AsyncValue<LatLng?>> {
  StreamSubscription<LocationData>? _locationStream;
  final location = Location();
  final Ref _ref;

  LocationController(this._ref) : super(const AsyncData(null));

  @override
  void dispose() {
    log('dispose location called');
    _locationStream?.cancel();
    super.dispose();
  }

  Future<PermissionStatus> requestPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    return permission;
  }

  void determinePosition() async {
    try {
      final permission = await requestPermission();
      if (permission != PermissionStatus.granted) return;

      state = const AsyncLoading();
      final position = await location.getLocation();
      state = AsyncData(position.toLatLng());
      log('[location state] $state');
    } on Exception catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void startLocationTracking() async {
    _locationStream?.cancel();

    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        title: 'location', subtitle: 'location tracking');

    final permission = await requestPermission();
    if (permission != PermissionStatus.granted) return;

    _locationStream = location.onLocationChanged.listen((currentLocation) {
      log('[position] ${currentLocation.latitude} ${currentLocation.longitude}');
      state = AsyncData(currentLocation.toLatLng());

      final userData = _ref.read(authControllerProvider);
      if (userData.value == null) return;
      final tasksData = _ref.read(taskListControllerProvider);
      if (!tasksData.hasValue) return;

      final tasks = tasksData.value!;
      for (var i = 0; i < tasks.length; i++) {
        final task = tasks.elementAt(i);

        if (task.latitude == null || task.longitude == null) continue;

        if (task.locationNotification != null &&
            task.locationNotification!.difference(DateTime.now()).inHours < 5) {
          continue;
        }

        final distance =
            currentLocation.haversine(task.latitude!, task.longitude!);
        log('distance: $distance');
        if (distance <= 2) {
          NotificationService.showNotification(
              title: task.title, body: 'This task location is nearby');
          tasks[i] = task.copyWith(locationNotification: DateTime.now());
        }
      }
    });
  }
}
