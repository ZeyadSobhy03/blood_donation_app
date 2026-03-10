import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_contact_row.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_profile_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_stat_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/edit_profile_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/notification_preferences_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/security_settings_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_settings_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              loc.hospitalProfile,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              loc.manageHospitalInformation,
              style: TextStyle(color: Colors.grey[600]),
            ),

            const SizedBox(height: 24),

            /// Hospital Card
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
                          loc.emergencyDepartment,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                        const EditHospitalProfileDialog(),
                      );
                    },

                    icon: const Icon(Icons.edit_outlined, size: 18),

                    label: Text(loc.edit),

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

            /// Contact Information
            CustomProfileCard(
              title: loc.contactInformation,

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

            /// Settings
            CustomProfileCard(
              title: loc.settings,

              child: Column(
                children: [

                  CustomSettingsTile(
                    icon: Icons.notifications_none,
                    title: loc.notificationPreferences,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                        const NotificationPreferencesDialog(),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  CustomSettingsTile(
                    icon: Icons.security_outlined,
                    title: loc.securitySettings,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                        const SecuritySettingsDialog(),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  CustomSettingsTile(
                    icon: Icons.help_outline,
                    title: loc.helpSupport,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Statistics
            CustomProfileCard(
              title: loc.accountStatistics,

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
                    label: loc.totalRequests,
                    bg: const Color(0xFFEFF6FF),
                    color: Colors.blue,
                  ),

                  CustomStatItem(
                    val: "42",
                    label: loc.fulfilled,
                    bg: const Color(0xFFF0FDF4),
                    color: Colors.green,
                  ),

                  CustomStatItem(
                    val: "3",
                    label: loc.active,
                    bg: const Color(0xFFFFF7ED),
                    color: Colors.orange,
                  ),

                  CustomStatItem(
                    val: "89%",
                    label: loc.successRate,
                    bg: const Color(0xFFFAF5FF),
                    color: Colors.purple,
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