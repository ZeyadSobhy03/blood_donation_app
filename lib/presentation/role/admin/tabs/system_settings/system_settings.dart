import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/admin_detail_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/audit_logs_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/clickable_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/enable_maintenance_mode_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/role_based_permission_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/section_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/switch_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/system_control_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/system_health_check_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../donor/tabs/profile/sections/app_footer.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  bool emergencyAlertsEnabled = true;
  bool aiPredictionsEnabled = true;
  bool twoFactorAuthEnabled = true;

  void showPermissionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const RoleBasedPermissionsDialog(),
    );
  }

  void showAuditLogsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AuditLogsDialog());
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              CustomTitle(
                title: appLocalization.systemSettingsTitle,
                subTitle: appLocalization.systemSettingsSubtitle,
              ),
              SizedBox(height: 16),
              AdminDetailCard(
                adminName: "Admin Name",
                adminPosition: "Super Admin",
              ),

              const SizedBox(height: 16),
              SectionCard(
                title: appLocalization.securitySettings,
                icon: Icons.security,
                children: [
                  ClickableTile(
                    icon: Icons.shield_outlined,
                    label: appLocalization.roleBasedPermissions,
                    onTap: () => showPermissionsDialog(context),
                  ),
                  const Divider(),
                  CustomSwitchTile(
                    title: appLocalization.twoFactorAuthentication,
                    subtitle: appLocalization.requiredForAllAdminAccounts,
                    val: twoFactorAuthEnabled,
                    onChanged: (value) {
                      setState(() {
                        twoFactorAuthEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: appLocalization.systemHealth,
                icon: Icons.health_and_safety,
                children: [
                  ClickableTile(
                    icon: Icons.refresh,
                    label: appLocalization.systemHealthCheck,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SystemHealthCheckDialog();
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SystemControlCard(
                onTapEmergencyShutdown: () {

                },
                onTapEnableMaintenanceMode: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EnableMaintenanceModeDialog();
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                foregroundColor: ColorManger.pureWhite,
                backgroundColor: ColorManger.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: ColorManger.green),
                ),
                elevation: 0,
                onPressed: () {},
                child: CustomText(text: appLocalization.logout),
              ),
              SizedBox(height: 16),
              AppFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
