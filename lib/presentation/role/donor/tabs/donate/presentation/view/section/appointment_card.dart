import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/appointments/appointments_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/donation_booking_card.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isFirstLoad = true;
  List<Appointments> _cachedAppointments = [];

  @override
  void initState() {
    super.initState();
    context.read<AppointmentsCubit>().fetchAppointments();
  }

  void _updateCachedData(AppointmentsState state) {
    if (state is AppointmentsSuccessState) {
      _cachedAppointments = state.appointments.data?.appointments ?? [];
    } else if (state is AppointmentsPaginationSuccessState) {
      _cachedAppointments = state.appointments.data?.appointments ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listenWhen: (previous, current) => current is AppointmentsSuccessState,
      listener: (context, state) {
        if (state is AppointmentsSuccessState) {
          if (_isFirstLoad) {
            _isFirstLoad = false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(text: appLocalization.appointmentCancelled),
                backgroundColor: Colors.green.shade600,
              ),
            );
          }
        }
      },
      child: Card(
        color: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: appLocalization.upcomingAppointments,
                textStyle: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s15,
                  height: 1.4,
                  color: ColorManger.black,
                ),
              ),

              SizedBox(height: 16.h),

              BlocBuilder<AppointmentsCubit, AppointmentsState>(
                buildWhen: (previous, current) =>
                    current is AppointmentsLoadingState ||
                    current is AppointmentsSuccessState ||
                    current is AppointmentsErrorState ||
                    current is AppointmentsPaginationLoadingState ||
                    current is AppointmentsPaginationSuccessState ||
                    current is AppointmentsPaginationErrorState,
                builder: (context, state) {
                  _updateCachedData(state);

                  if (state is AppointmentsLoadingState &&
                      _cachedAppointments.isEmpty) {
                    return const CustomLoadingWidget();
                  }

                  if (state is AppointmentsErrorState &&
                      _cachedAppointments.isEmpty) {
                    log('AppointmentsErrorState: ${state.error}');
                    return CustomErrorWidget(
                      message: ErrorMapper.map(state.error, appLocalization),
                      onRetry: () {
                        context.read<AppointmentsCubit>().fetchAppointments();
                      },
                    );
                  }

                  if (_cachedAppointments.isEmpty &&
                      state is! AppointmentsLoadingState) {
                    return CustomText(
                      text: appLocalization.noUpcomingAppointments,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        color: ColorManger.slateGrey,
                      ),
                    );
                  }

                  final cubit = context.read<AppointmentsCubit>();
                  final bool isLoadingMore =
                      state is AppointmentsPaginationLoadingState;
                  final bool hasMore = cubit.hasMore;

                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _cachedAppointments.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) => DonationBookingCard(
                          appointment: _cachedAppointments[index],
                        ),
                      ),

                      // Pagination error
                      if (state is AppointmentsPaginationErrorState)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Column(
                            children: [
                              CustomText(
                                text: ErrorMapper.map(
                                  state.error,
                                  appLocalization,
                                ),
                                textStyle: TextStyle(
                                  fontSize: FontSize.s13,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextButton(
                                onPressed: () => cubit.loadMoreAppointments(),
                                child: CustomText(
                                  text: appLocalization.retry,
                                  textStyle: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (isLoadingMore)
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: ColorManger.brightRed,
                            ),
                          ),
                        ),

                      if (hasMore &&
                          !isLoadingMore &&
                          state is! AppointmentsPaginationErrorState)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: TextButton(
                            onPressed: () => cubit.loadMoreAppointments(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: appLocalization.loadMore,
                                  textStyle: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorManger.brightRed,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
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
