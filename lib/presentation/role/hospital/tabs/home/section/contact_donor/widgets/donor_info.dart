import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class DonorInfo extends StatelessWidget {
  const DonorInfo({super.key, required this.name, required this.bloodType});
  final String name;
  final String bloodType;


  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: 4),
        CustomText(
          text:
          '${appLocalization.blood_type} $bloodType',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textStyle: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
