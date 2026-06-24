import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class PointsConfigurationHeader extends StatelessWidget {
  const PointsConfigurationHeader({
    super.key,
    required this.isEditing,
    required this.onEditPressed,
    required this.onAddPressed,
  });

  final bool isEditing;
  final VoidCallback onEditPressed;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: loc.pointsConfiguration,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: loc.globalPointAllocationSettings,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
          ),
          if (!isEditing) ...[
            const SizedBox(width: 12),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CustomElevatedButton(
                  backgroundColor: ColorManger.pureWhite,
                  foregroundColor: ColorManger.brightPurple,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ColorManger.brightPurple.withValues(alpha: 0.7),
                      width: 1.2,
                    ),
                  ),
                  onPressed: onAddPressed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: ColorManger.brightPurple,
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        text: loc.addReward,
                        textStyle: TextStyle(
                          color: ColorManger.brightPurple,
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  backgroundColor: ColorManger.brightPurple,
                  foregroundColor: ColorManger.pureWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: onEditPressed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 16,
                        color: ColorManger.pureWhite,
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        text: loc.edit,
                        textStyle: TextStyle(
                          color: ColorManger.pureWhite,
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}