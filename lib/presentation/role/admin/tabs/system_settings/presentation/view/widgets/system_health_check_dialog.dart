import 'package:blood_donation_app/core/resources/models/system_status.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_health/system_health_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/widgets/system_status_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/system_health/system_health_view_model.dart';

class SystemHealthCheckDialog extends StatefulWidget {
  const SystemHealthCheckDialog({super.key});

  @override
  State<SystemHealthCheckDialog> createState() => _SystemHealthCheckDialogState();
}

class _SystemHealthCheckDialogState extends State<SystemHealthCheckDialog> {

  @override
  void initState() {
    super.initState();
    context.read<SystemHealthCubit>().fetchSystemHealth();
  }

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

  List<SystemStatus> _buildStatusList(
      BuildContext context,
      Data data,
      ) {
    final appLocalization = AppLocalizations.of(context)!;

    final dbType = data.database == 'connected'
        ? SystemStatusType.health
        : SystemStatusType.warning;

    final serverType = data.status == 'healthy'
        ? SystemStatusType.health
        : SystemStatusType.warning;

    final memoryType = SystemStatusType.health;

    final uptimeHours = data.uptime != null
        ? '${(data.uptime! / 3600).toStringAsFixed(1)}h uptime'
        : appLocalization.uptime99_9;

    final memoryText = (data.memory?.used != null && data.memory?.total != null)
        ? '${data.memory!.used} / ${data.memory!.total}'
        : appLocalization.usedStorage;

    return [
      SystemStatus(
        title: appLocalization.databaseConnection,
        subtitle: data.database ?? appLocalization.responseTime45ms,
        type: dbType,
      ),
      SystemStatus(
        title: appLocalization.apiServer,
        subtitle: uptimeHours,
        type: serverType,
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
        type: memoryType,
        subtitle: memoryText,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

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

                // ─── BlocBuilder ──────────────────────────────────────
                BlocBuilder<SystemHealthCubit, SystemHealthState>(
                  builder: (context, state) {
                    if (state is SystemHealthLoadingState) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is SystemHealthErrorState) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Icon(Icons.error_outline,
                                  color: ColorManger.orange, size: 40),
                              const SizedBox(height: 8),
                              Text(
                                state.errorKey,
                                style: TextStyle(color: ColorManger.grey400),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (state is SystemHealthSuccessState) {
                      final statusList = _buildStatusList(
                        context,
                        state.systemHealthModel.data!,
                      );

                      return ListView.builder(
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
                      );
                    }

                    return const SizedBox.shrink();
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
                        onPressed: () =>
                            context.read<SystemHealthCubit>().fetchSystemHealth(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                        onPressed: () => Navigator.pop(context),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomText(text: appLocalization.completeCheck),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}