import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/resources/models/donation_history.dart';
import '../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../widgets/donation_record_tile.dart';

class DonationHistoryCard extends StatelessWidget {
  const DonationHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocation=AppLocalizations.of(context)!;


    List<DonationHistoryModel> donationHistory = [
      DonationHistoryModel(
        points: 20,
        donationType: appLocation.blood,
        hospitalName: 'ABC Hospital',
        date: '2023-07-15',
        status: appLocation.completed,
      ),
      DonationHistoryModel(
        points: 30,
        donationType: 'Plasma',
        hospitalName: 'XYZ Hospital',
        date: '2023-07-10',
        status: appLocation.completed,
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
              Row(
                children: [
                  CustomText(
                    text: appLocation.donationHistory,
                    textStyle: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RouteManger.donationHistory);
                    },
                    child: CustomText(text: appLocation.viewAll, textStyle: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.brightRed,
                    ),),
                  )
                ],
              ),

              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: donationHistory.length,
                itemBuilder: (context, index) {
                  final donation = donationHistory[index];
                  return DonationRecordTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: ColorManger.lightRed,
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: ColorManger.brightRed,
                        size: 24,
                      ),
                    ),
                    donationType: donation.donationType,
                    hospitalName: donation.hospitalName,
                    date: donation.date,
                    status: donation.status,
                    statusColor: donation.status == 'Completed'
                        ? ColorManger.lightGreen
                        : ColorManger.lightRed,
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
