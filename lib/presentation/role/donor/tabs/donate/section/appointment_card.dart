import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/appointments_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/donation_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    context.read<AppointmentsCubit>().fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is AppointmentsSuccessState) {
          if (_isFirstLoad) {
            _isFirstLoad = false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  text: appLocalization.appointmentCancelled,
                ),
                backgroundColor: Colors.green.shade600,
              ),
            );
          }
        }

        if (state is AppointmentsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(text: state.error),
              backgroundColor: Colors.red.shade400,
            ),
          );
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
                builder: (context, state) {
                  if (state is AppointmentsLoadingState) {
                    return const CustomLoadingWidget();
                  }

                  if (state is AppointmentsErrorState) {
                    return CustomErrorWidget(
                      message: state.error,
                      onRetry: () {
                        context
                            .read<AppointmentsCubit>()
                            .fetchAppointments();
                      },
                    );
                  }

                  if (state is AppointmentsSuccessState) {
                    final appointments =
                        state.appointments.data?.appointments ?? [];

                    if (appointments.isEmpty) {
                      return CustomText(
                        text: appLocalization.noUpcomingAppointments,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.slateGrey,
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: appointments.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) => DonationBookingCard(
                        appointment: appointments[index],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}