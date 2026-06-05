import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../l10n/app_localizations.dart';
import '../../resources/colors/color_manger.dart';
import '../../resources/fonts/font_manger.dart';
import '../../widgets/custom_text.dart';

/// Full-screen loading widget using skeletonizer
class CustomSkeletonLoadingWidget extends StatelessWidget {
  final String? message;
  final double? containerHeight;

  const CustomSkeletonLoadingWidget({
    super.key,
    this.message,
    this.containerHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Skeletonizer(
      enabled: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: containerHeight,
              width: containerHeight,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              height: 20.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 16.h,
              width: 250.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact loading indicator using skeletonizer
class CompactSkeletonLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const CompactSkeletonLoading({
    super.key,
    this.size = 50,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Center(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color ?? ColorManger.lightRed,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Loading widget for dialogs
class DialogSkeletonLoading extends StatelessWidget {
  final String? message;

  const DialogSkeletonLoading({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Skeletonizer(
      enabled: true,
      child: Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 18.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 14.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

