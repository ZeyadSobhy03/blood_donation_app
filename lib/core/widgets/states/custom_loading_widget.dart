import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../l10n/app_localizations.dart';
import '../../resources/colors/color_manger.dart';
import '../../resources/fonts/font_manger.dart';
import '../../widgets/custom_text.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? message;
  final double? indicatorSize;

  const CustomLoadingWidget({
    super.key,
    this.message,
    this.indicatorSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorManger.brightRed,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomText(
            text: message ?? appLocalizations.processingRequest,
            textStyle: TextStyle(
              color: ColorManger.grey600,
              fontWeight: FontWeightManager.semiBold,
              fontSize: FontSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}

