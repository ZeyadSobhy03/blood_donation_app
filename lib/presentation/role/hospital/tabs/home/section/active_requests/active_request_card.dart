import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/cancel_button/widgets/cancel_request_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/update_button/widgets/update_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../data/models/home_requests_model.dart';
import '../../presentation/view_model/home_view_model.dart';
import '../../../request/data/model/request_enum_mapper.dart';
import '../contact_donor/contact_donor_dialog.dart';
import '../view_detail/view_detail_dialog.dart';
import '../../widgets/confirmed_colum.dart';
import '../../widgets/custom_badge.dart';
import '../../widgets/request_meta_info.dart';
import 'active_request_navigation_buttons.dart';

class ActiveRequestCard extends StatefulWidget {
  const ActiveRequestCard({super.key, required this.request});

  final HomeRequestItem request;

  @override
  State<ActiveRequestCard> createState() => _ActiveRequestCardState();
}

class _ActiveRequestCardState extends State<ActiveRequestCard> {
  bool _isFetchingDetailForUpdate = false;

  HomeRequestItem get request => widget.request;

  Color _urgencyColor() {
    switch (request.urgency) {
      case 'critical':
        return ColorManger.brightRed;
      case 'high':
        return ColorManger.brightRed;
      case 'medium':
        return ColorManger.orange;
      case 'low':
      default:
        return ColorManger.green;
    }
  }

  String _urgencyLabel(AppLocalizations loc) {
    switch (request.urgency) {
      case 'critical':
        return loc.critical;
      case 'high':
        return loc.high;
      case 'medium':
        return loc.medium;
      case 'low':
        return loc.low;
      default:
        return request.urgency ?? '';
    }
  }

  Color _statusColor() {
    final status = (request.requestStatus ?? request.status ?? '').toLowerCase().trim();
    switch (status) {
      case 'pending':
        return ColorManger.orange;
      case 'accepted':
        return ColorManger.green;
      case 'in_progress':
        return ColorManger.royalBlue;
      default:
        return ColorManger.slateGrey;
    }
  }

  String _statusLabel(AppLocalizations loc) {
    final status = request.requestStatus ?? request.status;
    return RequestEnumMapper.statusKeyToDisplay(status, loc);
  }

  Future<void> _openUpdateDialog(String requestId) async {
    final homeCubit = context.read<HomeCubit>();

    setState(() => _isFetchingDetailForUpdate = true);
    await homeCubit.fetchRequestDetail(requestId);
    if (!mounted) return;
    setState(() => _isFetchingDetailForUpdate = false);

    final state = homeCubit.state;
    if (state is RequestDetailLoadedState && state.requestId == requestId) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (dialogContext) => BlocProvider.value(
          value: homeCubit,
          child: UpdateRequestDialog(
            requestId: requestId,
            detail: state.detail,
          ),
        ),
      );
    } else if (state is RequestDetailErrorState) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  void _openCancelDialog(BuildContext context, AppLocalizations loc) {
    final homeCubit = context.read<HomeCubit>();
    final requestId = request.id ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) => CancelRequestDialog(
        urgencyDisplay: _urgencyLabel(loc),
        bloodType: request.bloodTypeDisplay,
        unitsNeeded: request.unitsNeeded ?? 0,
        urgencyColor: _urgencyColor(),
        onConfirmCancel: () => homeCubit.cancelRequest(requestId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final urgencyColor = _urgencyColor();
    final requestId = request.id ?? '';

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: ColorManger.pureWhite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      urgencyColor,
                      urgencyColor.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomBadge(
                              text: _urgencyLabel(appLocalizations),
                              backgroundColor: urgencyColor,
                              fontColor: ColorManger.pureWhite,
                              borderColor: urgencyColor,
                            ),
                            SizedBox(width: 4.w),
                            CustomBadge(
                              text: request.bloodTypeDisplay,
                              backgroundColor: ColorManger.pureWhite,
                              fontColor: ColorManger.black,
                              borderColor: ColorManger.lightGrey,
                            ),
                            SizedBox(width: 4.w),
                            CustomBadge(
                              text: _statusLabel(appLocalizations),
                              backgroundColor: _statusColor(),
                              fontColor: ColorManger.pureWhite,
                              borderColor: _statusColor(),
                            ),
                            const Spacer(),
                            ConfirmedColum(confirmed: request.donorsConfirmed ?? 0),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: appLocalizations.unit_needed(request.unitsNeeded ?? 0),
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s14,
                            height: 1.4,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RequestMetaInfo(
                              icon: Icons.access_time,
                              label: request.timeAgo(context),
                            ),
                            SizedBox(width: 16.w),
                            RequestMetaInfo(
                              icon: Icons.person_outline,
                              label: appLocalizations.responses(
                                request.donorsResponded ?? 0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ActiveRequestNavigationButtons(
                          onContactDonorsPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => BlocProvider.value(
                                value: context.read<HomeCubit>(),
                                child: ContactDonorDialog(
                                  requestId: requestId,
                                  bloodType: request.bloodTypeDisplay,
                                  unitsNeeded: request.unitsNeeded,
                                  urgencyDisplay: _urgencyLabel(appLocalizations),
                                ),
                              ),
                            );
                          },
                          onViewDetailPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => BlocProvider.value(
                                value: context.read<HomeCubit>(),
                                child: ViewDetailDialog(
                                  requestId: requestId,
                                ),
                              ),
                            );
                          },
                          onUpdatePressed: _isFetchingDetailForUpdate
                              ? null
                              : () => _openUpdateDialog(requestId),
                          onCancelPressed: () =>
                              _openCancelDialog(context, appLocalizations),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_isFetchingDetailForUpdate)
              Positioned.fill(
                child: Container(
                  color: ColorManger.pureWhite.withValues(alpha: 0.6),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
