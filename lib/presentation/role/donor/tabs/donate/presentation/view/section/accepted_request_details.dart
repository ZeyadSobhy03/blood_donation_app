import 'package:blood_donation_app/core/utils/urgency_utils.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/accepted_requests/accepted_requests_model.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../home/presentation/view_model/requests/cancel_request_view_model.dart';
import 'qr_code_card.dart';

class AcceptedRequestDetails extends StatefulWidget {
  const AcceptedRequestDetails({super.key});

  @override
  State<AcceptedRequestDetails> createState() => _AcceptedRequestDetailsState();
}

class _AcceptedRequestDetailsState extends State<AcceptedRequestDetails> {
  late Requests request;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is Requests) {
        request = args;
        _isInitialized = true;
      } else {
        throw Exception('Expected Requests object as argument');
      }
    }
  }

  void _showCancelConfirmationDialog(BuildContext context, String requestId) {
    final appLocalization = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: CustomText(
          text: appLocalization.confirm,
          textStyle: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        content: CustomText(
          text: appLocalization.cancelConfirmationMessage,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        actions: [
          CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: ColorManger.brightRed),
            ),
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.black,
            onPressed: () => Navigator.pop(dialogContext),
            child: CustomText(
              text: appLocalization.no,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s14,
              ),
            ),
          ),
          CustomElevatedButton(
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.brightRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: ColorManger.brightRed),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<CancelRequestCubit>().cancelRequest(
                requestId: requestId,
              );
            },
            child: CustomText(
              text: appLocalization.yes,
              textStyle: TextStyle(
                color: ColorManger.brightRed,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    final addressParts = [
      request.hospitalAddress?.district,
      request.hospitalAddress?.city,
      request.hospitalAddress?.governorate,
    ].where((part) => part != null && part.isNotEmpty).toList();
    final formattedAddress = addressParts.isNotEmpty
        ? addressParts.join(', ')
        : appLocalization.addressNotAvailable;

    return BlocListener<CancelRequestCubit, CancelRequestState>(
      listener: (context, state) {
        if (state is CancelRequestLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => AlertDialog(
              content: CustomLoadingWidget(
                message: appLocalization.cancellingRequest,
              ),
            ),
          );
        } else if (state is CancelRequestSuccessState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: appLocalization.requestCancelledSuccessfully,
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s14,
                ),
              ),
              backgroundColor: ColorManger.successBackground,
              duration: const Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        } else if (state is CancelRequestAlreadyCancelledState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: appLocalization.requestAlreadyCancelled,
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s14,
                ),
              ),
              backgroundColor: Colors.orange.shade700,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is CancelRequestErrorState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: localizeError(state.message, appLocalization),
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s14,
                ),
              ),
              backgroundColor: ColorManger.brightRed,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManger.pureWhite,
        appBar: AppBar(
          backgroundColor: ColorManger.pureWhite,
          elevation: 0,
          foregroundColor: ColorManger.black,
          title: CustomText(
            text: appLocalization.showDetails,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (request.qrToken != null)
                Center(child: QrCodeCard(qrToken: request.qrToken)),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 6.w,
                    children: (request.bloodType ?? [])
                        .map(
                          (bt) => Container(
                            decoration: BoxDecoration(
                              color: ColorManger.brightRed,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: CustomText(
                              text: bt,
                              textStyle: TextStyle(
                                color: ColorManger.pureWhite,
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: UrgencyUtils.getBadgeColor(request.urgency ?? ''),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: CustomText(
                      text: UrgencyUtils.getBadgeLabel(
                        request.urgency ?? '',
                        appLocalization,
                      ),
                      textStyle: TextStyle(
                        color: UrgencyUtils.getBackgroundColor(
                          request.urgency ?? '',
                        ),
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Card(
                color: ColorManger.pureWhite,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            request.hospitalName ??
                            appLocalization.unknownHospital,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: ColorManger.slateGrey,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: CustomText(
                              text: formattedAddress,
                              textStyle: TextStyle(
                                color: ColorManger.slateGrey,
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.regular,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (request.contactNumber != null) ...[
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 16,
                              color: ColorManger.slateGrey,
                            ),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: request.contactNumber!,
                              textStyle: TextStyle(
                                color: ColorManger.slateGrey,
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.regular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                color: ColorManger.pureWhite,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailRow(
                        icon: Icons.water_drop_outlined,
                        label: appLocalization.unitsNeeded,
                        value:
                            '${request.unitsNeeded ?? 1} ${appLocalization.emergency2Units}',
                      ),
                      _DetailRow(
                        icon: Icons.person_outline,
                        label: appLocalization.patientType,
                        value: request.patientType ?? 'Unknown',
                      ),
                      _DetailRow(
                        icon: Icons.warning_amber_rounded,
                        label: appLocalization.emergency,
                        value: request.isEmergency == true
                            ? appLocalization.yes
                            : appLocalization.no,
                        valueColor: request.isEmergency == true
                            ? Colors.orange.shade700
                            : null,
                      ),
                      if (request.acceptedAt != null)
                        _DetailRow(
                          icon: Icons.calendar_today_outlined,
                          label: appLocalization.requestedAt,
                          value: request.acceptedAt!,
                        ),
                      _DetailRow(
                        icon: Icons.fiber_manual_record,
                        label: appLocalization.status,
                        value: request.status ?? 'Pending',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<CancelRequestCubit, CancelRequestState>(
                builder: (context, state) {
                  final isLoading = state is CancelRequestLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.brightRed,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 4,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onPressed: isLoading
                          ? null
                          : () => _showCancelConfirmationDialog(
                              context,
                              request.requestId ?? '',
                            ),
                      child: isLoading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                color: ColorManger.pureWhite,
                                strokeWidth: 2,
                              ),
                            )
                          : CustomText(text: appLocalization.cancel),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10.h),
      child: Row(
        children: [
          Icon(icon, size: 16, color: ColorManger.slateGrey),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              text: label,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ),
          CustomText(
            text: value,
            textStyle: TextStyle(
              color: valueColor ?? ColorManger.black,
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
