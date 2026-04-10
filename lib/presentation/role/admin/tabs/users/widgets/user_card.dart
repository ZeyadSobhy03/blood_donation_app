import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/user_detail_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/resources/models/user_model.dart';
import '../../../../../../l10n/app_localizations.dart';

class UserCard extends StatelessWidget {
  static const String _roleDonor = 'donor';
  static const String _roleHospital = 'hospital';
  static const String _roleAdmin = 'admin';

  final UserModel user;
  final bool showMenu;

  const UserCard({super.key, required this.user, required this.showMenu});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final roleLabel = switch (user.role) {
      _roleDonor => appLocalizations.donor,
      _roleHospital => appLocalizations.hospitals,
      _roleAdmin => appLocalizations.admins,
      _ => user.role,
    };
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManger.grey100),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: user.name,
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  SizedBox(width: 6),
                  user.isVerified
                      ? Icon(
                          Icons.verified_outlined,
                          size: 16,
                          color: ColorManger.green,
                        )
                      : SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 4),
              CustomText(
                text:
                    '$roleLabel . ${user.bloodType} . ${user.isActive ? appLocalizations.active : appLocalizations.inactive}',
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: user.isActive
                  ? ColorManger.green
                  : ColorManger.orange.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomText(
              text: user.isActive
                  ? appLocalizations.active
                  : appLocalizations.inactive,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          SizedBox(width: 12),
          showMenu
              ? InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UserDetailDialog(user: user);
                      },
                    );
                  },
                  child: Icon(Icons.more_vert, color: ColorManger.slateGrey),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
