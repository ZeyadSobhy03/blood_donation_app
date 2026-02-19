import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
      final appLocalization=AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: EdgeInsets.all(16.w.clamp(12, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.aboutTitle,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s15,
              ),
            ),
            SizedBox(height: 14.h),
            _AboutRow(label: appLocalization.aboutVersion, value: '1.0.0'),
            SizedBox(height: 8.h),
            _AboutRow(label: appLocalization.aboutLastUpdated, value: 'Jan 31, 2026'),

          ],
        ),
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String label;
  final String value;

  const _AboutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s13,
          ),
        ),
        CustomText(
          text: value,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s13,
          ),
        ),
      ],
    );
  }
}