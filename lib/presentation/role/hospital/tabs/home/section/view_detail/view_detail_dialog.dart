import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/view_detail/section/request_detail_body.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ViewDetailDialog extends StatelessWidget {
  const ViewDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RequestHeader(
                  title: appLocalizations.request_details,
                  subtitle: appLocalizations.request_details_desc,
                ),
                SizedBox(height: 16.h),
                RequestDetailBody(
                  bloodType: 'O+',
                  unitsNeeded: 3,
                  urgency: 'Critical',
                  timeLeft: 2,
                  responseCount: 5,
                  confirmedCount: 12,
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
