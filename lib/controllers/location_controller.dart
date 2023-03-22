import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/extensions.dart';

class LocationController extends StateNotifier<AsyncValue<LatLng?>> {
  StreamSubscription<Position>? _positionStream;

  final LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 10),
      // keep the app alive when going to background
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText:
            "Example app will continue to receive your location even when you aren't using it",
        notificationTitle: "Running in Background",
        enableWakeLock: true,
      ));

  LocationController() : super(const AsyncData(null)) {
    _positionStream?.cancel();
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      log('[position] ${position.latitude} ${position.longitude}');
      state = AsyncData(position.toLatLng());
    });
  }

  @override
  void dispose() {
    log('dispose called');
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final canOpenSettings = await Geolocator.openLocationSettings();
      if (!canOpenSettings) {
        return Future.error('Location services are disabled.');
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    state = const AsyncLoading();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    state = AsyncData(position.toLatLng());
    log('[location state] $state');
  }
}
