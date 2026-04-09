import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/section/available_donor_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/section/request_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class ContactDonorDialog extends StatelessWidget {
  const ContactDonorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<DonorModel> donors = [
      DonorModel(
        donorRank: 4,
        id: '1',
        name: 'John Doe',
        email: 'john.doe@email.com',
        phoneNumber: '+201141935341',
        bloodType: 'A-',
        lastDonationDate: DateTime(2025, 10, 10),
        totalDonations: 5,
        points: 250,
        isEligibleToDonate: true,
        location: 'Nasr City, Cairo',
        isActive: true,
        isVerified: true,
        gender: 'Male',
        age: 28,
        weight: 75.0,
        healthStatus: 'Healthy',
        isBanned: false,
        isOnline: true,
        createdAt: DateTime(2024, 1, 10),
      ),

      DonorModel(
        donorRank: 5,
        id: '2',
        name: 'Jane Smith',
        email: 'jane.smith@email.com',
        phoneNumber: '0987654321',
        bloodType: 'O+',
        lastDonationDate: DateTime(2025, 11, 20),
        totalDonations: 8,
        points: 400,
        isEligibleToDonate: false,
        location: 'Heliopolis, Cairo',
        isActive: true,
        isVerified: true,
        gender: 'Female',
        age: 32,
        weight: 60.0,
        healthStatus: 'Recently donated',
        isBanned: false,
        isOnline: false,
        createdAt: DateTime(2023, 5, 15),
      ),

      DonorModel(
          donorRank: 3,
        id: '3',
        name: 'Alice Johnson',
        email: 'alice.j@email.com',
        phoneNumber: '5555555555',
        bloodType: 'B+',
        lastDonationDate: DateTime(2025, 9, 5),
        totalDonations: 3,
        points: 120,
        isEligibleToDonate: true,
        location: 'Maadi, Cairo',
        isActive: true,
        isVerified: false,
        gender: 'Female',
        age: 24,
        weight: 58.0,
        healthStatus: 'Healthy',
        isBanned: false,
        isOnline: true,
        createdAt: DateTime(2024, 3, 20),
      ),

      DonorModel(
        donorRank: 2,
        id: '4',
        name: 'Bob Brown',
        email: 'bob.brown@email.com',
        phoneNumber: '1111111111',
        bloodType: 'AB+',
        lastDonationDate: DateTime(2025, 12, 1),
        totalDonations: 10,
        points: 600,
        isEligibleToDonate: false,
        location: '6th of October, Giza',
        isActive: false,
        isVerified: true,
        gender: 'Male',
        age: 35,
        weight: 82.0,
        healthStatus: 'Low hemoglobin',
        isBanned: false,
        isOnline: false,
        createdAt: DateTime(2022, 8, 10),
      ),

      DonorModel(
        donorRank: 1,
        id: '5',
        name: 'Charlie Davis',
        email: 'charlie.d@email.com',
        phoneNumber: '2222222222',
        bloodType: 'O-',
        lastDonationDate: DateTime(2025, 8, 15),
        totalDonations: 15,
        points: 900,
        isEligibleToDonate: true,
        location: 'Sheikh Zayed, Giza',
        isActive: true,
        isVerified: true,
        gender: 'Male',
        age: 29,
        weight: 78.0,
        healthStatus: 'Excellent',
        isBanned: false,
        isOnline: true,
        createdAt: DateTime(2021, 12, 5),
      ),
    ];
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: ColorManger.pureWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RequestHeader(
                  title: appLocalizations.contact_donor,
                  subtitle: appLocalizations.contact_donor_desc,
                ),
                SizedBox(height: 16.h),
                RequestInfo(bloodType: 'A-', unitsNeeded: 2, urgency: 'High'),
                SizedBox(height: 16.h),
                CustomLabel(
                  text: appLocalizations.available_donors(donors.length),
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    final donor = donors[index];

                    return AvailableDonorCard(donors: donor);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: ColorManger.pureWhite,
                      foregroundColor: ColorManger.black,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: ColorManger.lightGrey.withValues(alpha: 0.5),
                        ),
                      ),
                      child: CustomText(text: appLocalizations.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
