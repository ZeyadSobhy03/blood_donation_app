import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class EmergencyRequestHeader extends StatelessWidget {
  const EmergencyRequestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(
          Icons.warning_amber_outlined,
          size: 28,
          color: ColorManger.brightRed,
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomText(
            text: appLocalizations.emergency_blood_request,
            maxLines: 2,
            textAlign: TextAlign.start,

            textStyle: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
              color: ColorManger.brightRed,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close, color: ColorManger.slateGrey),
        ),
      ],
    );
  }
}
