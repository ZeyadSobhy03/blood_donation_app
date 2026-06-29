import 'package:blood_donation_app/core/extension/data_ex.dart';
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

  // UPDATED: Added Helper method to localize patient type
  String _localizePatientType(String? patientType, AppLocalizations appLocalization) {
    switch (patientType?.toLowerCase()) {
      case 'child':
        return appLocalization.patientTypeChild;
      case 'infant':
        return appLocalization.patientTypeInfant;
      case 'adult':
      default:
      // Defaulting to adult if null or unknown
        return appLocalization.patientTypeAdult;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<CancelRequestCubit, CancelRequestState>(
      listener: (context, state) {
        if (state is CancelRequestLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => AlertDialog(
              backgroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: SizedBox(
                height: 80.h,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: ColorManger.brightRed,
                      ),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: appLocalization.cancellingRequest,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorManger.black,)),
                    CustomText(
                      text: appLocalization.showDetails,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
            
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
            
            
                  ],
                ),
                if (request.qrToken != null)
                  Center(child: QrCodeCard(qrToken: request.qrToken)),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
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
                                text:  request.hospitalAddress.toString(),
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
                        // UPDATED: Used the localization helper here
                        _DetailRow(
                          icon: Icons.person_outline,
                          label: appLocalization.patientType,
                          value: _localizePatientType(request.patientType, appLocalization),
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
                            value: request.acceptedAt.toFormattedDate(),
                          ),
                        _DetailRow(
                          icon: Icons.fiber_manual_record,
                          label: appLocalization.status,
                          value: request.status == 'accepted'? appLocalization.accepted : request.status == 'completed' ? appLocalization.completed : request.status == 'cancelled' ? appLocalization.cancelled : appLocalization.pending,
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