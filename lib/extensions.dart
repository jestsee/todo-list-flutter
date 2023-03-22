import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:todo_list/globals.dart';

extension ShowSnackBar on GlobalKey<ScaffoldMessengerState> {
  void show({
    required String message,
    Color bg = const Color.fromARGB(255, 34, 217, 128),
    Duration duration = const Duration(seconds: 1),
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: bg,
      duration: duration,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }

  void showError({required String message}) {
    show(
        message: message, bg: Colors.red, duration: const Duration(seconds: 3));
  }

  void showInfo({required String message}) {
    show(message: message, bg: Colors.blueGrey.shade700);
  }
}

extension ShowDialog on GlobalKey<NavigatorState> {
  void showMyDialog() {
    showDialog(
        context: currentContext!,
        builder: (context) => const Center(
              child: Material(
                color: Colors.transparent,
                child: Text('Hello'),
              ),
            ));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MapExtension on Position {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
