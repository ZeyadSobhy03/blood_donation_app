import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSwitch;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor = Colors.blueGrey,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: isSwitch ? null : onTap,
      leading: Icon(icon, color: iconColor, size: 22),
      title: CustomText(
        text: title,
        textStyle: TextStyle(
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s16,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : CustomText(
              text: subtitle!,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s13,
              ),
            ),
      trailing: isSwitch
          ? Switch(value: switchValue, onChanged: onSwitchChanged)
          : Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ColorManger.slateGrey,
            ),
    );
  }
}
