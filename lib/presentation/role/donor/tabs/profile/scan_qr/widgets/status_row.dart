import 'package:blood_donation_app/core/resources/models/donation_details.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class StatusRow extends StatelessWidget {
  const StatusRow({super.key, required this.donation});

  final DonationDetails donation;

  Color get statusColor {
    switch (donation.status) {
      case DonationStatus.pending:
        return ColorManger.orange;
      case DonationStatus.confirmed:
        return ColorManger.green;
      case DonationStatus.cancelled:
        return ColorManger.primaryRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    String statusText;
    switch (donation.status) {
      case DonationStatus.pending:
        statusText = loc.pending;
        break;
      case DonationStatus.confirmed:
        statusText = loc.confirmed;
        break;
      case DonationStatus.cancelled:
        statusText = loc.cancelled;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: loc.statusLabel,
          textStyle: TextStyle(
            fontSize: FontSize.s13,
            color: ColorManger.grey600,
          ),
        ),
        CustomText(
          text: statusText,
          textStyle: TextStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.semiBold,
            color: statusColor,
          ),
        ),
      ],
    );
  }
}
