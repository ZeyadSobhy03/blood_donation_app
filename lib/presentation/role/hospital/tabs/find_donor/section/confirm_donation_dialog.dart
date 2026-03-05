import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';

import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/confirm_navigation.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/qr_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/qr_warning_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_donor_header.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import '../../../../../../l10n/app_localizations.dart';

class ConfirmDonationDialog extends StatefulWidget {
  const ConfirmDonationDialog({super.key, required this.donor});

  final DonorModel donor;

  @override
  State<ConfirmDonationDialog> createState() => _ConfirmDonationDialogState();
}

class _ConfirmDonationDialogState extends State<ConfirmDonationDialog> {
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      elevation: 4,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RequestHeader(
                  title: appLocalization.generate_donation_qr,
                  subtitle: appLocalization.qr_valid_message,
                ),

                const SizedBox(height: 16),
                ContactDonorHeader(
                  name: widget.donor.name,
                  bloodType: widget.donor.bloodType,
                  location: widget.donor.location,
                ),
                const SizedBox(height: 16),
                QrCard(donorId: widget.donor.id),
                SizedBox(height: 16),
                QrWarningCard(),
                SizedBox(height: 16),
                ConfirmNavigation(close: () => Navigator.pop(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
