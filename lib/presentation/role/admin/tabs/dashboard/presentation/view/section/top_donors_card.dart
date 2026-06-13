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
import '../../view_model/top_donors/top_donors_view_model.dart';

class TopDonorsCard extends StatefulWidget {
  const TopDonorsCard({super.key});

  @override
  State<TopDonorsCard> createState() => _TopDonorsCardState();
}

class _TopDonorsCardState extends State<TopDonorsCard> {
  @override
  void initState() {
    super.initState();
    context.read<TopDonorsCubit>().fetchTopDonors();
  }

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
            BlocBuilder<TopDonorsCubit, TopDonorsState>(
              builder: (context, state) {
                if (state is TopDonorsLoadingState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.royalBlue,
                  );
                }

                if (state is TopDonorsErrorState) {
                  return CustomErrorWidget(
                    message: localizeError(state.errorMessage, appLocalization),
                    onRetry: () =>
                        context.read<TopDonorsCubit>().fetchTopDonors(),
                  );
                }

                if (state is TopDonorsSuccessState) {
                  final donors =
                      state.topDonors.data?.topDonors ?? [];

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
                          rank: 0,
                          isActive: true,
                          name: donor.donor?.fullName ?? '-',
                          bloodType: donor.donor?.bloodType ?? '-',
                          location:
                          '${donor.donor?.location?.city ?? ''}, ${donor.donor?.location?.governorate ?? ''}',
                          completedDonations: donor.completedDonations ?? 0,
                          lastDonation: donor.lastDonation,
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