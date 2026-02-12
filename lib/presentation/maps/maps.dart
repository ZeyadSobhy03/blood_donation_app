import 'dart:async';

import 'package:blood_donation_app/presentation/maps/widgets/error_state.dart';
import 'package:blood_donation_app/presentation/maps/widgets/loading_state.dart';
import 'package:blood_donation_app/presentation/maps/widgets/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/cubits/map_cubit.dart';
import '../../core/resources/colors/color_manger.dart';
import '../../core/resources/fonts/font_manger.dart';
import '../../core/resources/models/coordinates.dart';
import '../../core/widgets/custom_text.dart';
import '../../l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Coordinates coordinates;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late MapCubit cubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    coordinates = ModalRoute.of(context)!.settings.arguments as Coordinates;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cubit = context.read<MapCubit>();
  }

  Future<void> _openDirections() async {
    final lat = coordinates.latitude;
    final lng = coordinates.longitude;

    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }

  _shareLocation() {
    final lat = coordinates.latitude;
    final lng = coordinates.longitude;
    final localizations = AppLocalizations.of(context)!;

    final googleMapsLink =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    SharePlus.instance.share(
      ShareParams(
        text: localizations.shareMessage(
          lat.toStringAsFixed(4),
          lng.toStringAsFixed(4),
          googleMapsLink,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return LoadingState();
          }
          if (state is MapError) {
            return ErrorState(
              error: state.error,
              controller: _controller,
              initialCameraPosition: _initialCameraPosition(),
            );
          }
          if (state is MapLoaded) {
            return MapView(
              coordinates: coordinates,
              controller: _controller,
              initialCameraPosition: _initialCameraPosition(),
              onDirectionsPressed: _openDirections,
              onSharePressed: _shareLocation,
            );
          }
          return LoadingState();
        },
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: ColorManger.brightRed,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomText(
                        text: state.error,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  CameraPosition _initialCameraPosition() {
    return CameraPosition(
      target: LatLng(coordinates.latitude, coordinates.longitude),
      zoom: 16,
    );
  }
}
