import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool val;
  final void Function(bool)? onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.val,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: SwitchListTile(
        value: val,
        onChanged: onChanged,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: ColorManger.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: ColorManger.grey500,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        activeThumbColor: ColorManger.pureWhite,
        activeTrackColor: ColorManger.green,
        inactiveThumbColor: ColorManger.grey400,
        inactiveTrackColor: ColorManger.grey300,
        contentPadding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
