import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view_model/donation_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../core/utils/status_utils.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../donation_history/data/model/donation_history_model.dart';
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Skeletonizer(
              enabled: true,
              child: Center(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          );
        }

        List<Donations> donationHistory = [];
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
      List<Donations> donationHistory,
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

                  final hospitalName = _getHospitalName(donation, appLocation);
                  final bloodType = _getBloodType(donation, appLocation);
                  final date = _getDate(donation, appLocation);

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

  String _getHospitalName(Donations donation, AppLocalizations appLocation) {
    // Try to get from hospitalName first
    if (donation.hospitalName != null && donation.hospitalName is String) {
      return donation.hospitalName as String;
    }

    // Try to get from requestId -> hospitalId -> hospitalName
    if (donation.requestId != null &&
        donation.requestId!.hospitalId != null &&
        donation.requestId!.hospitalId!.hospitalName != null) {
      return donation.requestId!.hospitalId!.hospitalName!;
    }

    // Fallback
    return appLocation.hospital ?? 'Hospital';
  }

  String _getBloodType(Donations donation, AppLocalizations appLocation) {
    // Try to get from requestId -> bloodType (it's a List<String>)
    if (donation.requestId != null &&
        donation.requestId!.bloodType != null &&
        donation.requestId!.bloodType!.isNotEmpty) {
      return donation.requestId!.bloodType!.join(', ');
    }

    // Fallback
    return appLocation.unknown ?? 'Unknown';
  }

  String _getDate(Donations donation, AppLocalizations appLocation) {
    if (donation.createdAt != null && donation.createdAt!.isNotEmpty) {
      try {
        return donation.createdAt!.substring(0, 10);
      } catch (e) {
        return appLocation.unknown ?? 'Unknown';
      }
    }

    return appLocation.unknown ?? 'Unknown';
  }
}