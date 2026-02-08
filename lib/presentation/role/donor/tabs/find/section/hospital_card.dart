import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/model/hospital_request_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/hospital_actions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/hospital_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.hospitalRequestModel});

  final HospitalRequestModel hospitalRequestModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      elevation: 6,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            HospitalHeader(hospitalRequestModel: hospitalRequestModel),
            SizedBox(height: 24.h),
            Divider(
              color: ColorManger.slateGrey.withValues(alpha: 0.2),
              endIndent: 16,
              indent: 16,
            ),
            SizedBox(height: 8.h),
            HospitalActions(
              hospitalRequestModel: hospitalRequestModel,
            ),
          ],
        ),
      ),
    );
  }
}
