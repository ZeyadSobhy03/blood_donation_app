import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/show_all_donors_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/donor_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class TopDonorsCard extends StatelessWidget {
  const TopDonorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final List<DonorModel> donors = [
      DonorModel(
        id: '1',
        name: "Ahmed Mohamed",
        email: "ahmed@gmail.com",
        phoneNumber: "01012345678",
        bloodType: "O+",
        totalDonations: 12,
        points: 240,
        isEligibleToDonate: true,
        location: "Cairo",
        isActive: true,
        isVerified: true,
        gender: "Male",
        age: 25,
        weight: 75,
        healthStatus: "Good",
        isBanned: false,
        isOnline: true,
        createdAt: DateTime(2023, 5, 10),
        donorRank: 1,
      ),

      DonorModel(
        id: '2',
        name: "Sara Ali",
        email: "sara@gmail.com",
        phoneNumber: "01198765432",
        bloodType: "A-",
        totalDonations: 5,
        points: 100,
        isEligibleToDonate: true,
        location: "Alexandria",
        isActive: true,
        isVerified: true,
        gender: "Female",
        age: 22,
        weight: 60,
        healthStatus: "Excellent",
        isBanned: false,
        isOnline: false,
        createdAt: DateTime(2024, 1, 15),
        donorRank: 2,
      ),

      DonorModel(
        id: '3',
        name: "Omar Hassan",
        email: "omar@gmail.com",
        phoneNumber: "01222222222",
        bloodType: "B+",
        totalDonations: 20,
        points: 400,
        isEligibleToDonate: false,
        location: "Giza",
        isActive: true,
        isVerified: true,
        gender: "Male",
        age: 30,
        weight: 85,
        healthStatus: "Average",
        isBanned: false,
        isOnline: true,
        createdAt: DateTime(2022, 8, 3),
        donorRank: 3,
      ),

      DonorModel(
        id: '4',
        name: "Mona Adel",
        email: "mona@gmail.com",
        phoneNumber: "01055555555",
        bloodType: "AB+",
        totalDonations: 2,
        points: 40,
        isEligibleToDonate: true,
        location: "Mansoura",
        isActive: true,
        isVerified: false,
        gender: "Female",
        age: 28,
        weight: 65,
        healthStatus: "Good",
        isBanned: false,
        isOnline: false,
        createdAt: DateTime(2024, 6, 20),
        donorRank: 4,
      ),

      DonorModel(
        id: '5',
        name: "Youssef Tarek",
        email: "youssef@gmail.com",
        phoneNumber: "01544444444",
        bloodType: "O-",
        totalDonations: 15,
        points: 300,
        isEligibleToDonate: false,
        location: "Tanta",
        isActive: false,
        isVerified: true,
        gender: "Male",
        age: 27,
        weight: 78,
        healthStatus: "Good",
        isBanned: true,
        isOnline: false,
        createdAt: DateTime(2021, 11, 11),
        donorRank: 5,
      ),
    ];
    return Card(
      color: ColorManger.pureWhite,
      shadowColor: Colors.black.withValues(alpha: 0.06),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: ColorManger.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: appLocalization.top_donors_in_month,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.black,
                  ),
                ),
                CustomElevatedButton(
                  backgroundColor: ColorManger.pureWhite,
                  foregroundColor: ColorManger.black,
                  elevation: 0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ShowAllDonorsDialog();
                      },
                    );
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ColorManger.slateGrey.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                  ),
                  child: CustomText(
                    text: appLocalization.viewAll,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      color: ColorManger.black,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ...donors
                .take(4)
                .map(
                  (donor) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: DonorTile(
                      donor: donor,
                      showLastDonation: false,
                      showActivityStatus: false,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
