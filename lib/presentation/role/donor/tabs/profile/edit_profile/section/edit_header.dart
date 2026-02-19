import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class EditHeader extends StatelessWidget {
  const EditHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: Border(
          bottom: BorderSide(color: ColorManger.lightGrey, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: appLocalizations.editProfile,
                  textStyle: TextStyle(
                    color:ColorManger.black,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: appLocalizations.editProfileDescription,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20.r),
            child: Icon(
              Icons.close_rounded,
              size: 24,
              color: ColorManger.slateGrey,
            ),
          ),
        ],
      ),
    );
  }
}
