import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/presentation/view_model/admin_auth_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/admin_detail_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/audit_logs_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/clickable_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/enable_maintenance_mode_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/role_based_permission_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/section_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/system_control_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/system_health_check_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/sections/password_and_security_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../core/service/firebase_notification_service.dart';
import '../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../../authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import '../../../../../donor/tabs/profile/presentation/view/sections/app_footer.dart';
import '../view_model/system_maintenance/system_maintenance_view_model.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  bool _isMaintenanceActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SystemMaintenanceCubit>().getMaintenanceStatus();
    });
  }

  void showPermissionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const RoleBasedPermissionsDialog(),
    );
  }

  void showAuditLogsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AuditLogsDialog());
  }

  void _confirmEmergencyShutdown(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: ColorManger.brightRed),
            const SizedBox(width: 8),
            Text(loc.emergencyShutdown),
          ],
        ),
        content: Text(
          loc.confirmEmergencyShutdown,
          style: TextStyle(color: ColorManger.black, fontSize: FontSize.s14),
        ),
        actions: [
          CustomElevatedButton(
            backgroundColor: ColorManger.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: ColorManger.slateGrey.withValues(alpha: 0.4), width: 1),
            ),
            foregroundColor: ColorManger.slateGrey,
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.cancel, style: TextStyle(color: ColorManger.slateGrey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorManger.brightRed),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<SystemMaintenanceCubit>().toggleSystemMaintenance(
                enabled: true,
                message: loc.emergencyShutdownInitiated ,
              );
            },
            child: Text(loc.confirm, style: TextStyle(color: ColorManger.pureWhite)),
          ),
        ],
      ),
    );
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
            children: [
              CustomTitle(
                hasIcon: true,
                title: appLocalization.systemSettingsTitle,
                subTitle: appLocalization.systemSettingsSubtitle,
              ),
              const SizedBox(height: 16),
              AdminDetailCard(),
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
                        builder: (context) => SystemHealthCheckDialog(),
                      );
                    },
                  ),
                  ClickableTile(
                    icon: Icons.mark_email_unread_outlined,
                    label: appLocalization.inboundEmails,
                    onTap: () => Navigator.pushNamed(context, RouteManger.inboundEmailsScreen),
                  ),
                  ClickableTile(
                    icon: Icons.receipt_long_outlined,
                    label: appLocalization.auditLogs,
                    onTap: () => Navigator.pushNamed(context, RouteManger.auditLogsScreen),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PasswordAndSecurityCard(
                isDonor: false,
                backgroundColor: ColorManger.brightPurple,
              ),


              const SizedBox(height: 16),


              BlocConsumer<SystemMaintenanceCubit, SystemMaintenanceState>(
                listener: (context, state) {
                  if (state is SystemMaintenanceSuccessState) {
                    setState(() {
                      _isMaintenanceActive = state.systemMaintenanceModel.data?.maintenanceMode ?? true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localizeError(
                          mapServerErrorToKey(state.systemMaintenanceModel.message),
                          appLocalization,
                        )),
                        backgroundColor: _isMaintenanceActive ? ColorManger.brightRed : ColorManger.green,
                      ),
                    );
                  } else if (state is MaintenanceStatusSuccessState) {
                    setState(() {

                      _isMaintenanceActive = state.maintenanceStatusModel.data?.enabled ?? false;
                    });
                  } else if (state is SystemMaintenanceErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localizeError(state.errorKey, appLocalization)),
                        backgroundColor: ColorManger.orange,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is SystemMaintenanceLoadingState;

                  return SystemControlCard(
                    isMaintenanceActive: _isMaintenanceActive,
                    isLoading: isLoading,
                    onTapEmergencyShutdown: isLoading ? null : () {
                      _confirmEmergencyShutdown(context, appLocalization);
                    },
                    onTapEnableMaintenanceMode: isLoading ? null : () {
                      showDialog(
                        context: context,
                        builder: (context) => const EnableMaintenanceModeDialog(),
                      );
                    },
                    onTapDisableMaintenanceMode: isLoading ? null : () {
                      context.read<SystemMaintenanceCubit>().toggleSystemMaintenance(
                        enabled: false,
                        message: appLocalization.systemRestored,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 16),

              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthInitialState) {
                    Navigator.pushNamedAndRemoveUntil(context, RouteManger.chooseRole, (route) => false);
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: CustomText(text: localizeError(state.errorKey, appLocalization))),
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
                        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.4), width: 1),
                      ),
                      elevation: 0,
                      foregroundColor: ColorManger.brightRed,
                      backgroundColor: ColorManger.pureWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () async {
                        final authCubit = context.read<AuthCubit>();
                        final adminCubit = context.read<AdminAuthCubit>();
                        final refreshToken = await adminCubit.adminHiveDataSource.getRefreshToken();
                        final fcmToken = await FirebaseNotificationService.getFCMToken();

                        if (context.mounted) {
                          authCubit.logOut(refreshToken: refreshToken ?? '', fcmToken: fcmToken ?? '');
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
                              child: CircularProgressIndicator(strokeWidth: 2, color: ColorManger.brightRed),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout, color: ColorManger.brightRed),
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
              const SizedBox(height: 16),
              const AppFooter(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}