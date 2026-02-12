import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../l10n/app_localizations.dart';
import 'build_app_bar.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.error, required this.controller, required this.initialCameraPosition});
  final String error;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorManger.brightRed.withValues(alpha: 0.1), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            BuildAppBar(controller: controller, initialCameraPosition: initialCameraPosition),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: ColorManger.brightRed.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 64,
                          color: ColorManger.brightRed,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomText(
                        text: localizations.oopsError,
                        textStyle: TextStyle(
                          color: ColorManger.brightRed,
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        text: error,
                        textStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        label: CustomText(text: localizations.goBack),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManger.brightRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
