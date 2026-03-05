import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class QrWarningCard extends StatelessWidget {
  const QrWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManger.yellow, width: 1),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: ColorManger.orange,
              size: 20,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: CustomText(
                text: appLocalization.qr_expiry_warning,
                textStyle: TextStyle(
                  color: ColorManger.orange,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
