import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/widgets/custom_toggle_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class NotificationPreferencesDialog extends StatefulWidget {
  const NotificationPreferencesDialog({super.key});

  @override
  State<NotificationPreferencesDialog> createState() =>
      _NotificationPreferencesDialogState();
}

class _NotificationPreferencesDialogState
    extends State<NotificationPreferencesDialog> {

  bool pushNotifications = true;
  bool emergencyAlerts = true;
  bool emailNotifications = true;
  bool smsAlerts = true;

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

            /// Header
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

            /// Push Notifications
            CustomToggleCard(
              title: loc.pushNotifications,
              subtitle: loc.receiveMobileNotifications,
              value: pushNotifications,
              onChanged: (val) => setState(() => pushNotifications = val),
            ),

            const SizedBox(height: 12),

            /// Emergency Alerts
            CustomToggleCard(
              title: loc.emergencyAlerts,
              subtitle: loc.criticalDonorResponses,
              value: emergencyAlerts,
              onChanged: (val) => setState(() => emergencyAlerts = val),
            ),

            const SizedBox(height: 12),

            /// Email Notifications
            CustomToggleCard(
              title: loc.emailNotifications,
              subtitle: loc.updatesViaEmail,
              value: emailNotifications,
              onChanged: (val) => setState(() => emailNotifications = val),
            ),

            const SizedBox(height: 12),

            /// SMS Alerts
            CustomToggleCard(
              title: loc.smsAlerts,
              subtitle: loc.textMessageUpdates,
              value: smsAlerts,
              onChanged: (val) => setState(() => smsAlerts = val),
            ),

            const SizedBox(height: 24),

            /// Save Button
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