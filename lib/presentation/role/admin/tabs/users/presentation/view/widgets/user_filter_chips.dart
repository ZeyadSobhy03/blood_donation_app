import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserFilterChips extends StatelessWidget {
  final List<String> roles;
  final String selectedRole;
  final ValueChanged<String> onRoleSelected;
  final String Function(String role)? roleLabelBuilder;

  const UserFilterChips({
    super.key,
    required this.roles,
    required this.selectedRole,
    required this.onRoleSelected,
    this.roleLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: roles.map((role) {
          final isSelected = selectedRole == role;
          final displayText = roleLabelBuilder?.call(role) ?? role;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: CustomText(text: displayText),
              selected: isSelected,
              onSelected: (_) => onRoleSelected(role),
              selectedColor: ColorManger.brightRed.withValues(alpha: 0.12),
              checkmarkColor: ColorManger.brightRed,
              labelStyle: TextStyle(
                color: isSelected
                    ? ColorManger.brightRed
                    : ColorManger.slateGrey,
                fontWeight: isSelected
                    ? FontWeightManager.semiBold
                    : FontWeightManager.regular,
                fontSize: FontSize.s14,
              ),
              side: BorderSide(
                color: isSelected ? ColorManger.brightRed : ColorManger.grey100,
              ),
              backgroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
