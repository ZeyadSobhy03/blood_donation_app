import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../edit_profile/edit_profile.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ColorManger.pureWhite,
            child: Icon(Icons.person, color: ColorManger.brightRed, size: 30),
          ),
          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  textStyle: const TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManger.pureWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: email,
                  textStyle: const TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.pureWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 80.w,


                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManger.pureWhite.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomText(
                        text: appLocalization.donorLabel(bloodType),
                        textStyle: const TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManger.pureWhite,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return EditProfileDialog(
                    initialName: 'Sarah Johnson',
                    initialEmail: 'sarah.j@email.com',
                    initialPhone: '+1 (555) 123-4567',
                    initialLocation: 'San Francisco, CA',
                    initialBloodType: 'O+',
                    initialWeight: '65',
                    initialAge: '28',
                    initialGender: 'Female',
                  );
                },
              );
            },
            icon: Icon(Icons.edit_note_sharp, size: 30),
            color: ColorManger.pureWhite,
          ),
        ],
      ),
    );
  }
}
