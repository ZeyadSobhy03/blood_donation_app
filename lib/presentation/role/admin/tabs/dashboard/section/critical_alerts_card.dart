import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/constant/constant_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/alert.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/alerts_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/alert.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class CriticalAlerts extends StatelessWidget {
  const CriticalAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final alerts = [
      AlertModel(
        title: appLocalization.alertBloodShortage,
        type: appLocalization.critical,
        date: DateTime.now().subtract(Duration(minutes: 5)),
        description:
            "City Hospital is critically low on O- blood. Only 2 units remaining.",
        bloodTypesNeeded: ["O-", "A+", "B+", "AB+"],
        createdAt: DateTime.now().subtract(Duration(minutes: 5)),
        hospitalContact: "+201141935341",
        hospitalId: 'H001',
        id: "alert1",
        location: "Cairo, Egypt",
        unitsNeeded: 20,
        hospitalName: "City Hospital",
        latitude: 30.0444,
        longitude: 31.2357,
        predictMatchPercentage: 75,
      ),

      AlertModel(
        title: appLocalization.alertHighDemand,
        type: appLocalization.system,
        date: DateTime.now().subtract(Duration(minutes: 10)),
        description:
            "Prediction: 45% increase in A+ blood demand خلال 48 ساعة.",
        bloodTypesNeeded: ["A+"],
        createdAt: DateTime.now().subtract(Duration(minutes: 10)),
        hospitalContact: "+201100000001",
        hospitalId: 'H002',
        id: "alert2",
        location: "Giza, Egypt",
        unitsNeeded: 12,
        hospitalName: "Giza General Hospital",
        latitude: 30.0131,
        longitude: 31.2089,
        predictMatchPercentage: 60,
      ),

      AlertModel(
        title: appLocalization.alertEmergency,
        type: appLocalization.emergency,
        date: DateTime.now().subtract(Duration(minutes: 15)),
        description: "Multi-vehicle accident. Immediate blood required.",
        bloodTypesNeeded: ["O+", "O-", "A+", "AB+"],
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        hospitalContact: "+201100000002",
        hospitalId: 'H003',
        id: "alert3",
        location: "Alexandria, Egypt",
        unitsNeeded: 30,
        hospitalName: "Alex Emergency Hospital",
        latitude: 31.2001,
        longitude: 29.9187,
        predictMatchPercentage: 90,
      ),

      AlertModel(
        title: appLocalization.alertBloodShortage,
        type: appLocalization.critical,
        date: DateTime.now().subtract(Duration(minutes: 20)),
        description: "Severe shortage in B- blood type.",
        bloodTypesNeeded: ["B-"],
        createdAt: DateTime.now().subtract(Duration(minutes: 20)),
        hospitalContact: "+201100000003",
        hospitalId: 'H004',
        id: "alert4",
        location: "Mansoura, Egypt",
        unitsNeeded: 8,
        hospitalName: "Mansoura Medical Center",
        latitude: 31.0409,
        longitude: 31.3785,
        predictMatchPercentage: 70,
      ),

      AlertModel(
        title: appLocalization.alertEmergency,
        type: appLocalization.emergency,
        date: DateTime.now().subtract(Duration(minutes: 25)),
        description: "Urgent surgery requires AB- blood.",
        bloodTypesNeeded: ["AB-"],
        createdAt: DateTime.now().subtract(Duration(minutes: 25)),
        hospitalContact: "+201100000004",
        hospitalId: 'H005',
        id: "alert5",
        location: "Tanta, Egypt",
        unitsNeeded: 5,
        hospitalName: "Tanta University Hospital",
        latitude: 30.7865,
        longitude: 31.0004,
        predictMatchPercentage: 85,
      ),

      AlertModel(
        title: appLocalization.alertHighDemand,
        type: appLocalization.system,
        date: DateTime.now().subtract(Duration(minutes: 30)),
        description: "Trend shows increase in O+ demand across hospitals.",
        bloodTypesNeeded: ["O+"],
        createdAt: DateTime.now().subtract(Duration(minutes: 30)),
        hospitalContact: "+201100000005",
        hospitalId: 'H006',
        id: "alert6",
        location: "Cairo, Egypt",
        unitsNeeded: 18,
        hospitalName: "National Blood Bank",
        latitude: 30.0500,
        longitude: 31.2333,
        predictMatchPercentage: 65,
      ),

      AlertModel(
        title: appLocalization.alertBloodShortage,
        type: appLocalization.critical,
        date: DateTime.now().subtract(Duration(minutes: 40)),
        description: "Only 3 units of A- blood left.",
        bloodTypesNeeded: ["A-"],
        createdAt: DateTime.now().subtract(Duration(minutes: 40)),
        hospitalContact: "+201100000006",
        hospitalId: 'H007',
        id: "alert7",
        location: "Asyut, Egypt",
        unitsNeeded: 15,
        hospitalName: "Asyut General Hospital",
        latitude: 27.1801,
        longitude: 31.1837,
        predictMatchPercentage: 72,
      ),

      AlertModel(
        title: appLocalization.alertEmergency,
        type: appLocalization.emergency,
        date: DateTime.now().subtract(Duration(hours: 1)),
        description: "Fire incident victims بحاجة لنقل دم سريع.",
        bloodTypesNeeded: ["O+", "O-", "A+", "B+"],
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        hospitalContact: "+201100000007",
        hospitalId: 'H008',
        id: "alert8",
        location: "Cairo, Egypt",
        unitsNeeded: 35,
        hospitalName: "Kasr Al Ainy Hospital",
        latitude: 30.0276,
        longitude: 31.2101,
        predictMatchPercentage: 95,
      ),
    ];
    return Card(
      color: ColorManger.lightRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: ColorManger.brightRed, size: 22),
                SizedBox(width: 8),
                CustomText(
                  text: appLocalization.criticalAlerts,
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                final normalizedType = normalizeType(alert.type);

                return Alert(
                  backgroundColor: _getBackgroundColor(normalizedType),
                  color: _getColor(normalizedType),
                  alertModel: alert,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertsDialog(alert: alert);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String normalizeType(String type) {
    switch (type.toLowerCase()) {
      case 'critical':
      case 'حرج':
        return ConstantManager.critical;

      case 'system':
      case 'نظام':
        return ConstantManager.system;

      case 'emergency':
      case 'عاجل':
        return ConstantManager.emergency;

      default:
        return 'unknown';
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case ConstantManager.critical:
        return ColorManger.orange;
      case ConstantManager.system:
        return ColorManger.yellow;
      case ConstantManager.emergency:
        return ColorManger.brightRed;
      default:
        return ColorManger.grey500;
    }
  }

  Color _getBackgroundColor(String type) {
    switch (type) {
      case ConstantManager.critical:
        return ColorManger.lightOrange;
      case ConstantManager.system:
        return ColorManger.lightYellow;
      case ConstantManager.emergency:
        return ColorManger.lightRed;
      default:
        return ColorManger.grey100;
    }
  }
}
