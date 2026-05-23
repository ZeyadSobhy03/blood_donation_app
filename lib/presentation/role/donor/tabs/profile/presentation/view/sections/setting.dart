import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/settings_tile.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isPushEnabled = true;
  bool isEmergencyEnabled = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    context.read<SettingCubit>().getSetting();
  }

  void _updateSetting({bool? push, bool? emergency}) {
    if (push != null) setState(() => isPushEnabled = push);
    if (emergency != null) setState(() => isEmergencyEnabled = emergency);

    context.read<SettingCubit>().updateSetting(
      pushNotifications: push ?? isPushEnabled,
      emergencyAlerts: emergency ?? isEmergencyEnabled,
      privacyMode: false,
      language: 'en',
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocConsumer<SettingCubit, SettingState>(

      listener: (context, state) {
        if (state is SettingSuccessState && !_initialized) {
          setState(() {
            isEmergencyEnabled =
                state.settingModel.data?.settings?.emergencyAlerts ?? false;
            isPushEnabled =
                state.settingModel.data?.settings?.pushNotifications ?? true;
            _initialized = true;
          });
        }

        if (state is SettingErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorManger.brightRed,
            ),
          );
        }
      },

      buildWhen: (previous, current) {
        if (current is SettingLoadingState && _initialized) return false;
        return true;
      },
      builder: (context, state) {
        if (state is SettingLoadingState && !_initialized) {
          return const CustomLoadingWidget();
        }

        if (state is SettingErrorState && !_initialized) {
          return Center(
            child: CustomText(
              text: state.error,
              textStyle: TextStyle(color: ColorManger.brightRed),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: ColorManger.pureWhite,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: ColorManger.pureWhite.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12,
              ),
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
                    onSwitchChanged: (value) => _updateSetting(push: value),
                  ),

                  const SizedBox(height: 8),

                  SettingsTile(
                    title: appLocalization.emergencyAlerts,
                    subtitle: appLocalization.emergencyAlertsDesc,
                    icon: Icons.warning_amber_rounded,
                    iconColor: ColorManger.brightRed,
                    isSwitch: true,
                    switchValue: isEmergencyEnabled,
                    onSwitchChanged: (value) =>
                        _updateSetting(emergency: value),
                  ),

                  SettingsTile(
                    title: appLocalization.privacyAndSecurity,
                    icon: Icons.shield_outlined,
                    iconColor: ColorManger.slateGrey,
                    isSwitch: false,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteManger.privacyAndSecurity,
                    ),
                  ),

                  SettingsTile(
                    title: appLocalization.helpAndSupport,
                    icon: Icons.help_outline,
                    iconColor: ColorManger.slateGrey,
                    isSwitch: false,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteManger.helpAndSupport,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}