import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/manage_request_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class CustomRequestCard extends StatelessWidget {
  final BloodRequestModel request;

  const CustomRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.lightRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFEF4444), width: 4.0),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: request.hospitalName,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
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
                      text: getBadgeLabel(
                        request.urgencyLevel,
                        appLocalizations,
                      ),
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
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
                    "${request.unitsRequested} ${appLocalizations.units} • ${appLocalizations.hours_left(request.completionTimeInHours)}",
                textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        text: request.location,
                        textStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(
                          Icons.people_outline,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "${request.donorsContacted}",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          CustomText(
                            text: appLocalizations.donorsContactedLabel,
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "${request.donorsConfirmed}",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          CustomText(
                            text: appLocalizations.donorsConfirmedLabel,
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          ManageRequestDialog(request: request),
                    );
                  },
                  child: CustomText(
                    text: appLocalizations.manageButton,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
