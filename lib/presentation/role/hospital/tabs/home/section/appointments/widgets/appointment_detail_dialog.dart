import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/presentation/view_model/appointments_view_model.dart';
import 'appointment_scan_flow_screen.dart';

class AppointmentDetailDialog extends StatefulWidget {
  const AppointmentDetailDialog({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  State<AppointmentDetailDialog> createState() =>
      _AppointmentDetailDialogState();
}

class _AppointmentDetailDialogState extends State<AppointmentDetailDialog> {
  late final AppointmentsCubit _appointmentsCubit;

  @override
  void initState() {
    super.initState();
    _appointmentsCubit = context.read<AppointmentsCubit>();
    if (widget.appointmentId.isNotEmpty) {
      _appointmentsCubit.fetchAppointmentDetail(widget.appointmentId);
    }
  }

  @override
  void dispose() {
    _appointmentsCubit.resetToAppointments();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
            builder: (context, state) {
              if (state is AppointmentDetailLoadingState) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CustomLoadingWidget()),
                );
              }

              if (state is AppointmentDetailErrorState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: state.message,
                      textStyle: TextStyle(color: ColorManger.brightRed),
                    ),
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(
                        text: loc.close,
                        textStyle: TextStyle(color: ColorManger.royalBlue),
                      ),
                    ),
                  ],
                );
              }

              if (state is AppointmentDetailLoadedState &&
                  state.appointmentId == widget.appointmentId) {
                final detail = state.detail;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: loc.view_details,
                            textStyle: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManger.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close, color: ColorManger.slateGrey),
                          ),
                        ],
                      ),
                      Divider(color: ColorManger.lightGrey),
                      SizedBox(height: 8.h),
                      _DetailRow(
                        label: loc.donor,
                        value: detail.donorName ?? loc.unknown,
                      ),
                      _DetailRow(
                        label: loc.bloodType,
                        value: detail.donorBloodType ?? '-',
                      ),
                      _DetailRow(
                        label: loc.phone,
                        value: detail.donorPhone ?? '-',
                      ),
                      if (detail.donorEmail != null &&
                          detail.donorEmail!.isNotEmpty)
                        _DetailRow(
                          label: loc.donor_email,
                          value: detail.donorEmail!,
                        ),
                      _DetailRow(
                        label: loc.statusLabel,
                        value: detail.status ?? '-',
                      ),
                      if (detail.appointmentDate != null)
                        _DetailRow(
                          label: loc.appointmentDateLabel,
                          value: detail.appointmentDate!,
                        ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: CustomText(
                              text: loc.close,
                              textStyle: TextStyle(
                                color: ColorManger.royalBlue,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: _appointmentsCubit,
                                    child: const AppointmentScanFlowScreen(),
                                  ),
                                ),
                              );
                            },
                            child: CustomText(
                              text: loc.scan_qr_code,
                              textStyle: TextStyle(
                                color: ColorManger.royalBlue,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            textStyle: TextStyle(
              fontSize: FontSize.s13,
              color: ColorManger.slateGrey,
            ),
          ),
          CustomText(
            text: value,
            textStyle: TextStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.medium,
              color: ColorManger.black,
            ),
          ),
        ],
      ),
    );
  }
}
