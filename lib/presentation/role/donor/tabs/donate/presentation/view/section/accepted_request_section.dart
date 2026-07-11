
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/accepted_requests/accepted_requests_view_model.dart';
import 'accepted_request_card.dart';

class AcceptedRequestSection extends StatefulWidget {
  const AcceptedRequestSection({super.key});

  @override
  State<AcceptedRequestSection> createState() => _AcceptedRequestSectionState();
}

class _AcceptedRequestSectionState extends State<AcceptedRequestSection> {
  @override
  void initState() {
    super.initState();
    context.read<AcceptedRequestsCubit>().getAcceptedRequests(
      page: 1,
      limit: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.acceptedRequestSectionTitle,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 8.h),
            BlocBuilder<AcceptedRequestsCubit, AcceptedRequestsState>(
              builder: (context, state) {

                if (state is AcceptedRequestsLoadingState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.brightRed,
                    message: appLocalization.loadingAcceptedRequestsMessage,
                  );
                }

                else if (state is AcceptedRequestsInitialState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.brightRed,
                    message: appLocalization.loadingAcceptedRequestsMessage,
                  );
                }

                else if (state is AcceptedRequestsErrorState) {
                  return CustomErrorWidget(
                    message: localizeError(state.errorMessage, appLocalization),
                    onRetry: () {
                      context.read<AcceptedRequestsCubit>().getAcceptedRequests(
                        page: 1,
                        limit: 10,
                      );
                    },
                  );
                }

                else if (state is AcceptedRequestsSuccessState ||
                    state is AcceptedRequestsLoadingMoreState) {

                  final model = state is AcceptedRequestsSuccessState
                      ? state.model
                      : (state as AcceptedRequestsLoadingMoreState).model;

                  final requestsList = model.data?.requests ?? [];

                  if (requestsList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text: appLocalization.noAcceptedRequestsMessage,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: requestsList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) => AcceptedRequestCard(
                      request: requestsList[index],
                    ),
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