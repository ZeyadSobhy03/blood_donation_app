import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.name,
    required this.email,
    required this.bloodType,
  });

  final String name;
  final String email;
  final String bloodType;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ColorManger.pureWhite,
            child: Icon(Icons.person, color: ColorManger.brightRed, size: 30),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
                textStyle: const TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManger.pureWhite,
                ),
              ),
              SizedBox(height: 4),
              CustomText(
                text: email,
                textStyle: const TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.pureWhite,
                ),
              ),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: ColorManger.pureWhite.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: appLocalization.donorLabel(bloodType)
                    ,
                    textStyle: const TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManger.pureWhite,




                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
