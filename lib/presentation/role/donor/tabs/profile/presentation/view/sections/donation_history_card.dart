import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view_model/donation_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../core/utils/status_utils.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../widgets/donation_record_tile.dart';

class DonationHistoryCard extends StatelessWidget {
  const DonationHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocation = AppLocalizations.of(context)!;

    return BlocBuilder<DonationHistoryCubit, DonationHistoryState>(
      builder: (context, state) {
        if (state is DonationHistoryLoading ||
            state is DonationHistoryInitial) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        List<dynamic> donationHistory = [];
        if (state is DonationHistoryLoaded) {
          donationHistory =
              (state.donationHistory.data?.donations ?? []).take(2).toList();
        }

        return _buildDonationCard(context, donationHistory, appLocation);
      },
    );
  }

  Widget _buildDonationCard(
      BuildContext context,
      List<dynamic> donationHistory,
      AppLocalizations appLocation,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Card(
        color: ColorManger.pureWhite,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: ColorManger.pureWhite.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteManger.donationHistory);
                    },
                    child: CustomText(
                      text: appLocation.viewAll,
                      textStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.brightRed,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              donationHistory.isEmpty
                  ? CustomText(
                text: appLocation.no_donations_found,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  color: ColorManger.grey500,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: donationHistory.length,
                itemBuilder: (context, index) {
                  final donation = donationHistory[index];
                  final String rawStatus = donation.status ?? 'pending';
                  final hospitalName =
                  donation.requestId?.hospitalId is Map
                      ? donation.requestId
                      ?.hospitalId['hospitalName'] ??
                      appLocation.hospital
                      : appLocation.hospital;
                  final bloodType =
                      donation.requestId?.bloodType ?? appLocation.unknown;
                  final date = donation.createdAt != null
                      ? donation.createdAt!.substring(0, 10)
                      : appLocation.unknown;

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
                    donationType: bloodType,
                    stausTextColor: statusTextColor(rawStatus),
                    hospitalName: hospitalName,
                    date: date,
                    status: localizeStatus(rawStatus, appLocation),
                    statusColor: statusBackgroundColor(rawStatus),
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