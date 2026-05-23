import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/utils/status_utils.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view/sections/donation_stats_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view/widgets/history_header.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view_model/donation_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../profile/presentation/view/widgets/donation_record_tile.dart';

class DonationHistory extends StatefulWidget {
  const DonationHistory({super.key});

  @override
  State<DonationHistory> createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  @override
  void initState() {
    super.initState();
    context.read<DonationHistoryCubit>().getDonationHistory();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<DonationHistoryCubit, DonationHistoryState>(
          builder: (context, state) {
            if (state is DonationHistoryError) {
              return CustomErrorWidget(
                message: localizeError(state.message, appLocalization),
                onRetry: () =>
                    context.read<DonationHistoryCubit>().getDonationHistory(),
              );
            }

            final isLoading = state is DonationHistoryLoading;
            final donations = state is DonationHistoryLoaded
                ? state.donationHistory.data?.donations ?? []
                : [];
            final totalDonations = state is DonationHistoryLoaded
                ? state.donationHistory.data?.pagination?.total ?? 0
                : 0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: ColorManger.brightRed,
                    width: double.infinity,
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: Column(
                        children: [
                          HistoryHeader(totalDonations: totalDonations),
                          const SizedBox(height: 16),
                          const DonationStatsCard(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Skeletonizer(
                    enabled: isLoading,
                    child: donations.isEmpty && !isLoading
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: CustomText(
                          text: appLocalization.noDonationsYet,
                          textStyle: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManger.slateGrey,
                          ),
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: isLoading ? 5 : donations.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return _buildSkeletonDonationTile();
                        }

                        final donation = donations[index];
                        final String rawStatus =
                            donation.status ?? 'pending';
                        final String donationType =
                            donation.requestId?.bloodType ??
                                appLocalization.blood;
                        final String hospitalName =
                        donation.requestId?.hospitalId is Map
                            ? (donation.requestId!.hospitalId
                        as Map)['hospitalName'] ??
                            appLocalization.hospital
                            : appLocalization.hospital;
                        final String date =
                            donation.createdAt?.substring(0, 10) ??
                                appLocalization.unknown;
                        final int points = donation.pointsEarned ?? 0;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DonationRecordTile(
                            donationType: donationType,
                            hospitalName: hospitalName,
                            date: date,
                            status: localizeStatus(
                              rawStatus,
                              appLocalization,
                            ),
                            statusColor: statusBackgroundColor(rawStatus),
                            stausTextColor: statusTextColor(rawStatus),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: CustomText(
                                  text:
                                  ' $points ${appLocalization.points}',
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonDonationTile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}