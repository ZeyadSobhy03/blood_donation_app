import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/review_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final cubit = context.watch<DonationScheduleCubit>().state.schedule;
    final currentLocation = cubit.location;
    final currentDate = cubit.date;
    final formattedDate = currentDate != null
        ? DateFormat('dd MMM yyyy').format(currentDate)
        : '';
    final currentTime = cubit.timeSlot;
    final durationType = cubit.donationType;
    final currentEmail = cubit.email;
    final currentFirstName = cubit.firstName;
    final currentPhone = cubit.phone;
    final currentLastName = cubit.lastName;
    final completeName = '$currentFirstName $currentLastName';

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            ReviewRow(
              iconColor: ColorManger.brightRed,
              isContact: false,
              icon: Icons.location_on_outlined,
              title: appLocalizations.location,
              subTitle: currentLocation ?? appLocalizations.notSelected,
            ),
            SizedBox(height: 4.h),
            Divider(color: ColorManger.grey300, indent: 16, endIndent: 16),
            ReviewRow(
              iconColor: ColorManger.brightRed,
              isContact: false,
              icon: Icons.date_range,
              title: appLocalizations.dateTime,
              subTitle: '$formattedDate at $currentTime',
            ),
            SizedBox(height: 4.h),
            Divider(color: ColorManger.grey300, indent: 16, endIndent: 16),
            ReviewRow(
              iconColor: ColorManger.brightRed,
              isContact: false,
              icon: Icons.favorite_border,
              title: appLocalizations.donationType,
              subTitle: durationType ?? appLocalizations.notSelected,
            ),
            SizedBox(height: 4.h),
            Divider(color: ColorManger.grey300, indent: 16, endIndent: 16),
            ReviewRow(
              iconColor: ColorManger.brightRed,
              isContact: true,
              email: currentEmail ?? appLocalizations.noEmail,
              phone: currentPhone ?? appLocalizations.noPhone,
              icon: Icons.person,
              title: appLocalizations.contactInfo,
              subTitle: completeName,
            ),
          ],
        ),
      ),
    );
  }
}
