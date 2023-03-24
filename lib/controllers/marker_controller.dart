import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MarkerController extends StateNotifier<Marker?> {
  final LatLng? initialLocation;
  final MarkerId _markerId = const MarkerId('markerLocation');
  MarkerController(this.initialLocation) : super(null) {
    if (initialLocation != null) {
      state = Marker(
          markerId: _markerId, position: initialLocation!, draggable: true);
    }
  }

  void onMapTap(LatLng newPosition) {
    state = Marker(markerId: _markerId, draggable: true, position: newPosition);
    log('[initial 1] $initialLocation');
  }

  void reset() {
    state = null;
  }

  bool get notNull => state != null;
}
