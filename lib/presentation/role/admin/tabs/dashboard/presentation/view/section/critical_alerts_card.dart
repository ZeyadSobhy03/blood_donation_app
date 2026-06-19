

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/alert_status.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import '../widgets/alert.dart';
import 'alerts_dialog.dart';

class CriticalAlerts extends StatefulWidget {
  const CriticalAlerts({super.key});

  @override
  State<CriticalAlerts> createState() => _CriticalAlertsState();
}

class _CriticalAlertsState extends State<CriticalAlerts> {


  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightRed,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.brightRed.withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: ColorManger.brightRed, size: 22),
                const SizedBox(width: 8),
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
            const SizedBox(height: 18),
            BlocBuilder<AnalyticsCubit, AnalyticsState>(
              builder: (context, state) {
                if (state is AnalyticsLoadingState) {
                  return  CustomLoadingWidget(
                    indicatorColor: ColorManger.royalBlue,
                  );
                }

                if (state is AnalyticsErrorState) {
                  return  CustomErrorWidget(message: localizeError(state.errorMessage,appLocalization), onRetry: () {
                    context.read<AnalyticsCubit>().fetchAnalytics();

                  },);
                }

                if (state is AnalyticsSuccessState) {
                  final alerts =
                      state.analyticsModel.data?.criticalAlerts ?? [];

                  if (alerts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text:
                          appLocalization.noAlerts,
                          textStyle: TextStyle(color: ColorManger.grey500),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      final alert = alerts[index];
                      final normalizedType =
                          AlertStatus.normalizeType(alert.type ?? '');


                      return Alert(
                        backgroundColor: AlertStatus.getBackgroundColor(normalizedType),
                        color: AlertStatus.getColor(normalizedType),
                        alertModel: alert,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertsDialog(alert: alert),
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }


}