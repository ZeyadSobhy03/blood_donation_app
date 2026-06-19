import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/alert_status.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/quick_actions_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/extension/data_ex.dart';
import '../../../../../../../../l10n/app_localizations.dart';

import '../../../data/model/analytics/analytics_model.dart';
import '../widgets/info_tile.dart';
import 'alert_card.dart';

class AlertsDialog extends StatelessWidget {
  const AlertsDialog({super.key, required this.alert});

  final CriticalAlertModel alert;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDialogHeader(
                    title: appLocalization.alertDetails,
                    subtitle: appLocalization.alertDetailsSubtitle,
                  ),
                  SizedBox(height: 20),
                  AlertCard(
                    backgroundColor: AlertStatus.getBackgroundColor(alert.type?? ''),
                    color: AlertStatus.getColor(alert.type?? ''),
                    type:  AlertStatus.getLabel(alert.type?? '', context),
                    date: alert.date.toFormattedDate() ,
                    title: alert.title ?? '',
                    description: alert.description  ?? '',
                  ),
                  SizedBox(height: 20),
                  InfoTile(
                    icon: Icons.location_on_outlined,
                    iconColor: ColorManger.royalBlue,
                    label: appLocalization.location,
                    value: alert.location ?? '',
                  ),
                  InfoTile(
                    icon: Icons.favorite_border,
                    iconColor: ColorManger.brightRed,
                    label: appLocalization.units_needed,
                    value: alert.unitsNeeded.toString(),
                  ),
                  SizedBox(height: 20,),
                  QuickActionsCard(
                    onEmergencyBroadcast: (){},

                    hospitalContactNumber: alert.hospitalContact ?? '',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
