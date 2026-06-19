import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/utils/urgency_utils.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/admin_request_model.dart';
import '../../view_model/admin_requests_view_model.dart';
import 'custom_action_button.dart';
import 'custom_detail_row.dart';

class ManageRequestDialog extends StatefulWidget {
  final Requests request;

  const ManageRequestDialog({super.key, required this.request});

  @override
  State<ManageRequestDialog> createState() => _ManageRequestDialogState();
}

class _ManageRequestDialogState extends State<ManageRequestDialog> {
  String? _feedbackMessage;
  bool _isError = false;

  String get _urgencyLevel =>
      widget.request.urgencyLevel ?? widget.request.urgency ?? 'low';

  String get _bloodTypeLabel {
    if (widget.request.bloodTypeLabel != null &&
        widget.request.bloodTypeLabel!.isNotEmpty) {
      return widget.request.bloodTypeLabel!;
    }
    final types = widget.request.bloodType ?? widget.request.bloodTypes ?? [];
    return types.join(', ');
  }

  void _showFeedback(String message, {bool isError = false}) {
    setState(() {
      _feedbackMessage = message;
      _isError = isError;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _feedbackMessage = null);
    });
  }

  Future<void> _callHospital() async {
    final appLocalizations = AppLocalizations.of(context)!;
    final phone =
        widget.request.hospitalContact ?? widget.request.contactNumber;

    if (phone == null || phone.isEmpty) {
      _showFeedback(appLocalizations.noContactNumberAvailable, isError: true);
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showFeedback(appLocalizations.couldNotLaunchDialer, isError: true);
    }
  }

  void _confirmCancel() {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = context.read<AdminRequestsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManger.pureWhite,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
        title: Text(appLocalizations.cancelRequestBtn),
        content: Text(appLocalizations.cancelRequestConfirmationMessage),
        actions: [
          CustomElevatedButton(
            onPressed: () => Navigator.pop(dialogContext),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),


            backgroundColor: ColorManger.brightPurple,
            child: CustomText(text: appLocalizations.no, textStyle: const TextStyle(color: ColorManger.pureWhite)),


          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.cancelRequest(requestId: widget.request.id ?? '');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: ColorManger.brightRed,
            child: CustomText(text: appLocalizations.yes, textStyle: const TextStyle(color: ColorManger.pureWhite)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool isCritical = _urgencyLevel.toLowerCase() == 'critical';

    return BlocConsumer<AdminRequestsCubit, AdminRequestsState>(
      listenWhen: (previous, current) =>
      current is AdminRequestActionSuccessState ||
          current is AdminRequestActionErrorState,
      listener: (context, state) {
        if (state is AdminRequestActionSuccessState &&
            state.requestId == widget.request.id) {
          _showFeedback(state.message);

          if (state.action == AdminRequestAction.markAsFulfilled ||
              state.action == AdminRequestAction.cancel) {
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted) Navigator.of(context).pop();
            });
          }
        }

        if (state is AdminRequestActionErrorState &&
            state.requestId == widget.request.id) {
          _showFeedback(state.errorMessage, isError: true);
        }
      },
      builder: (context, state) {
        final bool isBusy =
            state is AdminRequestActionInProgressState &&
                state.requestId == widget.request.id;

        final bool isBroadcasting =
            isBusy && state.action == AdminRequestAction.broadcast;
        final bool isFulfilling =
            isBusy && state.action == AdminRequestAction.markAsFulfilled;
        final bool isCancelling =
            isBusy && state.action == AdminRequestAction.cancel;

        final bool anyBusy = isBroadcasting || isFulfilling || isCancelling;

        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: ColorManger.pureWhite,
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDialogHeader(
                        title: appLocalizations.manageRequestTitle,
                        subtitle: appLocalizations.manageRequestSubtitle,
                      ),
                      const SizedBox(height: 24),



                      _UrgencyCard(
                        request: widget.request,
                        urgencyLevel: _urgencyLevel,
                        bloodTypeLabel: _bloodTypeLabel,
                        appLocalizations: appLocalizations,
                      ),
                      const SizedBox(height: 20),

                      CustomDetailRow(
                        label: appLocalizations.blood_type,
                        value: _bloodTypeLabel,
                      ),
                      CustomDetailRow(
                        label: appLocalizations.units_needed,
                        value:
                        "${widget.request.unitsRequested ?? widget.request.unitsNeeded ?? 0}",
                      ),
                      CustomDetailRow(
                        label: appLocalizations.location,
                        value: widget.request.location ?? '',
                      ),
                      CustomDetailRow(
                        label: appLocalizations.donorsContactedLabel,
                        value: "${widget.request.donorsContacted ?? 0}",
                      ),

                      _DonorsConfirmedBadge(
                        count: widget.request.donorsConfirmed ?? 0,
                        label: appLocalizations.donorsConfirmedLabel,
                      ),

                      CustomText(
                        text: appLocalizations.adminActions,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_feedbackMessage != null)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _isError
                                ? const Color(0xFFFFEDED)
                                : const Color(0xFFEDFFF4),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _isError
                                  ? const Color(0xFFEF4444)
                                  : const Color(0xFF10B981),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _isError
                                    ? Icons.error_outline
                                    : Icons.check_circle_outline,
                                color: _isError
                                    ? const Color(0xFFEF4444)
                                    : const Color(0xFF10B981),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _feedbackMessage!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _isError
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFF10B981),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 12),

                      CustomActionButton(
                        onPressed: anyBusy
                            ? null
                            : () => context
                            .read<AdminRequestsCubit>()
                            .broadcastRequest(
                          requestId: widget.request.id ?? '',
                        ),
                        label: appLocalizations.sendEmergencyBroadcast,
                        icon: Icons.warning_amber_rounded,
                        bgColor: const Color(0xFFEF4444),
                        textColor: Colors.white,
                        isLoading: isBroadcasting,
                      ),
                      const SizedBox(height: 12),

                      CustomActionButton(
                        onPressed: anyBusy ? null : () => _callHospital(),
                        label: appLocalizations.contactHospitalBtn,
                        icon: Icons.phone_outlined,
                        bgColor: const Color(0xFF3B82F6),
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 12),

                      CustomActionButton(
                        onPressed: anyBusy
                            ? null
                            : () => context
                            .read<AdminRequestsCubit>()
                            .markRequestAsFulfilled(
                          requestId: widget.request.id ?? '',
                        ),
                        label: appLocalizations.markAsFulfilledBtn,
                        icon: Icons.check_circle_outline,
                        bgColor: const Color(0xFF10B981),
                        textColor: Colors.white,
                        isLoading: isFulfilling,
                      ),
                      const SizedBox(height: 12),

                      CustomActionButton(
                        onPressed:
                        anyBusy ? null : () => _confirmCancel(),
                        label: appLocalizations.cancelRequestBtn,
                        icon: null,
                        bgColor: Colors.white,
                        textColor: const Color(0xFFEF4444),
                        borderColor: const Color(0xFFFECACA),
                        isLoading: isCancelling,
                      ),

                      if (isCritical) ...[
                        const SizedBox(height: 20),
                        _CriticalAlert(appLocalizations: appLocalizations),
                      ],

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed:
                          anyBusy ? null : () => Navigator.pop(context),
                          child: CustomText(
                            text: appLocalizations.close,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class _UrgencyCard extends StatelessWidget {
  final Requests request;
  final String urgencyLevel;
  final String bloodTypeLabel;
  final AppLocalizations appLocalizations;

  const _UrgencyCard({
    required this.request,
    required this.urgencyLevel,
    required this.bloodTypeLabel,
    required this.appLocalizations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UrgencyUtils.getBackgroundColor(urgencyLevel),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: UrgencyUtils.getBadgeColor(urgencyLevel).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text: request.hospitalName ?? '',
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: UrgencyUtils.getBadgeColor(urgencyLevel),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: UrgencyUtils.getBadgeLabel(urgencyLevel, appLocalizations),
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
            text:
            "$bloodTypeLabel • ${request.unitsRequested ?? request.unitsNeeded ?? 0} ${appLocalizations.units}",
            textStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: appLocalizations.hours_left(request.completionTimeInHours ?? 0),
            textStyle: TextStyle(
              color: UrgencyUtils.getBadgeColor(urgencyLevel),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonorsConfirmedBadge extends StatelessWidget {
  final int count;
  final String label;

  const _DonorsConfirmedBadge({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CustomText(
            text: label,
            textStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          CustomText(
            text: "$count",
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16A34A),
            ),
          ),
        ],
      ),
    );
  }
}

class _CriticalAlert extends StatelessWidget {
  final AppLocalizations appLocalizations;

  const _CriticalAlert({required this.appLocalizations});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFEDD5)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xFF9A3412),
            fontSize: 13,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: appLocalizations.alertPrefix,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: appLocalizations.alertCriticalMessage),
          ],
        ),
      ),
    );
  }
}