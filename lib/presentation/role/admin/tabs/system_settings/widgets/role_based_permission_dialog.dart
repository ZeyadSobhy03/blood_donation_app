import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/permission_group.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class RoleBasedPermissionsDialog extends StatelessWidget {
  const RoleBasedPermissionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDialogHeader(
                  title: appLocalization.roleBasedPermissionsTitle,
                  subtitle: appLocalization.roleBasedPermissionsSubtitle,
                ),
                PermissionGroup(
                  appLocalization.adminPermissions,
                  [
                    appLocalization.userManagement,
                    appLocalization.systemSettings,
                    appLocalization.emergencyBroadcasts,
                  ],
                ),
                PermissionGroup(
                  appLocalization.hospitalPermissions,
                  [
                    appLocalization.createRequests,
                    appLocalization.generateQrCodes,
                    appLocalization.viewAnalytics,
                  ],
                ),
                PermissionGroup(
                  appLocalization.donorPermissions,
                  [
                    appLocalization.viewRequests,
                    appLocalization.respondToAlerts,
                    appLocalization.earnRewards,
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: ColorManger.pureWhite,
                        foregroundColor: ColorManger.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: ColorManger.lightGrey),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(appLocalization.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: ColorManger.brightPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),

                        ),
                        foregroundColor: ColorManger.pureWhite,
                        elevation: 0,
                        onPressed: () {},

                        child: Text(
                          appLocalization.saveChanges,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
