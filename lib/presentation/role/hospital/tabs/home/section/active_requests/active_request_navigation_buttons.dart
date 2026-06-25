import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/request_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ActiveRequestNavigationButtons extends StatelessWidget {
  const ActiveRequestNavigationButtons({
    super.key,
    this.onViewDetailPressed,
    this.onContactDonorsPressed,
    this.onUpdatePressed,
    this.onCancelPressed,
  });

  final VoidCallback? onViewDetailPressed;
  final VoidCallback? onContactDonorsPressed;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RequestActionButtons(
                text: loc.view_details,
                backgroundColor: ColorManger.royalBlue,
                foregroundColor: ColorManger.pureWhite,
                borderColor: ColorManger.royalBlue,
                onPressed: onViewDetailPressed,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _UpdateButton(
                label: loc.update,
                onPressed: onUpdatePressed,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: RequestActionButtons(
                text: loc.contact_donor,
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                borderColor: ColorManger.lightGrey,
                onPressed: onContactDonorsPressed,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _CancelButton(
                label: loc.cancelRequestBtn,
                onPressed: onCancelPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.edit_outlined, size: 16, color: ColorManger.pureWhite),
      label: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.bold,
          color: ColorManger.pureWhite,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        backgroundColor: const Color(0xFFE67E22), // orange
        foregroundColor: ColorManger.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.delete_outline, size: 16, color: ColorManger.brightRed),
      label: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.bold,
          color: ColorManger.brightRed,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
