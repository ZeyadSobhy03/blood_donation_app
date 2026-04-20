import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/control_button.dart';
import 'package:flutter/material.dart';

class SystemControlCard extends StatelessWidget {
  const SystemControlCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.power_settings_new, color: Color(0xFFD35400)),
              SizedBox(width: 8),
              Text('System Control', style: TextStyle(fontSize: 18, color: Color(0xFFD35400), fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          ControlButton('Enable Maintenance Mode', const Color(0xFFD35400), false),
          const SizedBox(height: 8),
          ControlButton('Emergency Shutdown', Colors.red, true),
        ],
      ),
    );
  }
}
