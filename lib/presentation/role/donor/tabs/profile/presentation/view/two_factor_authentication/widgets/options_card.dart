import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tiles/two_fa_method_tile.dart';

class OptionsCard extends StatelessWidget {
  final bool isSmsEnabled;
  final bool isAuthAppEnabled;
  final bool isEmailEnabled;
  final void Function(String method, bool value) onToggle;

  const OptionsCard({
    super.key,
    required this.isSmsEnabled,
    required this.isAuthAppEnabled,
    required this.isEmailEnabled,
    required this.onToggle,
  });

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 64.w,
      endIndent: 16.w,
      color: ColorManger.lightGreenBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      elevation: 4,
      shadowColor: ColorManger.black.withValues(alpha: 0.08),
      color: ColorManger.pureWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Column(
          children: [
            TwoFAMethodTile(
              icon: Icons.sms_outlined,
              iconColor: ColorManger.skyBlue,
              iconBg: ColorManger.infoIconBackground,
              title: appLocalization.smsVerification,
              subtitle: appLocalization.smsVerificationDescription,
              value: isSmsEnabled,
              onChanged: (v) => onToggle('sms', v),
            ),
            _buildDivider(),
            TwoFAMethodTile(
              icon: Icons.apps_outlined,
              iconColor: ColorManger.successColor,
              iconBg: ColorManger.successBackground,
              title: appLocalization.authenticatorApp,
              subtitle: appLocalization.authenticatorAppDescription,
              value: isAuthAppEnabled,
              onChanged: (v) => onToggle('app', v),
            ),
            _buildDivider(),
            TwoFAMethodTile(
              icon: Icons.email_outlined,
              iconColor: ColorManger.warningIcon,
              iconBg: ColorManger.warningBackground,
              title: appLocalization.emailVerification,
              subtitle: appLocalization.emailVerificationDescription,
              value: isEmailEnabled,

              onChanged: (v) => onToggle('email', v),
            ),
          ],
        ),
      ),
    );
  }
}