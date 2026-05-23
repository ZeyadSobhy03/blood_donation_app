import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';


class DonationRecordTile extends StatelessWidget {
  const DonationRecordTile({
    super.key,
    required this.donationType,
    required this.hospitalName,
    required this.date,
    required this.status,
    required this.statusColor,
    this.trailing,
    required this.leading,
     this.stausTextColor=ColorManger.green,
  });

  final String donationType;
  final String hospitalName;
  final String date;
  final String status;
  final Color statusColor;
  final Widget? trailing;
  final Widget leading;
  final Color stausTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          leading,
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomText(
                text: donationType,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                text: hospitalName,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManger.slateGrey,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: ColorManger.slateGrey.withValues(alpha: 0.7),
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    text: date,
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  text: status,
                  textStyle: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.medium,
                    color: stausTextColor,
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(height: 8), trailing!],
            ],
          ),
        ],
      ),
    );
  }
}
