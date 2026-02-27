import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_donor_body.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_donor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class ContactDonorDialog extends StatelessWidget {
  const ContactDonorDialog({super.key, required this.donor});

  final DonorModel donor;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: appLocalization.contact_donor,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                SizedBox(height: 16.h),
                ContactDonorHeader(name: donor.name, bloodType: donor.bloodType, location: donor.location),
                SizedBox(height: 20.h),
                ContactDonorBody(
                  donor: donor,
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
