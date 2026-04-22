import 'package:blood_donation_app/core/resources/models/system_status.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/system_status_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class SystemHealthCheckDialog extends StatelessWidget {
  const SystemHealthCheckDialog({super.key});

  Color getStatusColor(SystemStatusType statusType) {
    switch (statusType) {
      case SystemStatusType.health:
        return ColorManger.green;
      case SystemStatusType.warning:
        return ColorManger.orange;
      default:
        return ColorManger.grey400;
    }
  }

  Color getStatusBgColor(SystemStatusType statusType) {
    switch (statusType) {
      case SystemStatusType.health:
        return ColorManger.lightGreen;
      case SystemStatusType.warning:
        return ColorManger.lightOrange;
      default:
        return ColorManger.grey100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final List<SystemStatus> statusList = [
      SystemStatus(
        title: appLocalization.databaseConnection,
        subtitle: appLocalization.responseTime45ms,
        type: SystemStatusType.health,
      ),
      SystemStatus(
        title: appLocalization.apiServer,
        type: SystemStatusType.health,
        subtitle: appLocalization.uptime99_9,
      ),
      SystemStatus(
        title: appLocalization.notificationService,
        type: SystemStatusType.warning,
        subtitle: appLocalization.queue12Pending,
      ),
      SystemStatus(
        title: appLocalization.gpsServices,
        type: SystemStatusType.health,
        subtitle: appLocalization.activeConnections234,
      ),
      SystemStatus(
        title: appLocalization.storage,
        type: SystemStatusType.health,
        subtitle: appLocalization.usedStorage,
      ),
    ];
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      elevation: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                CustomDialogHeader(
                  title: appLocalization.systemHealthCheck,
                  subtitle: appLocalization.runComprehensiveHealthCheck,
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: statusList.length,
                  itemBuilder: (context, index) {
                    final item = statusList[index];
                    final statusText = item.type == SystemStatusType.health
                        ? appLocalization.healthy
                        : appLocalization.warning;
                    final bgColor = getStatusBgColor(item.type);
                    final statusColor = getStatusColor(item.type);

                    return SystemStatusCard(
                      title: item.title,
                      subtitle: item.subtitle,
                      status: statusText,
                      bgColor: bgColor,
                      statusColor: statusColor,
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        elevation: 0,
                        backgroundColor: ColorManger.pureWhite,
                        foregroundColor: ColorManger.black,
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: ColorManger.lightGrey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.refresh),
                            const SizedBox(width: 4),
                            Text(appLocalization.reRunCheck),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomElevatedButton(
                        elevation: 0,
                        backgroundColor: ColorManger.brightPurple,
                        foregroundColor: ColorManger.pureWhite,
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomText(text: appLocalization.completeCheck),
                      ),
                    )
                  ],
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
