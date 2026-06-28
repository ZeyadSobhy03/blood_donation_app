import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/presentation/view/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/presentation/view/widgets/custom_stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../hospital/tabs/find_donor/widgets/hospital_title.dart';
import '../view_model/admin_requests_view_model.dart';

const int _kRequestsLimit = 10;

class AdminRequest extends StatefulWidget {
  const AdminRequest({super.key});

  @override
  State<AdminRequest> createState() => _AdminRequestState();
}

class _AdminRequestState extends State<AdminRequest> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AdminRequestsCubit>().getAdminRequests(
      status: 'pending',
      page: 1,
      limit: _kRequestsLimit,
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      context.read<AdminRequestsCubit>().loadMoreRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<AdminRequestsCubit, AdminRequestsState>(
          builder: (context, state) {
            if (state is AdminRequestsLoadingState) {
              return CustomLoadingWidget(
                indicatorColor: ColorManger.brightPurple,
              );
            }

            if (state is AdminRequestsErrorState) {
              log('AdminRequestsErrorState: ${state.errorMessage}');
              return CustomErrorWidget(
                message: localizeError(state.errorMessage, appLocalizations),
                onRetry: () {
                  context.read<AdminRequestsCubit>().getAdminRequests(
                    status: 'pending',
                    page: 1,
                    limit: _kRequestsLimit,
                  );
                },
              );
            }

            final model = switch (state) {
              AdminRequestsSuccessState s => s.adminRequestModel,
              AdminRequestsLoadingMoreState s => s.adminRequestModel,
              AdminRequestActionInProgressState s => s.adminRequestModel,
              AdminRequestActionSuccessState s => s.adminRequestModel,
              AdminRequestActionErrorState s => s.adminRequestModel,
              _ => null,
            };

            if (model != null) {
              final data = model.data;
              final requests = data?.requests ?? [];
              final criticalCount = data?.stats?.byUrgency?.critical ?? 0;
              final fulfilledCount = data?.stats?.byStatus?.completed ?? 0;
              final isLoadingMore = state is AdminRequestsLoadingMoreState;

              return SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(
                      title: appLocalizations.bloodRequestsTitle,
                      subTitle: appLocalizations.bloodRequestsSubtitle,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomStatCard(
                            icon: Icons.warning_amber_rounded,
                            count: "$criticalCount",
                            label: appLocalizations.critical,
                            bgColor: ColorManger.lightRed,
                            iconColor: ColorManger.brightRed,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomStatCard(
                            icon: Icons.check_circle_outline,
                            count: "$fulfilledCount",
                            label: appLocalizations.fulfilledToday,
                            bgColor: ColorManger.lightGreen,
                            iconColor: ColorManger.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    CustomText(
                      text: appLocalizations.activeRequests,
                      textStyle: TextStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (requests.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(
                          child: CustomText(
                            text: appLocalizations.noRequestsFound,
                            textStyle:
                            TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                              index == requests.length - 1 ? 0 : 16,
                            ),
                            child: CustomRequestCard(request: request),
                          );
                        },
                      ),
                    if (isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: CustomLoadingWidget(
                            indicatorColor: ColorManger.brightPurple,
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}