import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/resources/colors/color_manger.dart';
import '../cubits/map_cubit.dart';

class PickedLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PickedLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class LocationPickerMap extends StatefulWidget {

  final double? initialLatitude;
  final double? initialLongitude;

  const LocationPickerMap({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  GoogleMapController? _mapController;
  LatLng? _pickedPosition;
  String _pickedAddress = '';

  static const CameraPosition _fallbackCamera = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _pickedPosition = LatLng(widget.initialLatitude!, widget.initialLongitude!);
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _animateTo(LatLng target) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(target));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.selectLocationOnMap),
        backgroundColor: ColorManger.pureWhite,
        foregroundColor: ColorManger.black,
        elevation: 0,
      ),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is MapLoaded) {
            final target = LatLng(state.latitude, state.longitude);
            setState(() {
              _pickedPosition = target;
              _pickedAddress = '${state.city}, ${state.governorate}';
            });
            _animateTo(target);
          } else if (state is MapError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is MapPermissionPermanentlyDenied) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(loc.locationPermissionPermanentlyDenied)),
              );
          }
        },
        builder: (context, state) {
          final initialCamera = _pickedPosition != null
              ? CameraPosition(target: _pickedPosition!, zoom: 15)
              : _fallbackCamera;

          return SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCamera,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _mapController = controller,
                  onTap: (latLng) {
                    context.read<MapCubit>().pickLocation(
                      latLng.latitude,
                      latLng.longitude,
                    );
                  },
                  markers: _pickedPosition == null
                      ? {}
                      : {
                    Marker(
                      markerId: const MarkerId('picked-location'),
                      position: _pickedPosition!,
                      draggable: true,
                      onDragEnd: (latLng) {
                        context.read<MapCubit>().pickLocation(
                          latLng.latitude,
                          latLng.longitude,
                        );
                      },
                    ),
                  },
                ),

                if (state is MapLoading)
                  const Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // Bottom confirm card
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _pickedPosition == null
                                ? loc.tapOnMapToSelectLocation
                                : _pickedAddress,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (_pickedPosition != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${_pickedPosition!.latitude.toStringAsFixed(6)}, '
                                  '${_pickedPosition!.longitude.toStringAsFixed(6)}',
                              style: TextStyle(
                                color: ColorManger.slateGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManger.royalBlue,
                                foregroundColor: ColorManger.pureWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: _pickedPosition == null
                                  ? null
                                  : () {
                                Navigator.of(context).pop(
                                  PickedLocation(
                                    latitude: _pickedPosition!.latitude,
                                    longitude: _pickedPosition!.longitude,
                                    address: _pickedAddress,
                                  ),
                                );
                              },
                              child: Text(loc.confirmLocation),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}