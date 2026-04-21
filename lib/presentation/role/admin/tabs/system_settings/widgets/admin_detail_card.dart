import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/edit_admin_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class AdminDetailCard extends StatelessWidget {
  const AdminDetailCard({
    super.key,
    required this.adminName,
    required this.adminPosition,
  });

  final String adminName;
  final String adminPosition;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: ColorManger.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.green),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorManger.green,
                  foregroundColor: ColorManger.pureWhite,
                  radius: 24,
                  child: Icon(Icons.person_outline_outlined),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: adminName,
                        textStyle: TextStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManger.green,
                        ),
                      ),
                      SizedBox(height: 2),
                      CustomText(
                        text: adminPosition,
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                CustomElevatedButton(
                  elevation: 0,
                  foregroundColor: ColorManger.green,
                  backgroundColor: ColorManger.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: ColorManger.green, width: 1.1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditAdminDialog();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person_outline_outlined, size: 16),
                      SizedBox(width: 4),
                      CustomText(
                        text: appLocalization.editProfile,
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
