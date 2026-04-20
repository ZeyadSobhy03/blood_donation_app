import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/permission_group.dart';
import 'package:flutter/material.dart';

class RoleBasedPermissionsDialog extends StatelessWidget {
  const RoleBasedPermissionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text('Role-Based Permissions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Text('Configure access levels for different user roles.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            PermissionGroup('Admin Permissions', ['User Management', 'System Settings', 'Emergency Broadcasts']),
            PermissionGroup('Hospital Permissions', ['Create Requests', 'Generate QR Codes', 'View Analytics']),
            PermissionGroup('Donor Permissions', ['View Requests', 'Respond to Alerts', 'Earn Rewards']),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA855F7)),
                  child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}