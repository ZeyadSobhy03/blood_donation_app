import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
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

import '../../../../../l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _openingHour = 8;
  int _closingHour = 19;
  int _slotsPerHour = 8;

  int get _hoursPerDay =>
      _closingHour > _openingHour ? _closingHour - _openingHour : 0;
  int get _totalDailySlots => _hoursPerDay * _slotsPerHour;

  String _fmt(int h) => '${h.toString().padLeft(2, '0')}:00';

  void _openManageDialog() {
    showDialog(
      context: context,
      builder: (_) => WorkingHoursDialog(
        initialOpeningHour: _openingHour,
        initialClosingHour: _closingHour,
        initialSlotsPerHour: _slotsPerHour,
        onSave: (opening, closing, slots) => setState(() {
          _openingHour = opening;
          _closingHour = closing;
          _slotsPerHour = slots;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

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
                        const Text(
                          "Metro General Hospital",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          appLocalization.emergencyDepartment,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const EditHospitalProfileDialog(),
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
                    text: "+1 (555) 987-6543",
                  ),
                  CustomContactRow(
                    icon: Icons.email_outlined,
                    text: "emergency@metrohealth.com",
                  ),
                  CustomContactRow(
                    icon: Icons.location_on_outlined,
                    text: "123 Medical Center Dr, City",
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
                    initialOpeningHour: _openingHour,
                    initialClosingHour: _closingHour,
                    initialSlotsPerHour: _slotsPerHour,
                    onSave: (opening, closing, slots) => setState(() {
                      _openingHour = opening;
                      _closingHour = closing;
                      _slotsPerHour = slots;
                    }),
                  ),
                ),
              ),
                  const SizedBox(height: 12),

                  CustomSettingsTile(
                    icon: Icons.notifications_none,
                    title: appLocalization.notificationPreferences,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => const NotificationPreferencesDialog(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomSettingsTile(
                    icon: Icons.security_outlined,
                    title: appLocalization.securitySettings,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => const SecuritySettingsDialog(),
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
                    val: "47",
                    label: appLocalization.totalRequests,
                    bg: const Color(0xFFEFF6FF),
                    color: Colors.blue,
                  ),
                  CustomStatItem(
                    val: "42",
                    label: appLocalization.fulfilled,
                    bg: const Color(0xFFF0FDF4),
                    color: Colors.green,
                  ),
                  CustomStatItem(
                    val: "3",
                    label: appLocalization.active,
                    bg: const Color(0xFFFFF7ED),
                    color: Colors.orange,
                  ),
                  CustomStatItem(
                    val: "89%",
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
                        onPressed: _openManageDialog,
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
                    value: _totalDailySlots.toString(),
                    valueColor: Colors.blue,
                  ),
                  const SizedBox(height: 12),

                  CapacityRow(
                    icon: Icons.access_time_outlined,
                    iconColor: Colors.green,
                    bgColor: const Color(0xFFF0FDF4),
                    title: appLocalization.operating_hours,
                    subtitle: "${_fmt(_openingHour)} - ${_fmt(_closingHour)}",
                    value: "${_hoursPerDay}h",
                    valueColor: Colors.green,
                  ),
                  const SizedBox(height: 12),

                  CapacityRow(
                    icon: Icons.schedule_outlined,
                    iconColor: Colors.purple,
                    bgColor: const Color(0xFFFAF5FF),
                    title: appLocalization.slots_per_hour,
                    subtitle: appLocalization.uniformAcrossAllHours,
                    value: _slotsPerHour.toString(),
                    valueColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
