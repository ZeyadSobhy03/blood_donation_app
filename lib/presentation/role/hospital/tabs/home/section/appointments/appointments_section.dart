import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../appointments/presentation/view_model/appointments_view_model.dart';
import 'all_appointments_screen.dart';
import 'widgets/appointment_card.dart';
import 'widgets/appointment_detail_dialog.dart';
import 'widgets/appointment_scan_flow_screen.dart';

class AppointmentsSection extends StatelessWidget {
  const AppointmentsSection({super.key, this.maxVisible = 2});

  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is AppointmentsLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final appointments = state is AppointmentsLoadedState
            ? state.appointments
            : context.read<AppointmentsCubit>().appointments;

        if (appointments.isEmpty) {
          return const SizedBox.shrink();
        }

        final visibleAppointments = appointments.take(maxVisible).toList();
        final hasMore = appointments.length > maxVisible;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CustomText(
              text: loc.allAppointments,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 8.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleAppointments.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final appointment = visibleAppointments[index];
                return AppointmentCard(
                  appointment: appointment,
                  onViewDetail: () {
                    context.read<AppointmentsCubit>().fetchAppointmentDetail(
                      appointment.id ?? '',
                    );
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<AppointmentsCubit>(),
                        child: AppointmentDetailDialog(
                          appointmentId: appointment.id ?? '',
                        ),
                      ),
                    );
                  },
                  onScanQr: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AppointmentsCubit>(),
                          child: const AppointmentScanFlowScreen(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (hasMore) ...[
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AppointmentsCubit>(),
                          child: const AllAppointmentsScreen(),
                        ),
                      ),
                    );
                  },
                  child: CustomText(
                    text: loc.viewAll,
                    textStyle: TextStyle(
                      color: ColorManger.royalBlue,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
