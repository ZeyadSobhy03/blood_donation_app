import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_button.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_donor_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/donor_avatar.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/status_badge.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class FindNearbyDonorsCard extends StatelessWidget {
  const FindNearbyDonorsCard({super.key, required this.donor});

  final DonorModel donor;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorManger.brightRed,
                      ColorManger.brightRed.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DonorAvatar(bloodType: donor.bloodType),
                  const SizedBox(width: 14),

                  // Info column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: donor.name,
                          textStyle: TextStyle(
                            fontSize: FontSize.s15,
                            color: ColorManger.black,
                            fontWeight: FontWeightManager.bold,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: ColorManger.slateGrey.withValues(
                                alpha: 0.7,
                              ),
                              size: 13,
                            ),
                            const SizedBox(width: 3),
                            CustomText(
                              text: donor.location,
                              textStyle: TextStyle(
                                fontSize: FontSize.s12,
                                color: ColorManger.slateGrey,
                                fontWeight: FontWeightManager.regular,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Status badge
                        StatusBadge(
                          isActive: donor.isActive,
                          activeLabel: appLocalization.available,
                          inactiveLabel: appLocalization.inactive,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  ContactButton(
                    label: appLocalization.contact,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ContactDonorDialog(donor: donor),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
