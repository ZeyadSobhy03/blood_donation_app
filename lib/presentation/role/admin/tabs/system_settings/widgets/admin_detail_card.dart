import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/admin_profile_tail.dart';
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
    final items = [
      {
        "label": appLocalization.email,
        "value": "ziyad@gmail.com",
        "icon": null,
      },
      {
        "label": appLocalization.phone,
        "value": "+201234567890",
        "icon": Icons.phone_outlined,
      },
      {
        "label": appLocalization.admin_access_key,
        "value": "Super Admin",
        "icon": Icons.key_outlined,
      },
      {
        "label": appLocalization.department,
        "value": "IT Department",
        "icon": Icons.apartment_outlined,
      },
    ];
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
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 8),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AdminProfileTail(
                        label: items[0]['label'] as String,
                        value: items[0]['value'] as String,
                        icon: items[0]['icon'] as IconData?,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: AdminProfileTail(
                        label: items[1]['label'] as String,
                        value: items[1]['value'] as String,
                        icon: items[1]['icon'] as IconData?,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AdminProfileTail(
                        label: items[2]['label'] as String,
                        value: items[2]['value'] as String,
                        icon: items[2]['icon'] as IconData?,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: AdminProfileTail(
                        label: items[3]['label'] as String,
                        value: items[3]['value'] as String,
                        icon: items[3]['icon'] as IconData?,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
