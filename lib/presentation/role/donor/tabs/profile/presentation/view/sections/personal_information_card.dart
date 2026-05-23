import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

import '../widgets/profile_info_tile.dart';

class PersonalInformationCard extends StatelessWidget {
  const PersonalInformationCard({super.key, required this.donor});
  final DonorModel donor;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: ColorManger.pureWhite,

        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),

            side: BorderSide(
              color: ColorManger.pureWhite.withValues(alpha: 0.4),
              width: 1,)
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: appLocalizations.personalInformation,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
              ),
              SizedBox(height: 16),
              ProfileInfoTile(
                icon: Icons.phone,
                label: appLocalizations.phone,
                value: donor.phoneNumber,
              ),
              SizedBox(height: 16),
              ProfileInfoTile(
                icon: Icons.email,
                label: appLocalizations.email,
                value: donor.email,
              ),
              SizedBox(height: 16),
              ProfileInfoTile(
                icon: Icons.location_on,
                label: appLocalizations.location,
                value: donor.location,
              ),
              SizedBox(height: 16),
              ProfileInfoTile(
                icon: Icons.person,
                label: appLocalizations.fullName,
                value: donor.name,
              ),
              SizedBox(height: 16),
              ProfileInfoTile(
                icon: Icons.bloodtype,
                label: appLocalizations.bloodType,
                value: donor.bloodType,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
