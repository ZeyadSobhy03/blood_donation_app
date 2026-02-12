import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/resources/models/coordinates.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../l10n/app_localizations.dart';

class BuildLocationCard extends StatelessWidget {
  const BuildLocationCard({super.key, required this.coordinates, this.onDirectionsPressed, this.onSharePressed});
  final Coordinates coordinates;
  final VoidCallback? onDirectionsPressed;
  final VoidCallback? onSharePressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorManger.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_hospital,
                    color: ColorManger.brightRed,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: localizations.bloodDonationCenter,
                        textStyle: TextStyle(
                          color: ColorManger.grey800,
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: CustomText(
                              text:
                              '${coordinates.latitude.toStringAsFixed(4)}, ${coordinates.longitude.toStringAsFixed(4)}',
                              textStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.regular,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onDirectionsPressed,
                    icon: const Icon(Icons.directions, size: 20),
                    label: CustomText(text: localizations.directions),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManger.brightRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: onSharePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManger.brightRed.withValues(
                      alpha: 0.1,
                    ),
                    foregroundColor: ColorManger.brightRed,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Icon(Icons.share, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
