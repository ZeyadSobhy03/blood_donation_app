import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/widgets/donor_tile.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/analytics/analytics_view_model.dart';

class ShowAllDonorsDialog extends StatelessWidget {
  const ShowAllDonorsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomDialogHeader(
                    title: appLocalization.allTopDonors,
                    subtitle: appLocalization.allTopDonorsSubtitle,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AnalyticsCubit, AnalyticsState>(
                    builder: (context, state) {
                      if (state is AnalyticsLoadingState) {
                        return CustomLoadingWidget(
                          indicatorColor: ColorManger.brightPurple,
                        );
                      }

                      if (state is AnalyticsErrorState) {
                        return CustomErrorWidget(message: localizeError(state.errorMessage, appLocalization), onRetry: (){
                          context.read<AnalyticsCubit>().fetchAnalytics();
                        });
                      }

                      if (state is AnalyticsSuccessState) {
                        final donors =
                            state.analyticsModel.data?.topDonors ?? [];

                        if (donors.isEmpty) {
                          return Center(
                            child: CustomText(
                              text: appLocalization.noDonorsFound,
                              textStyle: TextStyle(
                                fontSize: FontSize.s14,
                                color: ColorManger.slateGrey,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: donors.length,
                          itemBuilder: (context, index) {
                            final donor = donors[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: DonorTile(
                                rank: donor.donorRank ?? 0,
                                isActive: donor.isActive ?? false,
                                name: donor.name ?? '-',
                                points: donor.points ?? 0,
                                location: donor.location ?? '-',
                                completedDonations: donor.totalDonations ?? 0,
                                lastDonation: donor.createdAt,
                                showLastDonation: true,
                                showActivityStatus: true,
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    backgroundColor: ColorManger.brightPurple,
                    onPressed: () => Navigator.pop(context),
                    foregroundColor: ColorManger.pureWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: ColorManger.brightPurple.withValues(alpha: 0.5),
                        width: 1.1,
                      ),
                    ),
                    child: CustomText(
                      text: appLocalization.close,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        color: ColorManger.pureWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}