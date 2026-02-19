import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoFAMethodTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const TwoFAMethodTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Row(
        children: [
          CustomText(
            text: title,
            textStyle: TextStyle(
              color: ColorManger.darkBlue,
              fontWeight: FontWeightManager.semiBold,
              fontSize: FontSize.s14,
            ),
          ),

        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: CustomText(
          text: subtitle,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s12,
          ),
        ),
      ),
      trailing: Switch.adaptive(value: value, onChanged: onChanged,


        activeThumbColor: ColorManger.pureWhite,
        activeTrackColor: ColorManger.darkBlue,
        inactiveThumbColor: ColorManger.grey300,
        inactiveTrackColor: ColorManger.pureWhite,
      ),
    );
  }
}
