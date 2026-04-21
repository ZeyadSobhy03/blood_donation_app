import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/admin_detail_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/audit_logs_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/clickable_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/role_based_permission_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/section_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/switch_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/system_control_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class SystemSettings extends StatelessWidget {
  const SystemSettings({super.key});


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
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomTitle(
                title: appLocalization.systemSettingsTitle,
                subTitle: appLocalization.systemSettingsSubtitle,
              ),
              SizedBox(height: 16,),
              AdminDetailCard(
                adminName: "Admin Name",
                adminPosition: "Super Admin"


              ),
              SectionCard(
                title: appLocalization.notificationSettings,
                icon: Icons.notifications_none,
                children: [
                  SwitchTile(
                    appLocalization.emergencyAlerts,
                    appLocalization.criticalBloodShortageNotifications,
                    true,
                  ),
                  SwitchTile(
                    appLocalization.aiPredictions,
                    appLocalization.machineLearningDemandForecasts,
                    true,
                  ),
                ],
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
                  ClickableTile(
                    icon: Icons.storage,
                    label: appLocalization.viewAuditLogs,
                    onTap: () => showAuditLogsDialog(context),
                  ),
                  const Divider(),
                  SwitchTile(
                    appLocalization.twoFactorAuthentication,
                    appLocalization.requiredForAllAdminAccounts,
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: appLocalization.gpsAndLocation,
                icon: Icons.location_on_outlined,
                children: [
                  ClickableTile(label: appLocalization.configureSearchRadius, onTap: () {}),
                  ClickableTile(
                    label: appLocalization.locationAccuracySettings,
                    onTap: () {},
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
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SystemControlCard(),
            ],
          ),
        ),
      ),
    );
  }
}
