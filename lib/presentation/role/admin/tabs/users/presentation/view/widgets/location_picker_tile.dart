import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class LocationPickerTile extends StatelessWidget {
  final bool hasPickedLocation;
  final VoidCallback onTap;

  const LocationPickerTile({
    super.key,
    required this.hasPickedLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: loc.locationOnMap),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManger.lightGrey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.map_outlined, color: ColorManger.royalBlue),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: hasPickedLocation
                        ? loc.locationSelected
                        : loc.tapToSelectLocationOnMap,
                  ),
                ),
                Icon(Icons.chevron_right, color: ColorManger.slateGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}