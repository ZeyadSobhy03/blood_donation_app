import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/resources/colors/color_manger.dart';

class BuildZoomControls extends StatelessWidget {
  const BuildZoomControls({super.key, required this.controller});
  final Completer<GoogleMapController> controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              final googleMapController = await controller.future;
              googleMapController.animateCamera(CameraUpdate.zoomIn());
            },
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(foregroundColor: ColorManger.brightRed),
          ),
          Container(height: 1, width: 40, color: ColorManger.grey300),
          IconButton(
            onPressed: () async {
              final googleMapController = await controller.future;
              googleMapController.animateCamera(CameraUpdate.zoomOut());
            },
            icon: const Icon(Icons.remove),
            style: IconButton.styleFrom(foregroundColor: ColorManger.brightRed),
          ),
        ],
      ),
    );
  }
}
