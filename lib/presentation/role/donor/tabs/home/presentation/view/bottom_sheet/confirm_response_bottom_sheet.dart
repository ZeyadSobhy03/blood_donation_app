import 'dart:developer';

import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/requests/requests_model.dart';
import '../../view_model/requests/accept_request_view_model.dart';
import '../../view_model/requests/cancel_request_view_model.dart';
import '../section/confirm_navigation_buttons.dart';
import '../section/next_steps_section.dart';
import '../widgets/request_card.dart';

String formatTimeAgo(DateTime dateTime, BuildContext context) {
  final difference = DateTime.now().difference(dateTime);
  if (difference.inMinutes < 60) {
    return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
  } else if (difference.inDays < 7) {
    return AppLocalizations.of(context)!.daysAgo(difference.inDays);
  } else {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

void showConfirmResponseBottomSheet(
    BuildContext context,
    Request request,
    ) {
  final createdAt = request.createdAt != null
      ? DateTime.tryParse(request.createdAt!) ?? DateTime.now()
      : DateTime.now();

  final acceptCubit = context.read<AcceptRequestCubit>();
  final cancelCubit = context.read<CancelRequestCubit>();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorManger.pureWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
    ),
    builder: (sheetContext) {
      final appLocalizations = AppLocalizations.of(sheetContext)!;

      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: acceptCubit),
          BlocProvider.value(value: cancelCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AcceptRequestCubit, AcceptRequestState>(
              listener: (ctx, state) {
                if (state is AcceptRequestLoadingState) {
                  showDialog(
                    context: ctx,
                    barrierDismissible: false,
                    builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is AcceptRequestSuccessState) {
                  Navigator.of(ctx, rootNavigator: true).pop(); // close loading dialog
                  Navigator.pop(ctx); // close bottom sheet

                  final data = state.requestAcceptModel.data;
                  final deadline = data?.arrivalDeadline != null
                      ? DateTime.tryParse(data!.arrivalDeadline!)
                      : null;
                  final remaining = data?.missedDonationRemaining;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogCtx) {
                      return AlertDialog(
                        title: Text(appLocalizations.requestAcceptedSuccessfully),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (deadline != null)
                              Text(
                                appLocalizations.arrivalDeadlineWarning(
                                  '${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
                                ),
                              ),
                            SizedBox(height: 8.h),
                            if (remaining != null)
                              Text(
                                appLocalizations.missedDonationWarning(remaining),
                                style: TextStyle(
                                  color: remaining <= 1 ? Colors.red : Colors.orange,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                          ],
                        ),
                        actions: [
                          CustomElevatedButton(
                            elevation: 0,
                            backgroundColor: ColorManger.brightRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            foregroundColor: ColorManger.pureWhite,






                            onPressed: () => Navigator.pop(dialogCtx),

                            child: Text(appLocalizations.ok),
                          ),
                        ],
                      );
                    },
                  );
                } else if (state is AcceptRequestErrorState) {
                  log('AcceptRequestErrorState: ${state.message}');
                  Navigator.of(ctx, rootNavigator: true).pop(); // close loading dialog
                  Navigator.pop(ctx); // close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizeError(state.message, appLocalizations)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),

            BlocListener<CancelRequestCubit, CancelRequestState>(
              listener: (ctx, state) {
                if (state is CancelRequestLoadingState) {
                  showDialog(
                    context: ctx,
                    barrierDismissible: false,
                    builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CancelRequestSuccessState) {
                  Navigator.of(ctx, rootNavigator: true).pop();
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(appLocalizations.requestCancelledSuccessfully),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else if (state is CancelRequestErrorState) {
                  Navigator.of(ctx, rootNavigator: true).pop(); // close loading dialog
                  Navigator.pop(ctx); // close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizeError(state.message, appLocalizations)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: appLocalizations.confirmResponse,
                          textStyle: TextStyle(
                            height: 1.4,
                            color: ColorManger.black,
                            fontWeight: FontWeightManager.regular,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Divider(color: ColorManger.slateGrey),
                    RequestCard(
                      isButtonExist: false,
                      borderColor: ColorManger.brightRed,
                      width: 1,
                      widget: Container(
                        decoration: BoxDecoration(
                          color: ColorManger.brightRed,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: ColorManger.pureWhite,
                        ),
                      ),
                      backgroundColor: ColorManger.lightRed,
                      dotColor: ColorManger.brightRed,
                      title: request.hospitalName ?? '',
                      location: request.hospital?.address?.toString() ?? '',                      time: formatTimeAgo(createdAt, sheetContext),
                      buttonBackgroundColor: ColorManger.brightRed,
                    ),
                    SizedBox(height: 12.h),
                    CustomText(
                      text: appLocalizations.emergencyRequestQuestion,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const NextStepsSection(),
                    SizedBox(height: 8.h),

                    BlocBuilder<AcceptRequestCubit, AcceptRequestState>(
                      builder: (ctx, acceptState) {
                        return BlocBuilder<CancelRequestCubit, CancelRequestState>(
                          builder: (ctx, cancelState) {
                            final isBusy =
                                acceptState is AcceptRequestLoadingState ||
                                    cancelState is CancelRequestLoadingState;
                            final requestId = request.requestId ?? '';
                            log('requestId: $requestId');

                            return ConfirmNavigationButtons(
                              cancel: isBusy
                                  ? null
                                  : (){
                                Navigator.pop(context);
                              },

                              accept: isBusy
                                  ? null
                                  : () => acceptCubit.acceptRequest(
                                requestId: requestId,
                              ),
                            );
                          },
                        );
                      },
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