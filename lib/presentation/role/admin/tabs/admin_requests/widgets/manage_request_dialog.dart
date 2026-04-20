import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations_ar.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_action_button.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_detail_row.dart';
import 'package:flutter/material.dart';

class ManageRequestDialog extends StatelessWidget {
  final String hospitalName;
  final String bloodType;
  final int units;
  final String timeString;
  final String location;
  final int contacted;
  final int confirmed;
  final String badgeLabel;
  final Color badgeColor;

  const ManageRequestDialog({
    super.key,
    required this.hospitalName,
    required this.bloodType,
    required this.units,
    required this.timeString,
    required this.location,
    required this.contacted,
    required this.confirmed,
    required this.badgeLabel,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizationsAr appLocalizationsAr = AppLocalizationsAr();
    final bool isCritical = badgeLabel== appLocalizationsAr.critical;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------Header------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: appLocalizationsAr.manageRequestTitle,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: appLocalizationsAr.manageRequestSubtitle,
                          textStyle: TextStyle(
                              fontSize: 13, color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                    const Icon(Icons.close, size: 20, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --------Summary Card----------
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCritical ? const Color(0xFFFEF2F2) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isCritical
                          ? const Color(0xFFFECACA)
                          : Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: hospitalName,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                     text:"$bloodType • $units ${appLocalizationsAr.units}",
                      textStyle:
                      TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: timeString,
                      textStyle: TextStyle(
                          color:
                          isCritical ? const Color(0xFFDC2626) : Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ------Details List-------
              CustomDetailRow(label: appLocalizationsAr.blood_type, value: bloodType),
              CustomDetailRow(label: appLocalizationsAr.units_needed, value: "$units"),
              CustomDetailRow(label: appLocalizationsAr.location, value: location),
              CustomDetailRow(label: appLocalizationsAr.donorsContactedLabel,value: "$contacted"),

              // ------Highlighted Confirmed Row--------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: appLocalizationsAr.donorsConfirmedLabel,
                        textStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade700)),
                    CustomText(
                      text: "$confirmed",
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF16A34A)), // Green text
                    ),
                  ],
                ),
              ),

              // ------Admin Actions------
              CustomText(
                text: appLocalizationsAr.adminActions,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              CustomActionButton(
                label: appLocalizationsAr.sendEmergencyBroadcast,
                icon: Icons.warning_amber_rounded,
                bgColor: const Color(0xFFEF4444), // Red
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),

              CustomActionButton(
                label: appLocalizationsAr.contactHospitalBtn,
                icon: Icons.phone_outlined,
                bgColor: const Color(0xFF3B82F6), // Blue
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),

              CustomActionButton(
                label: appLocalizationsAr.markAsFulfilledBtn,
                icon: Icons.check_circle_outline,
                bgColor: const Color(0xFF10B981), // Green
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),

              CustomActionButton(
                label: appLocalizationsAr.cancelRequestBtn,
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
                    border: Border.all(color: const Color(0xFFFFEDD5)), // Orange 200
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Color(0xFF9A3412), fontSize: 13, height: 1.4), // Orange 800
                      children: [
                        TextSpan(
                            text: appLocalizationsAr.alertPrefix,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                            appLocalizationsAr.alertCriticalMessage),
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
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: CustomText(text: appLocalizationsAr.close,
                      textStyle: TextStyle(fontWeight: FontWeight.w600)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
