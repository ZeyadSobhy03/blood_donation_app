import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/qr_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';


class QrCodeCard extends StatelessWidget {
  const QrCodeCard({super.key, required this.qrToken});
  final String qrToken;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, color: ColorManger.brightRed),
                SizedBox(width: 4),
                CustomText(
                  text: appLocalization.donor_qr_card_title,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            QrCard(qrToken: qrToken),
            SizedBox(height: 16,),
              CustomText(
                text: appLocalization.donor_qr_card_subtitle,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
