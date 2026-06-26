import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/alert_status.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/quick_actions_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/extension/data_ex.dart';
import '../../../../../../../../core/utils/alert_localizer.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../admin_requests/presentation/view_model/admin_requests_view_model.dart';

import '../../../data/model/analytics/analytics_model.dart';
import '../widgets/info_tile.dart';
import 'alert_card.dart';

class AlertsDialog extends StatefulWidget {
  const AlertsDialog({super.key, required this.alert});

  final CriticalAlertModel alert;

  @override
  State<AlertsDialog> createState() => _AlertsDialogState();
}

class _AlertsDialogState extends State<AlertsDialog> {
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    log('Alert Details: ${widget.alert.toJson()}');
    final localizedData = localizeAlert(
      context,
      widget.alert.title ?? '',
      widget.alert.description ?? '',
      widget.alert.type ?? appLocalization.warning,
    );

    return BlocListener<AdminRequestsCubit, AdminRequestsState>(
      listener: (context, state) {
        if (state is AdminRequestActionSuccessState &&
            state.action == AdminRequestAction.broadcast) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalization.broadcastSent),
              backgroundColor: ColorManger.green,
            ),
          );
          // Close the dialog after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) Navigator.pop(context);
          });
        } else if (state is AdminRequestActionErrorState &&
            state.action == AdminRequestAction.broadcast) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Dialog(
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
                      backgroundColor: AlertStatus.getBackgroundColor(widget.alert.type ?? ''),
                      color: AlertStatus.getColor(widget.alert.type ?? ''),
                      type: AlertStatus.getLabel(widget.alert.type ?? '', context),
                      date: widget.alert.date.toFormattedDate(),
                      title: localizedData.title,
                      description: localizedData.description,
                    ),
                    SizedBox(height: 20),
                    InfoTile(
                      icon: Icons.location_on_outlined,
                      iconColor: ColorManger.royalBlue,
                      label: appLocalization.location,
                      value: widget.alert.location ?? '',
                    ),
                    InfoTile(
                      icon: Icons.favorite_border,
                      iconColor: ColorManger.brightRed,
                      label: appLocalization.units_needed,
                      value: widget.alert.unitsNeeded.toString(),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<AdminRequestsCubit, AdminRequestsState>(
                      builder: (context, state) {
                        log('AdminRequestsState: $state');
                        final isLoading = state is AdminRequestActionInProgressState &&
                            state.action == AdminRequestAction.broadcast;
                        log('isLoading: $isLoading');
                        log('requestId: ${widget.alert.id}');

                        return QuickActionsCard(
                          onEmergencyBroadcast: isLoading
                              ? null
                              : () {
                            log('Emergency broadcast button clicked'); // Add this
                            log('Request ID: ${widget.alert.id}');    // Add this
                            context.read<AdminRequestsCubit>().broadcastRequest(
                              requestId: widget.alert.id ?? '',
                            );
                          },
                          hospitalContactNumber: widget.alert.hospitalContact ?? '',
                          isLoading: isLoading,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}