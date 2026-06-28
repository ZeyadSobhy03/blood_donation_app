import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/presentation/view_model/appointments_view_model.dart';

class DonationCompleteScreen extends StatefulWidget {
  const DonationCompleteScreen({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  State<DonationCompleteScreen> createState() =>
      _DonationCompleteScreenState();
}

class _DonationCompleteScreenState extends State<DonationCompleteScreen> {
  final _hemoglobinController = TextEditingController();
  final _weightController = TextEditingController();
  final _unitsController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _hemoglobinController.dispose();
    _weightController.dispose();
    _unitsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    final hemoglobin = double.tryParse(_hemoglobinController.text);
    final weight = double.tryParse(_weightController.text);
    final units = int.tryParse(_unitsController.text);

    if (hemoglobin == null || weight == null || units == null) {
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.pleaseFillRequiredFields)),
      );
      return;
    }

    context.read<AppointmentsCubit>().completeDonation(
      appointmentId: widget.appointmentId,
      hemoglobinLevel: hemoglobin,
      weight: weight,
      unitsCollected: units,
      notes: _notesController.text,
    );
  }

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
          text: loc.donationCompletion,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorManger.black,
          ),
        ),
      ),
      body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is DonationCompleteSuccessState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: ColorManger.green,
                      size: 64,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: loc.donationCompletedSuccessfully,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorManger.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: loc.pointsEarned(state.data.pointsEarned ?? 0),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: CustomText(
                      text: loc.doneButton,
                      textStyle: const TextStyle(color: ColorManger.royalBlue),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DonationCompleteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManger.brightRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is DonationCompleteLoadingState;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: loc.recordDonorData,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: loc.enterDonorReadings,
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: ColorManger.slateGrey,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildField(
                  label: loc.hemoglobinLevel,
                  hint: '13.0',
                  controller: _hemoglobinController,
                ),
                SizedBox(height: 16.h),
                _buildField(
                  label: loc.weightKg,
                  hint: '70',
                  controller: _weightController,
                ),
                SizedBox(height: 16.h),
                _buildField(
                  label: loc.unitsCollected,
                  hint: '1',
                  controller: _unitsController,
                ),
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
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    backgroundColor: ColorManger.royalBlue,
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
                            text: loc.confirm_donation,
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorManger.pureWhite,
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

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
