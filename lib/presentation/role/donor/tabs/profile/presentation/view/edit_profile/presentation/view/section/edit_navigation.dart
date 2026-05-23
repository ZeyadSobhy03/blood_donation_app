import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../../../../l10n/app_localizations.dart';





class EditNavigation extends StatelessWidget {
  const EditNavigation({
    super.key,
    required bool isLoading,
    required VoidCallback handelSave,
  }) : _handelSave = handelSave,
        _isLoading = isLoading;
  final bool _isLoading;
  final VoidCallback _handelSave;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 50.h,

              ),
              child: CustomElevatedButton(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                backgroundColor: ColorManger.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: ColorManger.lightGrey),
                ),
                elevation: 3,
                foregroundColor: ColorManger.black,

                onPressed: _isLoading ? null : () => Navigator.pop(context),

                child: CustomText(
                  text: appLocalizations.cancel,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 50.h,
              ),
              child: CustomElevatedButton(
                onPressed: _isLoading ? null : _handelSave,
                elevation: 3,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                backgroundColor: ColorManger.brightRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                child: CustomText(
                  text: appLocalizations.save,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
