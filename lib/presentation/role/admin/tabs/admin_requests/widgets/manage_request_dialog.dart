import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_action_button.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_detail_row.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class ManageRequestDialog extends StatelessWidget {
  final BloodRequestModel request;

  const ManageRequestDialog({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
     final bool isCritical = request.urgencyLevel.toLowerCase() == 'critical';


    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequestHeader(
                    title: appLocalizations.manageRequestTitle,
                    subtitle: appLocalizations.manageRequestSubtitle,
                  ),

                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:getBackgroundColor(request.urgencyLevel) ,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: getBadgeColor(request.urgencyLevel).withValues(alpha: 0.3)
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: request.hospitalName,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: getBadgeColor(request.urgencyLevel),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomText(
                                text: getBadgeLabel(request.urgencyLevel, appLocalizations),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          text:
                              "${request.bloodType} • ${request.unitsRequested} ${appLocalizations.units}",
                          textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: appLocalizations.hours_left(
                            request.completionTimeInHours,
                          ),
                          textStyle: TextStyle(
                            color: getBadgeColor(request.urgencyLevel),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ------Details List-------
                  CustomDetailRow(
                    label: appLocalizations.blood_type,
                    value: request.bloodType,
                  ),
                  CustomDetailRow(
                    label: appLocalizations.units_needed,
                    value: "${request.unitsRequested}",
                  ),
                  CustomDetailRow(
                    label: appLocalizations.location,
                    value: request.location,
                  ),
                  CustomDetailRow(
                    label: appLocalizations.donorsContactedLabel,
                    value: "${request.donorsContacted}",
                  ),

                  // ------Highlighted Confirmed Row--------
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFBBF7D0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: appLocalizations.donorsConfirmedLabel,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        CustomText(
                          text: "${request.donorsConfirmed}",
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16A34A),
                          ), // Green text
                        ),
                      ],
                    ),
                  ),

                  // ------Admin Actions------
                  CustomText(
                    text: appLocalizations.adminActions,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  CustomActionButton(
                    label: appLocalizations.sendEmergencyBroadcast,
                    icon: Icons.warning_amber_rounded,
                    bgColor: const Color(0xFFEF4444), // Red
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 12),

                  CustomActionButton(
                    label: appLocalizations.contactHospitalBtn,
                    icon: Icons.phone_outlined,
                    bgColor: const Color(0xFF3B82F6), // Blue
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 12),

                  CustomActionButton(
                    label: appLocalizations.markAsFulfilledBtn,
                    icon: Icons.check_circle_outline,
                    bgColor: const Color(0xFF10B981), // Green
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 12),

                  CustomActionButton(
                    label: appLocalizations.cancelRequestBtn,
                    icon: null,
                    bgColor: Colors.white,
                    textColor: const Color(0xFFEF4444),
                    borderColor: const Color(0xFFFECACA),
                  ),

                  const SizedBox(height: 20),

                  // --------Alert Box---------
                  if (isCritical)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED), // Orange 50
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFFFEDD5),
                        ), // Orange 200
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF9A3412),
                            fontSize: 13,
                            height: 1.4,
                          ), // Orange 800
                          children: [
                            TextSpan(
                              text: appLocalizations.alertPrefix,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: appLocalizations.alertCriticalMessage,
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(
                        text: appLocalizations.close,
                        textStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getBadgeColor(String urgencyLevel) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return ColorManger.brightRed;
      case 'high':
        return ColorManger.orange;
      case 'low':
        return ColorManger.green;
      default:
        return ColorManger.grey500;
    }
  }

  Color getBackgroundColor(String urgencyLevel) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return ColorManger.lightRed;
      case 'high':
        return ColorManger.lightOrange;
      case 'low':
        return ColorManger.lightGreen;
      default:
        return ColorManger.grey500;
    }
  }
  String getBadgeLabel(String urgencyLevel, AppLocalizations appLocalizations) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return appLocalizations.critical;
      case 'high':
        return appLocalizations.high;
      case 'low':
        return appLocalizations.low;
      default:
        return appLocalizations.unknown;
    }
  }
}
