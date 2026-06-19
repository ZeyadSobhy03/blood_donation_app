import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/show_all_donors_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/widgets/donor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/analytics/analytics_view_model.dart';

class TopDonorsCard extends StatelessWidget {
  const TopDonorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

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
                      builder: (context) => const ShowAllDonorsDialog(),
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
            const SizedBox(height: 24),
            BlocBuilder<AnalyticsCubit, AnalyticsState>(
              builder: (context, state) {
                if (state is AnalyticsLoadingState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.royalBlue,
                  );
                }

                if (state is AnalyticsErrorState) {
                  return CustomErrorWidget(message: localizeError(state.errorMessage, appLocalization), onRetry: () {;
                    context.read<AnalyticsCubit>().fetchAnalytics();
                  });
                }

                if (state is AnalyticsSuccessState) {
                  final donors =
                      state.analyticsModel.data?.topDonors ?? [];

                  if (donors.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: appLocalization.noDataFound,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: donors
                        .take(4)
                        .map(
                          (donor) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: DonorTile(
                          rank: donor.donorRank ?? 0,
                          isActive: donor.isActive ?? false,
                          name: donor.name ?? '-',
                          points: donor.points ?? 0,
                          location: donor.location ?? '-',
                          completedDonations: donor.totalDonations ?? 0,
                          lastDonation: donor.createdAt,
                          showLastDonation: false,
                          showActivityStatus: false,
                        ),
                      ),
                    )
                        .toList(),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}