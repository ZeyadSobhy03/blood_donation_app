import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/data/models/verify_appointment_qr_model.dart';
import '../../../appointments/presentation/view_model/appointments_view_model.dart';
import 'donation_complete_screen.dart';

class EligibilityChecklistScreen extends StatefulWidget {
  const EligibilityChecklistScreen({
    super.key,
    required this.verifyData,
    required this.onBack,
  });

  final VerifyAppointmentQrData verifyData;
  final VoidCallback onBack;

  @override
  State<EligibilityChecklistScreen> createState() =>
      _EligibilityChecklistScreenState();
}

class _EligibilityChecklistScreenState
    extends State<EligibilityChecklistScreen> {
  bool _idVerified = false;
  bool _questionnaireCompleted = false;
  bool _consentSigned = false;
  bool _disqualifyingDiseaseFound = false;
  final List<String> _disqualifyingDiseases = [];
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _rejectReasonController = TextEditingController();

  @override
  void dispose() {
    _diseaseController.dispose();
    _notesController.dispose();
    _rejectReasonController.dispose();
    super.dispose();
  }

  bool get _allChecklistDone =>
      _idVerified && _questionnaireCompleted && _consentSigned;

  void _submit() {
    if (!_allChecklistDone) {
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.pleaseCompleteChecklist)),
      );
      return;
    }

    final cubit = context.read<AppointmentsCubit>();
    final data = widget.verifyData;
    cubit.verifyAppointment(
      appointmentId: data.appointment?.id ?? '',
      verificationSessionId: data.verificationSessionId ?? '',
      idVerified: _idVerified,
      questionnaireCompleted: _questionnaireCompleted,
      consentSigned: _consentSigned,
      screeningCompleted: true,
      disqualifyingDiseaseFound: _disqualifyingDiseaseFound,
      disqualifyingDiseases: _disqualifyingDiseases,
      notes: _notesController.text,
    );
  }

  void _showRejectDialog() {
    final loc = AppLocalizations.of(context)!;
    _rejectReasonController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: CustomText(
          text: loc.rejectVerification,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorManger.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: loc.rejectConfirmation,
              textStyle: const TextStyle(
                fontSize: 14,
                color: ColorManger.slateGrey,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _rejectReasonController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: loc.reasonLabel,
                hintText: loc.reasonHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: CustomText(
              text: loc.cancel,
              textStyle: const TextStyle(color: ColorManger.slateGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              final reason = _rejectReasonController.text.trim();
              if (reason.isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(content: Text(loc.pleaseEnterReason)),
                );
                return;
              }
              Navigator.pop(dialogContext);
              context.read<AppointmentsCubit>().rejectAppointment(
                appointmentId: widget.verifyData.appointment?.id ?? '',
                reason: reason,
              );
            },
            child: CustomText(
              text: loc.reject,
              textStyle: const TextStyle(color: ColorManger.brightRed),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final donor = widget.verifyData.donor;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.pureWhite,
        elevation: 0,
        foregroundColor: ColorManger.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManger.black),
          onPressed: () {
            context.read<AppointmentsCubit>().resetToAppointments();
            widget.onBack();
          },
        ),
        title: CustomText(
          text: loc.eligibilityChecklist,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorManger.black,
          ),
        ),
      ),
      body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is VerifyAppointmentSuccessState) {
            final result = state.data;
            if (result.diseaseScreening?.disqualifyingDiseaseFound == true) {
              final loc = AppLocalizations.of(context)!;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.donorNotEligible),
                  backgroundColor: ColorManger.brightRed,
                ),
              );
              final cubit = context.read<AppointmentsCubit>();
              final navigator = Navigator.of(context);
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  cubit.resetToAppointments();
                  navigator.pop();
                }
              });
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AppointmentsCubit>(),
                    child: DonationCompleteScreen(
                      appointmentId: result.appointment?.id ?? '',
                    ),
                  ),
                ),
              );
            }
          } else if (state is VerifyAppointmentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManger.brightRed,
              ),
            );
          } else if (state is AppointmentRejectSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.verificationRejected),
                backgroundColor: ColorManger.green,
              ),
            );
            final cubit = context.read<AppointmentsCubit>();
            final navigator = Navigator.of(context);
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                cubit.resetToAppointments();
                navigator.pop();
              }
            });
          } else if (state is AppointmentRejectErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManger.brightRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is VerifyAppointmentLoadingState;
          final isRejecting = state is AppointmentRejectLoadingState;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (donor != null) ...[
                  Card(
                    color: ColorManger.pureWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: ColorManger.lightGrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                ColorManger.royalBlue.withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person,
                              color: ColorManger.royalBlue,
                              size: 32,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: donor.fullName ?? loc.unknown,
                                  textStyle: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManger.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text:
                                      '${donor.bloodType ?? '-'} | ${donor.phoneNumber ?? '-'}',
                                  textStyle: TextStyle(
                                    fontSize: FontSize.s13,
                                    color: ColorManger.slateGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                CustomText(
                  text: loc.verificationChecklist,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.black,
                  ),
                ),
                SizedBox(height: 12.h),
                _ChecklistItem(
                  label: loc.idVerified,
                  value: _idVerified,
                  onChanged: (v) => setState(() => _idVerified = v ?? false),
                ),
                SizedBox(height: 8.h),
                _ChecklistItem(
                  label: loc.questionnaireCompleted,
                  value: _questionnaireCompleted,
                  onChanged: (v) =>
                      setState(() => _questionnaireCompleted = v ?? false),
                ),
                SizedBox(height: 8.h),
                _ChecklistItem(
                  label: loc.consentSigned,
                  value: _consentSigned,
                  onChanged: (v) => setState(() => _consentSigned = v ?? false),
                ),
                SizedBox(height: 20.h),
                CustomText(
                  text: loc.diseaseScreening,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.black,
                  ),
                ),
                SizedBox(height: 12.h),
                _ChecklistItem(
                  label: loc.screeningCompleted,
                  value: !_disqualifyingDiseaseFound,
                  onChanged: (v) {
                    final val = v ?? false;
                    if (!val) {
                      setState(() => _disqualifyingDiseaseFound = true);
                    } else {
                      setState(() {
                        _disqualifyingDiseaseFound = false;
                        _disqualifyingDiseases.clear();
                      });
                    }
                  },
                ),
                SizedBox(height: 8.h),
                _ChecklistItem(
                  label: loc.disqualifyingDiseaseFound,
                  value: _disqualifyingDiseaseFound,
                  onChanged: (v) =>
                      setState(() => _disqualifyingDiseaseFound = v ?? false),
                  isWarning: true,
                ),
                if (_disqualifyingDiseaseFound) ...[
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _diseaseController,
                    decoration: InputDecoration(
                      labelText: loc.addDisease,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_diseaseController.text.trim().isNotEmpty) {
                        setState(() {
                          _disqualifyingDiseases
                              .add(_diseaseController.text.trim());
                          _diseaseController.clear();
                        });
                      }
                    },
                    backgroundColor: ColorManger.lightGrey,
                    foregroundColor: ColorManger.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: CustomText(
                      text: loc.addToList,
                      textStyle: TextStyle(
                        fontSize: 13,
                        color: ColorManger.black,
                      ),
                    ),
                  ),
                  if (_disqualifyingDiseases.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: _disqualifyingDiseases.map((d) => Chip(
                        label: Text(d, style: const TextStyle(fontSize: 12)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => setState(
                            () => _disqualifyingDiseases.remove(d)),
                      )).toList(),
                    ),
                  ],
                ],
                SizedBox(height: 16.h),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: loc.notes,
                    hintText: loc.additionalNotes,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: (isLoading || isRejecting) ? null : _submit,
                    backgroundColor: _allChecklistDone
                        ? ColorManger.royalBlue
                        : ColorManger.lightGrey,
                    foregroundColor: ColorManger.pureWhite,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorManger.pureWhite,
                            ),
                          )
                        : CustomText(
                            text: loc.submitVerification,
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorManger.pureWhite,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: (isLoading || isRejecting) ? null : _showRejectDialog,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorManger.brightRed,
                      side: BorderSide(color: ColorManger.brightRed),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isRejecting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorManger.brightRed,
                            ),
                          )
                        : CustomText(
                            text: loc.reject,
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorManger.brightRed,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.label,
    required this.value,
    required this.onChanged,
    this.isWarning = false,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor:
                isWarning ? ColorManger.brightRed : ColorManger.royalBlue,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              text: label,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                color: isWarning && value
                    ? ColorManger.brightRed
                    : ColorManger.black,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
