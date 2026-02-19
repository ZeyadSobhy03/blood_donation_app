import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isPushEnabled = true;
  bool isEmergencyEnabled = false;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: ColorManger.pureWhite,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),

        side: BorderSide(
          color: ColorManger.pureWhite.withValues(alpha: 0.4),
          width: 1,)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: appLocalization.settings,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
              ),

              const SizedBox(height: 16),

              SettingsTile(
                title: appLocalization.pushNotifications,
                subtitle: appLocalization.pushNotificationsDesc,
                icon: Icons.notifications_none,
                iconColor: ColorManger.slateGrey.withValues(alpha: 0.8),

                isSwitch: true,
                switchValue: isPushEnabled,
                onSwitchChanged: (value) {
                  setState(() {
                    isPushEnabled = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              SettingsTile(
                title: appLocalization.emergencyAlerts,
                subtitle: appLocalization.emergencyAlertsDesc,
                icon: Icons.warning_amber_rounded,
                iconColor: ColorManger.brightRed,
                isSwitch: true,
                switchValue: isEmergencyEnabled,
                onSwitchChanged: (value) {
                  setState(() {
                    isEmergencyEnabled = value;
                  });
                },
              ),

              SettingsTile(
                title: appLocalization.privacyAndSecurity,

                icon: Icons.shield_outlined,
                iconColor: ColorManger.slateGrey,
                isSwitch: false,
                onTap: () {
                  Navigator.pushNamed(context, RouteManger.privacyAndSecurity);
                },
              ),

              SettingsTile(
                title: appLocalization.helpAndSupport,
                icon: Icons.help_outline,
                iconColor: ColorManger.slateGrey,
                isSwitch: false,
                onTap: () {
                  Navigator.pushNamed(context, RouteManger.helpAndSupport);
                  // navigate
                },
              ),

              // SettingsTile(
              //   title: appLocalization.accountSettings,
              //   icon: Icons.settings_outlined,
              //   iconColor: ColorManger.slateGrey,
              //   isSwitch: false,
              //   onTap: () {
              //     Navigator.pushNamed(context, RouteManger.accountSettings);
              //
              //     // navigate
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
