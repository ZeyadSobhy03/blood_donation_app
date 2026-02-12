import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../l10n/app_localizations.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key, required this.controller, required this.initialCameraPosition});
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorManger.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: ColorManger.brightRed,
              ),
              style: IconButton.styleFrom(
                backgroundColor: ColorManger.brightRed.withValues(alpha: 0.1),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomText(
                text: localizations.hospitalLocation,
                textStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final googleMapController = await controller.future;
                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(initialCameraPosition),
                );
              },
              icon: const Icon(Icons.my_location),
              style: IconButton.styleFrom(
                backgroundColor: ColorManger.brightRed.withValues(alpha: 0.1),
                foregroundColor: ColorManger.brightRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
