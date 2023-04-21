import 'dart:async';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/extensions.dart';

const fetchBackground = "fetchBackground";

class LocationController extends StateNotifier<AsyncValue<LatLng?>> {
  StreamSubscription<LocationData>? _locationStream;
  final location = Location();

  LocationController() : super(const AsyncData(null));

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
    });
  }
}
