import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class MapDialog extends ConsumerWidget {
  const MapDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(locationControllerProvider);
    LatLng initialLocation = const LatLng(37.422131, -122.084801);
    return Scaffold(
        body: currentLocation.whenOrNull(
      data: (data) => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: data ?? initialLocation,
          zoom: 14,
        ),
      ),
      loading: () => const Text('Loading...'),
    ));
  }
}

void showMapDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(a1),
          child: const MapDialog());
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
