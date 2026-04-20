import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations_ar.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/manage_request_dialog.dart';
import 'package:flutter/material.dart';

class CustomRequestCard extends StatelessWidget {
  final String title;
  final String badgeLabel;
  final Color badgeColor;
  final int units;
  final String timeString;
  final String location;
  final int contacted;
  final int confirmed;
  const CustomRequestCard({super.key,
    required this.title,
    required this.badgeLabel,
    required this.badgeColor,
    required this.units,
    required this.timeString,
    required this.location,
    required this.contacted,
    required this.confirmed,
  });



  @override
  Widget build(BuildContext context) {
    AppLocalizationsAr appLocalizationsAr = AppLocalizationsAr();
    final parts = title.split(' - ');
    final hospitalName = parts[0];
    final bloodType = parts.length > 1 ? parts[1].replaceAll(' Blood', '') : '';
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFFEF4444),
                width: 4.0,
              ),
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
                      text: title,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      text: badgeLabel,
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
               text:"$units ${appLocalizationsAr.units} • $timeString",
               textStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      CustomText(
                        text: location,
                        textStyle: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(Icons.people_outline,
                            size: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text:"$contacted",
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                          CustomText(text: appLocalizationsAr.donorsContactedLabel,
                              textStyle: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(Icons.check_circle_outline,
                            size: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text:"$confirmed",
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                          CustomText(text: appLocalizationsAr.donorsConfirmedLabel,
                              textStyle: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600)),
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
                      builder: (context) => ManageRequestDialog(
                        hospitalName: hospitalName,
                        bloodType: bloodType,
                        units: units,
                        timeString: timeString,
                        location: location,
                        contacted: contacted,
                        confirmed: confirmed,
                        badgeLabel: badgeLabel,
                        badgeColor: badgeColor,
                      ),
                    );
                  },
                  child: CustomText(
                    text: appLocalizationsAr.manageButton,
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
}
