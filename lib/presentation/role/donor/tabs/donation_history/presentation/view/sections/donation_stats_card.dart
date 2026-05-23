import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../profile/presentation/view_model/profile/profile_view_model.dart';
import '../widgets/state_item.dart';

class DonationStatsCard extends StatelessWidget {
  const DonationStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileCubit, ProfileViewState>(
      builder: (context, state) {
        final isLoading = state is ProfileLoadingState;
        final totalDonations = state is ProfileSuccessState
            ? state.profileModel.data?.stats?.totalDonations ?? 0
            : 0;
        final points = state is ProfileSuccessState
            ? state.profileModel.data?.stats?.points ?? 0
            : 0;
        final livesSaved = state is ProfileSuccessState
            ? state.profileModel.data?.stats?.livesSaved ?? 0
            : 0;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManger.pureWhite.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StateItem(
                    label: appLocalization.total,
                    value: totalDonations,
                    subLabel: appLocalization.donations,
                  ),
                  StateItem(
                    label: appLocalization.points,
                    value: points,
                    subLabel: appLocalization.earned,
                  ),
                  StateItem(
                    label: appLocalization.livesSaved,
                    value: livesSaved,
                    subLabel: appLocalization.completed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
