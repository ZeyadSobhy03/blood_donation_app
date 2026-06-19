import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import 'control_button.dart';


class SystemControlCard extends StatelessWidget {
  const SystemControlCard({
    super.key,
    this.onTapEnableMaintenanceMode,
    this.onTapEmergencyShutdown,
  });

  final VoidCallback? onTapEnableMaintenanceMode;
  final VoidCallback? onTapEmergencyShutdown;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
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
            children: [
              const Icon(Icons.power_settings_new, color: Color(0xFFD35400)),
              const SizedBox(width: 8),
              Text(
                appLocalization.systemControl,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFD35400),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ControlButton(
            appLocalization.enableMaintenanceMode,
            const Color(0xFFD35400),
            false,
            onTap: onTapEnableMaintenanceMode,
          ),
          const SizedBox(height: 8),
          ControlButton(
            appLocalization.emergencyShutdown,
            Colors.red,
            true,
            onTap: onTapEmergencyShutdown,
          ),
        ],
      ),
    );
  }
}
