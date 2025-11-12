import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});
  @override
  ConsumerState<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick you location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.422, -122.084),
          zoom: 16,
        ),
        markers: {
          Marker(markerId: MarkerId("M1"), position: LatLng(37.422, -122.084)),
        },
      ),
    );
  }
}
