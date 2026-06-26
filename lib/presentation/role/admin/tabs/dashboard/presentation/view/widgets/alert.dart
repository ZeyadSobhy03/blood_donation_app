import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/extension/data_ex.dart';
import '../../../../../../../../core/utils/alert_localizer.dart';
import '../../../../../../../../core/utils/alert_status.dart';
import '../../../../../../../../l10n/app_localizations.dart';




class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.alertModel, this.onTap,
  });

  final Color backgroundColor;

  final Color color;
  final CriticalAlertModel alertModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final localizedData = localizeAlert(
      context,
      alertModel.title ?? '',
      alertModel.description ?? '',
      alertModel.type ?? appLocalization.warning,
    );
    return InkWell(
      onTap: onTap,

      child: Card(
        color: backgroundColor,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.85), width: 1.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: localizedData.title,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: alertModel.date.toFormattedDate() ,
                      textStyle: TextStyle(color: ColorManger.slateGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  child: CustomText(
                    text:  AlertStatus.getLabel(alertModel.type ?? '', context),
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
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
