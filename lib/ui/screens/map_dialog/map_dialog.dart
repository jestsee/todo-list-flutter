import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class MapDialog extends ConsumerWidget {
  final LatLng? initialLocation;
  final LatLng? markerLocation;
  const MapDialog({super.key, this.initialLocation, this.markerLocation});

  final fallbackLocation = const LatLng(37.422131, -122.084801);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerAction =
        ref.read(markerControllerProvider(markerLocation).notifier);
    final marker = ref.watch(markerControllerProvider(markerLocation));
    final currentLocation = ref.watch(locationControllerProvider);
    final setMarkers = markerAction.notNull ? {marker!} : <Marker>{};

    return Scaffold(
        body: currentLocation.whenOrNull(
      data: (data) => Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: setMarkers,
              onTap: markerAction.onMapTap,
              initialCameraPosition: CameraPosition(
                target: initialLocation ?? data ?? fallbackLocation,
                zoom: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: markerAction.reset,
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      loading: () => const Text('Loading...'),
    ));
  }
}

void showMapDialog(BuildContext context,
    {LatLng? initialLocation, LatLng? markerLocation}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(a1),
          child: MapDialog(
            initialLocation: initialLocation,
            markerLocation: markerLocation,
          ));
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
