import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../donate/schedule_donation/widgets/custom_text_form_field.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({
    super.key,
    required this.currentController,
    required this.newController,
    required this.confirmController,
  });

  final TextEditingController currentController;
  final TextEditingController newController;
  final TextEditingController confirmController;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400.w,
          minWidth: 300.w,
        ),
        child: Dialog(

          backgroundColor: ColorManger.pureWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: appLocalization.changePassword,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: ColorManger.black),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                CustomText(
                  text:
                  appLocalization.changePasswordDescription,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey.withValues(alpha: 0.6),
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),

                SizedBox(height: 20.h),

                CustomTextFormField(
                  textEditingController: currentController,
                  hintText: appLocalization.currentPassword,
                ),

                SizedBox(height: 12.h),

                CustomTextFormField(
                  hintText: appLocalization.newPassword,
                  textEditingController: newController,
                ),

                SizedBox(height: 12.h),

                CustomTextFormField(
                  textEditingController: confirmController,
                  hintText: appLocalization.confirmPassword,
                ),

                SizedBox(height: 24.h),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400.w,
                    minWidth: 300.w,
                  ),
                  child: CustomElevatedButton(
                    backgroundColor: ColorManger.pureWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),

                    foregroundColor: ColorManger.black,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: appLocalization.changePassword,
                          textStyle: TextStyle(
                            fontWeight: FontWeightManager.semiBold,
                            fontSize: FontSize.s15,
                            color: ColorManger.black,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}
