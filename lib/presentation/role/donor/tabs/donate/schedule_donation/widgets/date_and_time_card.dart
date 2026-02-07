import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/review_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../l10n/app_localizations.dart';

class DateAndTimeCard extends StatelessWidget {
  const DateAndTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    final cubit = context.read<DonationScheduleCubit>().state.schedule;
    final currentLocation = cubit.location;
    final currentDate = cubit.date;
    final formattedDate = currentDate != null
        ? DateFormat.yMMMMd(
            Localizations.localeOf(context).toString(),
          ).format(currentDate)
        : '';

    final currentTime = cubit.timeSlot;
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            ReviewRow(
              iconColor: ColorManger.slateGrey,
              title: appLocalization.locationLabel,
              subTitle: currentLocation!,
              icon: Icons.location_on_outlined,
              isContact: false,
            ),
            SizedBox(height: 4.h),
            ReviewRow(
              iconColor: ColorManger.slateGrey,
              title: appLocalization.whenLabel,
              subTitle: '$formattedDate at $currentTime',
              icon: Icons.calendar_today,
              isContact: false,
            ),
          ],
        ),
      ),
    );
  }
}
