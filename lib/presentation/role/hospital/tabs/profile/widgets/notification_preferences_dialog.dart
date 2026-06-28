import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_toggle_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class NotificationPreferencesDialog extends StatefulWidget {
  final bool pushNotifications;
  final bool emergencyAlerts;
  final bool emailNotifications;
  final bool smsAlerts;
  final void Function({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  }) onSave;

  const NotificationPreferencesDialog({
    super.key,
    required this.pushNotifications,
    required this.emergencyAlerts,
    required this.emailNotifications,
    required this.smsAlerts,
    required this.onSave,
  });

  @override
  State<NotificationPreferencesDialog> createState() =>
      _NotificationPreferencesDialogState();
}

class _NotificationPreferencesDialogState
    extends State<NotificationPreferencesDialog> {
  late bool pushNotifications;
  late bool emergencyAlerts;
  late bool emailNotifications;
  late bool smsAlerts;

  @override
  void initState() {
    super.initState();
    pushNotifications = widget.pushNotifications;
    emergencyAlerts = widget.emergencyAlerts;
    emailNotifications = widget.emailNotifications;
    smsAlerts = widget.smsAlerts;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    loc.notificationPreferences,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomToggleCard(
              title: loc.pushNotifications,
              subtitle: loc.receiveMobileNotifications,
              value: pushNotifications,
              onChanged: (val) => setState(() => pushNotifications = val),
            ),
            const SizedBox(height: 12),
            CustomToggleCard(
              title: loc.emergencyAlerts,
              subtitle: loc.criticalDonorResponses,
              value: emergencyAlerts,
              onChanged: (val) => setState(() => emergencyAlerts = val),
            ),
            const SizedBox(height: 12),
            CustomToggleCard(
              title: loc.emailNotifications,
              subtitle: loc.updatesViaEmail,
              value: emailNotifications,
              onChanged: (val) => setState(() => emailNotifications = val),
            ),
            const SizedBox(height: 12),
            CustomToggleCard(
              title: loc.smsAlerts,
              subtitle: loc.textMessageUpdates,
              value: smsAlerts,
              onChanged: (val) => setState(() => smsAlerts = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  widget.onSave(
                    pushNotifications: pushNotifications,
                    emergencyAlerts: emergencyAlerts,
                    emailNotifications: emailNotifications,
                    smsAlerts: smsAlerts,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  loc.savePreferences,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
