import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/active_request_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/cancel_button/widgets/cancel_request_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/contact_donor_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/update_button/widgets/update_request_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/view_detail/view_detail_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/confirmed_colum.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/custom_badge.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/request_meta_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class ActiveRequestsCard extends StatelessWidget {
  const ActiveRequestsCard({super.key});

  Color _urgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'critical':
        return ColorManger.brightRed;
      case 'high':
        return const Color(0xFFE67E22);
      case 'medium':
        return const Color(0xFFF1C40F);
      default:
        return ColorManger.slateGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    const String urgency   = 'critical';
    const String bloodType = 'O+';
    const int    units     = 3;
    const int    confirmed = 1;
    const int    hoursAgo  = 2;
    const int    responses = 5;

    final Color badgeColor = _urgencyColor(urgency);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: ColorManger.pureWhite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      badgeColor,
                      badgeColor.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomBadge(
                        text: loc.critical,
                        backgroundColor: badgeColor,
                        fontColor: ColorManger.pureWhite,
                        borderColor: badgeColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomBadge(
                        text: bloodType,
                        backgroundColor: ColorManger.pureWhite,
                        fontColor: ColorManger.black,
                        borderColor: ColorManger.lightGrey,
                      ),
                      const Spacer(),
                      ConfirmedColum(confirmed: confirmed),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  CustomText(
                    text: loc.unit_needed(units),
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s14,
                      height: 1.4,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Row(
                    children: [
                      RequestMetaInfo(
                        icon: Icons.access_time,
                        label: loc.hours_ago(hoursAgo),
                      ),
                      SizedBox(width: 16.w),
                      RequestMetaInfo(
                        icon: Icons.person_outline,
                        label: loc.responses(responses),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  ActiveRequestNavigationButtons(
                    onViewDetailPressed: () => showDialog(
                      context: context,
                      builder: (_) => const ViewDetailDialog(),
                    ),

                    onContactDonorsPressed: () => showDialog(
                      context: context,
                      builder: (_) => const ContactDonorDialog(),
                    ),

                    onUpdatePressed: () => showDialog(
                      context: context,
                      builder: (_) => UpdateRequestDialog(
                        initialBloodTypes: [bloodType],
                        initialUnits: units,
                        initialUrgency: loc.critical,
                        initialRequiredBy: null,
                        initialPatientType: loc.patientTypeAdult,
                        initialContactNumber:  '',
                        initialPatientDetails: '',
                        onSave: ({
                          required bloodTypes,
                          required urgency,
                          required requiredBy,
                          required patientType,
                          required contactNumber,
                          required patientDetails,
                          required units,
                        }) {
                          // TODO: call update cubit here when backend is linked
                        },
                      ),
                    ),

                    onCancelPressed: () => showDialog(
                      context: context,
                      builder: (_) => CancelRequestDialog(
                        urgency:      loc.critical,
                        bloodType:    bloodType,
                        unitsNeeded:  units,
                        urgencyColor: badgeColor,
                        onConfirmCancel: () {
                          // TODO: call cancel cubit here when backend is linked
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}