import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class ConfirmDonationCard extends StatelessWidget {
  const ConfirmDonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: ColorManger.lightGreen,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.green, width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManger.green.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.qr_code, color: ColorManger.green),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appLocalization.confirm_donation_title,
                      textStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: appLocalization.confirm_donation_desc,
                      textStyle: TextStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomElevatedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: ColorManger.green,
                      foregroundColor: ColorManger.pureWhite,
                      onPressed: () {
                        Navigator.pushNamed(context, RouteManger.confirmDonation);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.qr_code_scanner, size: 16),
                          const SizedBox(width: 4),
                          CustomText(
                            text: appLocalization.scan_qr_code,
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManger.pureWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
