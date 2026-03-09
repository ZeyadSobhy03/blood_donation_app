import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/confirmation_data.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ConfirmationTile extends StatelessWidget {
  const ConfirmationTile({super.key, required this.confirmationData});

  final ConfirmationData confirmationData;

  String get _formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[confirmationData.date.month - 1]} ${confirmationData.date.day}, ${confirmationData.date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.lightGreen,
          border: Border.all(color: ColorManger.green, width: 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorManger.green.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: ColorManger.green,
                size: 28,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: confirmationData.hospitalName,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text:
                          '$_formattedDate  •  +${confirmationData.points} ${loc.points}',
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.award,
                size: 20,
                color: ColorManger.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
