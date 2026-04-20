import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/audit_logs_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/clickable_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/role_based_permission_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/section_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/switch_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/system_control_card.dart';
import 'package:flutter/material.dart';

class SystemSettings extends StatelessWidget {
  const SystemSettings({super.key});

  // ------ Dialogs ------

  void showPermissionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const RoleBasedPermissionsDialog(),
    );
  }

  void showAuditLogsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AuditLogsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "System Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Configure System Preferences",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: 'Notification Settings',
            icon: Icons.notifications_none,
            children: [
              SwitchTile('Emergency Alerts', 'Critical blood shortage notifications', true),
              SwitchTile('AI Predictions', 'Machine learning demand forecasts', true),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Security Settings',
            icon: Icons.security,
            children: [
              ClickableTile(
                icon: Icons.shield_outlined,
                label: 'Role-Based Permissions',
                onTap: () => showPermissionsDialog(context),
              ),
              ClickableTile(
                icon: Icons.storage,
                label: 'View Audit Logs',
                onTap: () => showAuditLogsDialog(context),
              ),
              const Divider(),
              SwitchTile('Two-Factor Authentication', 'Required for all admin accounts', true),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'GPS & Location',
            icon: Icons.location_on_outlined,
            children: [
              ClickableTile(label: 'Configure Search Radius', onTap: () {}),
              ClickableTile(label: 'Location Accuracy Settings', onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'System Health',
            icon: Icons.health_and_safety,
            children: [
              ClickableTile(icon: Icons.refresh, label: 'System Health Check', onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          SystemControlCard(),
        ],
      ),
    );
  }
}