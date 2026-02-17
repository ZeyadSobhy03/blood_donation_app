import 'package:blood_donation_app/core/resources/models/donation_history.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/sections/donation_stats_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/widgets/history_header.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/widgets/donation_record_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/colors/color_manger.dart';
import '../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../core/widgets/custom_text.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    final List<DonationHistoryModel> donationHistoryModel = [
      DonationHistoryModel(
        donationType: "Blood Donation",
        hospitalName: "Al Salam Hospital",
        date: "2026-01-10",
        status: "Completed",
        points: 5,
      ),
      DonationHistoryModel(
        donationType: "Plasma Donation",
        hospitalName: "Cairo Medical Center",
        date: "2026-01-12",
        status: "Completed",
        points: 6,
      ),
      DonationHistoryModel(
        donationType: "Blood Donation",
        hospitalName: "Nile Hospital",
        date: "2026-01-15",
        status: "Pending",
        points: 5,
      ),
      DonationHistoryModel(
        donationType: "Platelets Donation",
        hospitalName: "Al Noor Hospital",
        date: "2026-01-18",
        status: "Completed",
        points: 7,
      ),
      DonationHistoryModel(
        donationType: "Blood Donation",
        hospitalName: "Cairo Medical Center",
        date: "2026-01-20",
        status: "Cancelled",
        points: 0,
      ),
      DonationHistoryModel(
        donationType: "Plasma Donation",
        hospitalName: "Al Salam Hospital",
        date: "2026-01-22",
        status: "Completed",
        points: 6,
      ),
      DonationHistoryModel(
        donationType: "Blood Donation",
        hospitalName: "Nile Hospital",
        date: "2026-01-25",
        status: "Completed",
        points: 5,
      ),
      DonationHistoryModel(
        donationType: "Platelets Donation",
        hospitalName: "Al Noor Hospital",
        date: "2026-01-28",
        status: "Pending",
        points: 7,
      ),
      DonationHistoryModel(
        donationType: "Blood Donation",
        hospitalName: "Cairo Medical Center",
        date: "2026-02-01",
        status: "Completed",
        points: 5,
      ),
      DonationHistoryModel(
        donationType: "Plasma Donation",
        hospitalName: "Al Salam Hospital",
        date: "2026-02-05",
        status: "Completed",
        points: 6,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: ColorManger.brightRed,
                width: double.infinity,

                child: Column(
                  children: [
                    HistoryHeader(totalDonations: 12),
                    SizedBox(height: 16),
                    DonationStatsCard(),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                itemCount: donationHistoryModel.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final donation = donationHistoryModel[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DonationRecordTile(
                      donationType: donation.donationType,
                      hospitalName: donation.hospitalName,
                      date: donation.date,
                      status: donation.status,
                      statusColor: ColorManger.lightGreen,
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorManger.lightRed,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: ColorManger.brightRed,
                          size: 24,
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: ColorManger.lightYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: CustomText(
                            text: ' ${donation.points} ${appLocalization.points}',
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManger.yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
