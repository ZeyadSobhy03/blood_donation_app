import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../appointments/data/models/appointment_list_model.dart';
import '../../appointments/presentation/view_model/appointments_view_model.dart';
import 'widgets/appointment_card.dart';
import 'widgets/appointment_detail_dialog.dart';
import 'widgets/appointment_scan_flow_screen.dart';

class AllAppointmentsScreen extends StatelessWidget {
  const AllAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.pureWhite,
        elevation: 0,
        foregroundColor: ColorManger.black,
        title: CustomText(
          text: loc.allAppointments,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
          ),
        ),
      ),
      body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
          if (state is AppointmentsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          final appointments = state is AppointmentsLoadedState
              ? state.appointments
              : <AppointmentListItem>[];

          if (appointments.isEmpty) {
            return Center(
              child: CustomText(
                text: loc.noAppointmentsFound,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s14,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: appointments.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
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
          );
        },
      ),
    );
  }
}
