import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/requests/requests_model.dart';
import '../bottom_sheet/confirm_response_bottom_sheet.dart';
import '../widgets/request_card.dart';

class UrgentRequestsSection extends StatefulWidget {
  const UrgentRequestsSection({super.key, required this.requests});

  final List<Request> requests;

  @override
  State<UrgentRequestsSection> createState() => _UrgentRequestsSectionState();
}

class _UrgentRequestsSectionState extends State<UrgentRequestsSection> {
  String formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.1)),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 8.h,
                  width: 8.h,
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: AppLocalizations.of(context)!.urgentRequests,
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontSize: FontSize.s16,
                    height: 1.4,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    child: CustomText(
                      text:
                      '${widget.requests.length} ${AppLocalizations.of(context)!.active}',
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.requests.length,
              itemBuilder: (context, index) {
                final request = widget.requests[index];

                final createdAt = request.createdAt != null
                    ? DateTime.tryParse(request.createdAt!) ?? DateTime.now()
                    : DateTime.now();

                final isEmergency = request.isEmergency ?? false;

                return RequestCard(
                  isButtonExist: true,
                  width: 1,
                  borderColor: ColorManger.transparent,
                  widget: Container(
                    height: 6.h,
                    width: 6.h,
                    decoration: BoxDecoration(
                      color: isEmergency
                          ? ColorManger.brightRed
                          : ColorManger.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManger.requestScreen,
                      arguments: request,
                    );
                  },
                  backgroundColor: isEmergency
                      ? ColorManger.lightRed
                      : ColorManger.lightOrange,
                  dotColor: isEmergency
                      ? ColorManger.brightRed
                      : ColorManger.orange,
                  title: request.hospitalName ?? '',
                  location:'${ request.hospital?.address} ',
                  time: formatTimeAgo(createdAt),
                  buttonBackgroundColor: isEmergency
                      ? ColorManger.brightRed
                      : ColorManger.orange,
                  onPressed: () => showConfirmResponseBottomSheet(
                    context,
                    request,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}