import 'dart:developer';

import 'package:blood_donation_app/core/utils/urgency_utils.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/accepted_requests/accepted_requests_model.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../home/presentation/view_model/requests/cancel_request_view_model.dart';

class AcceptedRequestCard extends StatelessWidget {
  const AcceptedRequestCard({super.key, required this.request});

  final Requests request;

  void _showCancelConfirmationDialog(BuildContext context, String requestId) {
    final appLocalization = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: ColorManger.pureWhite,

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
              textStyle: TextStyle(fontSize: FontSize.s14),
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
              content: SizedBox(
                height: 100.h,
                width: 100.w,
                child: CustomLoadingWidget(
                  message: appLocalization.cancellingRequest,
                ),
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
              backgroundColor: ColorManger.green,
              duration: const Duration(seconds: 2),
            ),
          );

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
              backgroundColor: ColorManger.warningBackground,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is CancelRequestErrorState) {
          log('Error in CancelRequestCubit: ${state.message}');
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
      child: Card(
        color: ColorManger.pureWhite,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(width: 8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: UrgencyUtils.getBadgeColor(request.urgency??''),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: CustomText(
                      text: UrgencyUtils.getBadgeLabel(request.urgency??'', appLocalization),
                      textStyle: TextStyle(
                        color: UrgencyUtils.getBackgroundColor(request.urgency??''),
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: request.hospitalName ?? appLocalization.unknownHospital,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s15,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: ColorManger.slateGrey,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: CustomText(
                      text: request.hospitalAddress.toString(),
                      textStyle: TextStyle(
                        color: ColorManger.slateGrey,
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: [
                  _InfoChip(
                    icon: Icons.water_drop_outlined,
                    label:
                    '${request.unitsNeeded ?? 1} ${appLocalization.units}',
                  ),
                  _InfoChip(
                    icon: Icons.person_outline,
                    label: _localizePatientType(request.patientType, appLocalization),
                  ),
                  if (request.isEmergency == true)
                    _InfoChip(
                      icon: Icons.warning_amber_rounded,
                      label: appLocalization.emergency,
                      color: Colors.orange.shade700,
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  _StatusDot(status: request.status == 'accepted'? appLocalization.accepted : request.status == 'completed' ? appLocalization.completed : request.status == 'cancelled' ? appLocalization.cancelled : appLocalization.pending),
                  SizedBox(width: 6.w),
                  CustomText(
                    text: request.status == 'accepted'? appLocalization.accepted : request.status == 'completed' ? appLocalization.completed : request.status == 'cancelled' ? appLocalization.cancelled : appLocalization.pending,
                    textStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(color: ColorManger.brightRed, thickness: 1.h),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<CancelRequestCubit, CancelRequestState>(
                      builder: (context, state) {
                        final isLoading = state is CancelRequestLoadingState;

                        return CustomElevatedButton(
                          backgroundColor: ColorManger.pureWhite,
                          foregroundColor: ColorManger.black,
                          elevation: 4,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: const BorderSide(
                              color: ColorManger.brightRed,
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                            _showCancelConfirmationDialog(
                              context,
                              request.requestId ?? '',
                            );
                          },
                          child: isLoading
                              ? SizedBox(
                            height: 16.h,
                            width: 16.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorManger.black,
                              ),
                            ),
                          )
                              : CustomText(text: appLocalization.cancel),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.brightRed,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.acceptedRequestDetails,
                          arguments: request,
                        );
                      },
                      child: CustomText(text: appLocalization.showDetails),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? ColorManger.slateGrey;
    return Container(
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: effectiveColor),
          SizedBox(width: 4.w),
          CustomText(
            text: label,
            textStyle: TextStyle(
              color: effectiveColor,
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'completed':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      case 'pending':
      default:
        color = Colors.orange;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}