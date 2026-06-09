import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/update_button/update_button.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/request_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';
import 'cancel_button/cancel_button.dart';

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
              child: UpdateButton(
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
              child: CancelButton(
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