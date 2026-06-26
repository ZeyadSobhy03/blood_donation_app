import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import 'control_button.dart';

class SystemControlCard extends StatelessWidget {
  const SystemControlCard({
    super.key,
    required this.isMaintenanceActive,
    required this.isLoading,
    this.onTapEnableMaintenanceMode,
    this.onTapDisableMaintenanceMode,
    this.onTapEmergencyShutdown,
  });

  final bool isMaintenanceActive;
  final bool isLoading;
  final VoidCallback? onTapEnableMaintenanceMode;
  final VoidCallback? onTapDisableMaintenanceMode;
  final VoidCallback? onTapEmergencyShutdown;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMaintenanceActive
            ? const Color(0xFFFEF5F5)
            : const Color(0xFFFFF7F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMaintenanceActive
              ? Colors.red.shade100
              : Colors.orange.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: isMaintenanceActive
                        ? Colors.red
                        : const Color(0xFFD35400),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appLocalization.systemControl,
                    style: TextStyle(
                      fontSize: 18,
                      color: isMaintenanceActive
                          ? Colors.red
                          : const Color(0xFFD35400),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isMaintenanceActive ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 12,
                          height: 12,

                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Center(
                          child: Text(
                            isMaintenanceActive
                                ? (appLocalization.statusOffline)
                                : (appLocalization.statusOnline),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (isMaintenanceActive)
            ControlButton(
              appLocalization.disableMaintenanceMode,
              Colors.green,
              false,
              onTap: onTapDisableMaintenanceMode,
            )
          else ...[
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
        ],
      ),
    );
  }
}
