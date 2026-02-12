import 'dart:async';

import 'package:blood_donation_app/presentation/maps/widgets/build_app_bar.dart';
import 'package:blood_donation_app/presentation/maps/widgets/build_location_card.dart';
import 'package:blood_donation_app/presentation/maps/widgets/build_zoom_controls.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/resources/models/coordinates.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, required this.coordinates, required this.controller, this.onDirectionsPressed, this.onSharePressed, required this.initialCameraPosition});
  final Coordinates coordinates;
  final Completer<GoogleMapController> controller;
  final VoidCallback? onDirectionsPressed;
  final VoidCallback? onSharePressed;
  final CameraPosition initialCameraPosition;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Google Map
          GoogleMap(
            markers: {
              Marker(
                markerId: const MarkerId('hospital'),
                position: LatLng(coordinates.latitude, coordinates.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            },
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (googleMapController) => controller.complete(googleMapController),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: true,
          ),

          // Custom App Bar
          SafeArea(child: BuildAppBar(controller: controller, initialCameraPosition: initialCameraPosition)),

          // Zoom Controls
          Positioned(right: 16, bottom: 200, child: BuildZoomControls(controller: controller)),

          // Location Info Card
          Positioned(left: 0, right: 0, bottom: 0, child: BuildLocationCard(coordinates: coordinates, onDirectionsPressed: onDirectionsPressed, onSharePressed: onSharePressed)),
        ],
      ),
    );
  }
}
