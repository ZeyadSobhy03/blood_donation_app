import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/presentation/view_model/admin_auth_view_model.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../core/resources/routes/route_manger.dart';
import '../../../../../core/service/firebase_notification_service.dart';
import '../../../../../core/utils/error_localizer.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import '../../../donor/tabs/profile/presentation/view/sections/app_footer.dart';

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
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthInitialState) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteManger.chooseRole,
                          (route) => false,
                    );
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomText(
                          text: localizeError(state.errorKey, appLocalization),
                        ),
                      ),
                    );
                  }
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 70.h, maxWidth: double.infinity),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomElevatedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: ColorManger.brightRed.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      foregroundColor: ColorManger.brightRed,
                      backgroundColor: ColorManger.pureWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () async {
                        final authCubit = context.read<AuthCubit>();
                        final adminCubit=context.read<AdminAuthCubit>();
                        final refreshToken =
                        await adminCubit.adminHiveDataSource.getRefreshToken();

                        final fcmToken =
                        await FirebaseNotificationService.getFCMToken();

                        if (context.mounted) {
                          authCubit.logOut(
                            refreshToken: refreshToken ?? '',
                            fcmToken: fcmToken ?? '',
                          );
                          await adminCubit.adminHiveDataSource.clearAllData();
                        }
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: 24,
                            child: state is AuthLoadingState
                                ? const AspectRatio(
                              aspectRatio: 1,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorManger.brightRed,
                              ),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: ColorManger.brightRed,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: appLocalization.logout,
                                  textStyle: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
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
