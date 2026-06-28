import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/service/firebase_notification_service.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/presentation/view_model/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/capacity_row.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_contact_row.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_profile_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_stat_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/edit_profile_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/notification_preferences_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/security_settings_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_settings_tile.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/working_hours_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/colors/color_manger.dart';
import '../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../authentication/hospital_authentication/presentation/view_model/hospital_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context);
    if (loc != null) {
      context.read<ProfileCubit>().setAppLoc(loc);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileActionSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ProfileActionErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadingState || state is ProfileInitialState) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ProfileErrorState && (context.read<ProfileCubit>().profile == null)) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        final profile = state is ProfileLoadedState
            ? state.profile
            : context.read<ProfileCubit>().profile;

        if (profile == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final wh = profile.workingHours;
        final openingHour = wh?.openingHour ?? 8;
        final closingHour = wh?.closingHour ?? 19;
        final slotsPerHour = wh?.slotsPerHour ?? 8;
        final hoursPerDay = closingHour > openingHour ? closingHour - openingHour : 0;
        final totalDailySlots = hoursPerDay * slotsPerHour;
        String fmt(int h) => '${h.toString().padLeft(2, '0')}:00';

        final notif = profile.notifications;
        final stats = profile.statistics;
        final addr = formatAddress(profile.address);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalization.hospitalProfile,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  appLocalization.manageHospitalInformation,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),

                CustomProfileCard(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE0F2FE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_hospital_outlined,
                          color: Colors.blue,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.hospitalName ?? appLocalization.unknown,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profile.department ?? appLocalization.emergencyDepartment,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => EditHospitalProfileDialog(
                            hospitalName: profile.hospitalName ?? '',
                            department: profile.department ?? '',
                            contactNumber: profile.contactNumber ?? '',
                            email: profile.email ?? '',
                            address: addr,
                            onSave: ({
                              required hospitalName,
                              required department,
                              required contactNumber,
                              required email,
                              required address,
                            }) =>
                                context.read<ProfileCubit>().updateProfile(
                                  hospitalName: hospitalName,
                                  department: department,
                                  contactNumber: contactNumber,
                                  email: email,
                                  address: address,
                                ),
                          ),
                        ),
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        label: Text(appLocalization.edit),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                CustomProfileCard(
                  title: appLocalization.contactInformation,
                  child: Column(
                    children: [
                      CustomContactRow(
                        icon: Icons.phone_outlined,
                        text: profile.contactNumber ?? "+1 (555) 987-6543",
                      ),
                      CustomContactRow(
                        icon: Icons.email_outlined,
                        text: profile.email ?? "emergency@metrohealth.com",
                      ),
                      CustomContactRow(
                        icon: Icons.location_on_outlined,
                        text: addr.isNotEmpty ? addr : "123 Medical Center Dr, City",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                CustomProfileCard(
                  title: appLocalization.settings,
                  child: Column(
                    children: [
                      CustomSettingsTile(
                        icon: Icons.access_time,
                        title: appLocalization.working_hours_and_slots,
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => WorkingHoursDialog(
                            initialOpeningHour: openingHour,
                            initialClosingHour: closingHour,
                            initialSlotsPerHour: slotsPerHour,
                            onSave: ({
                              required openingHour,
                              required closingHour,
                              required slotsPerHour,
                            }) =>
                                context.read<ProfileCubit>().updateWorkingHours(
                                  openingHour: openingHour,
                                  closingHour: closingHour,
                                  slotsPerHour: slotsPerHour,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomSettingsTile(
                        icon: Icons.notifications_none,
                        title: appLocalization.notificationPreferences,
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => NotificationPreferencesDialog(
                            pushNotifications: notif?.pushNotifications ?? true,
                            emergencyAlerts: notif?.emergencyAlerts ?? true,
                            emailNotifications: notif?.emailNotifications ?? true,
                            smsAlerts: notif?.smsAlerts ?? true,
                            onSave: ({
                              required pushNotifications,
                              required emergencyAlerts,
                              required emailNotifications,
                              required smsAlerts,
                            }) =>
                                context.read<ProfileCubit>().updateNotificationPreferences(
                                  pushNotifications: pushNotifications,
                                  emergencyAlerts: emergencyAlerts,
                                  emailNotifications: emailNotifications,
                                  smsAlerts: smsAlerts,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomSettingsTile(
                        icon: Icons.security_outlined,
                        title: appLocalization.securitySettings,
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => SecuritySettingsDialog(
                            onSave: ({
                              required currentPassword,
                              required newPassword,
                              required confirmPassword,
                            }) =>
                                context.read<ProfileCubit>().changePassword(
                                  currentPassword: currentPassword,
                                  newPassword: newPassword,
                                  confirmPassword: confirmPassword,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomSettingsTile(
                        icon: Icons.help_outline,
                        title: appLocalization.helpSupport,
                        onTap: () => Navigator.pushNamed(
                            context, RouteManger.helpAndSupportHospital),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                CustomProfileCard(
                  title: appLocalization.accountStatistics,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      CustomStatItem(
                        val: "${stats?.totalRequests ?? 47}",
                        label: appLocalization.totalRequests,
                        bg: const Color(0xFFEFF6FF),
                        color: Colors.blue,
                      ),
                      CustomStatItem(
                        val: "${stats?.fulfilled ?? 42}",
                        label: appLocalization.fulfilled,
                        bg: const Color(0xFFF0FDF4),
                        color: Colors.green,
                      ),
                      CustomStatItem(
                        val: "${stats?.active ?? 3}",
                        label: appLocalization.active,
                        bg: const Color(0xFFFFF7ED),
                        color: Colors.orange,
                      ),
                      CustomStatItem(
                        val: "${stats?.successRate ?? 89}%",
                        label: appLocalization.successRate,
                        bg: const Color(0xFFFAF5FF),
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                CustomProfileCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalization.total_daily_capacity,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (_) => WorkingHoursDialog(
                                initialOpeningHour: openingHour,
                                initialClosingHour: closingHour,
                                initialSlotsPerHour: slotsPerHour,
                                onSave: ({
                                  required openingHour,
                                  required closingHour,
                                  required slotsPerHour,
                                }) =>
                                    context.read<ProfileCubit>().updateWorkingHours(
                                      openingHour: openingHour,
                                      closingHour: closingHour,
                                      slotsPerHour: slotsPerHour,
                                    ),
                              ),
                            ),
                            icon: const Icon(Icons.settings_outlined, size: 16),
                            label: Text(appLocalization.manageButton),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      CapacityRow(
                        icon: Icons.calendar_today_outlined,
                        iconColor: Colors.blue,
                        bgColor: const Color(0xFFEFF6FF),
                        title: appLocalization.totalDailySlots,
                        subtitle: appLocalization.availableForScheduling,
                        value: totalDailySlots.toString(),
                        valueColor: Colors.blue,
                      ),
                      const SizedBox(height: 12),

                      CapacityRow(
                        icon: Icons.access_time_outlined,
                        iconColor: Colors.green,
                        bgColor: const Color(0xFFF0FDF4),
                        title: appLocalization.operating_hours,
                        subtitle: "${fmt(openingHour)} - ${fmt(closingHour)}",
                        value: "${hoursPerDay}h",
                        valueColor: Colors.green,
                      ),
                      const SizedBox(height: 12),

                      CapacityRow(
                        icon: Icons.schedule_outlined,
                        iconColor: Colors.purple,
                        bgColor: const Color(0xFFFAF5FF),
                        title: appLocalization.slots_per_hour,
                        subtitle: appLocalization.uniformAcrossAllHours,
                        value: slotsPerHour.toString(),
                        valueColor: Colors.purple,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                BlocListener<HospitalCubit, HospitalState>(
                  listener: (context, state) {
                    if (state is HospitalInitialState) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteManger.chooseRole,
                        (route) => false,
                      );
                    }
                  },
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final hospitalCubit = context.read<HospitalCubit>();
                      final fcmToken = await FirebaseNotificationService.getFCMToken();
                      if (context.mounted) {
                        hospitalCubit.logout(fcmToken: fcmToken);
                      }
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    child: Row(
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
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
