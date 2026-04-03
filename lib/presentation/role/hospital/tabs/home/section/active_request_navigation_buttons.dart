import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/request_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class ActiveRequestNavigationButtons extends StatelessWidget {
  const ActiveRequestNavigationButtons({
    super.key,
    this.onViewDetailPressed,
    this.onContactDonorsPressed,
  });

  final void Function()? onViewDetailPressed;

  final void Function()? onContactDonorsPressed;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.only(right: 8.w),
            child: RequestActionButtons(
              text: appLocalizations.view_details,
              backgroundColor: ColorManger.royalBlue,
              foregroundColor: ColorManger.pureWhite,
              borderColor: ColorManger.royalBlue,
              onPressed: onViewDetailPressed,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 8.w),
            child: RequestActionButtons(
              text: appLocalizations.contact_donor,
              backgroundColor: ColorManger.pureWhite,
              foregroundColor: ColorManger.black,
              borderColor: ColorManger.pureWhite.withValues(alpha: 0.5),
              onPressed: onContactDonorsPressed,
            ),
          ),
        ),
      ],
    );
  }
}
