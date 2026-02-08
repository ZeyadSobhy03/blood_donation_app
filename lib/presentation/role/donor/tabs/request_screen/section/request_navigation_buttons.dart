import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class RequestNavigationButtons extends StatelessWidget {
  const RequestNavigationButtons({
    super.key,

    this.accept, this.cancel,

  });

  final void Function()? accept;
  final void Function()? cancel;


  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;


    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: 50,
            ),
            child: CustomElevatedButton(
              backgroundColor: ColorManger.brightRed,
              elevation: 3,
              foregroundColor: ColorManger.pureWhite,
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

              onPressed: accept,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: ColorManger.pureWhite),
                  SizedBox(width: 4.w),
                  CustomText(
                    text: appLocalization.iCanHelpRespondNow,
                    textStyle: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManger.pureWhite,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        },),
        SizedBox(height: 4.h,),
        LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: 50,
            ),
            child: CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                elevation: 3,

                onPressed: cancel,
                child:  CustomText(
                  text: appLocalization.notAvailable,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.black,
                    height: 1.4,
                  ),
                )
            ),
          );
        },)
      ],
    );


  }
}
