import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/alert_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/quick_actions_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/info_tile.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/constant/constant_manger.dart';
import '../../../../../../core/resources/models/alert.dart';
import '../../../../../../l10n/app_localizations.dart';

class AlertsDialog extends StatelessWidget {
  const AlertsDialog({super.key, required this.alert});

  final AlertModel alert;

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
                    backgroundColor: _getBackgroundColor(_normalizeType(alert.type, context)),
                    color: _getColor(_normalizeType(alert.type, context)),
                    type: alert.type,
                    date: alert.date,
                    title: alert.title,
                    description: alert.description,
                  ),
                  SizedBox(height: 20),
                  InfoTile(
                    icon: Icons.location_on_outlined,
                    iconColor: ColorManger.royalBlue,
                    label: appLocalization.location,
                    value: alert.location,
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
                    hospitalContactNumber: alert.hospitalContact,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _normalizeType(String type, BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    if (type.toLowerCase() == appLocalization.critical.toLowerCase()) {
      return ConstantManager.critical;
    } else if (type.toLowerCase() == appLocalization.system.toLowerCase()) {
      return ConstantManager.system;
    } else if (type.toLowerCase() == appLocalization.emergency.toLowerCase()) {
      return ConstantManager.emergency;
    } else {
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
