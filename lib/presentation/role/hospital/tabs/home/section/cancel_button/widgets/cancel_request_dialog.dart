import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelRequestDialog extends StatelessWidget {
  const CancelRequestDialog({
    super.key,
    required this.urgency,
    required this.bloodType,
    required this.unitsNeeded,
    required this.urgencyColor,
    this.onConfirmCancel,
  });

  final String urgency;
  final String bloodType;
  final int unitsNeeded;
  final Color urgencyColor;
  final VoidCallback? onConfirmCancel;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.delete_outline,
                    color: ColorManger.brightRed, size: 22),
                const SizedBox(width: 8),
                CustomText(
                  text: loc.cancelRequestBtn,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.brightRed,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            CustomText(
              text: loc.cancelRequestConfirmation,
              textStyle: TextStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.slateGrey,
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Row(
                children: [
                  CustomBadge(
                    text: urgency,
                    backgroundColor: urgencyColor,
                    fontColor: ColorManger.pureWhite,
                    borderColor: urgencyColor,
                  ),
                  SizedBox(width: 8.w),
                  CustomBadge(
                    text: bloodType,
                    backgroundColor: ColorManger.pureWhite,
                    fontColor: ColorManger.black,
                    borderColor: ColorManger.lightGrey,
                  ),
                  SizedBox(width: 12.w),
                  CustomText(
                    text: loc.unit_needed(unitsNeeded),
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManger.black,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: ColorManger.lightGrey),
                    ),
                    child: CustomText(
                      text: loc.keepRequest,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirmCancel?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: ColorManger.brightRed,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: CustomText(
                      text: loc.yesCancelRequest,
                      textStyle: TextStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManger.pureWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}