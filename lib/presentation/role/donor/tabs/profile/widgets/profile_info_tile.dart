import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorManger.lightGrey,
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  textStyle: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.slateGrey,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: value,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManger.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
