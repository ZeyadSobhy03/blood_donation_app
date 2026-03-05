import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class ConfirmDonationDialog extends StatelessWidget {
  const ConfirmDonationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: ColorManger.pureWhite,
      elevation: 4,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RequestHeader(
                  title: appLocalization.generate_donation_qr,
                  subtitle: appLocalization.qr_valid_message,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
