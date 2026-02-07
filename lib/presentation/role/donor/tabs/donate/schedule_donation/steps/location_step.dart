import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/hospital_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';

class LocationStep extends StatelessWidget {
  const LocationStep({super.key, required this.nextStep});

  final VoidCallback nextStep;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    List<Map<String, String>> hospitals = [
      {"name": "City Hospital", "dist": "2.3 km away"},
      {"name": "Metro Hospital", "dist": "4.1 km away"},
      {"name": "Central Blood Bank", "dist": "5.8 km away"},
      {"name": "Community Health Center", "dist": "7.2 km away"},
    ];

    final scheduleCubit = context.watch<DonationScheduleCubit>();
    final selectedHospital = scheduleCubit.state.schedule.location;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleStep(
              title: appLocalization.chooseLocationTitle,
              subTitle: appLocalization.chooseLocationSubtitle,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospitalName = hospitals[index]['name']!;
                  return HospitalCard(
                    hospitalName: hospitalName,
                    distance: hospitals[index]['dist']!,
                    isSelect: selectedHospital == hospitalName,
                    onTap: () {
                      scheduleCubit.setLocation(hospitalName);
                      nextStep();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
