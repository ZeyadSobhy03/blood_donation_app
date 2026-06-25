import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/presentation/view_model/request_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/alerts_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_body.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_header.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/app_localizations.dart';

class EmergencyRequestDialog extends StatefulWidget {
  const EmergencyRequestDialog({super.key});

  @override
  State<EmergencyRequestDialog> createState() => _EmergencyRequestDialogState();
}

class _EmergencyRequestDialogState extends State<EmergencyRequestDialog> {
  final TextEditingController _unitsController = TextEditingController();
  String? _selectedBloodType;
  String? _selectedPatientDetails;
  String? _inlineError;

  @override
  void dispose() {
    _unitsController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_selectedBloodType == null) return;
    final units = int.tryParse(_unitsController.text.trim());
    if (units == null || units < 1) return;

    context.read<RequestCubit>().createEmergencyRequest(
      bloodType: _selectedBloodType!,
      unitsNeeded: units,
      selectedPatientDetailsDisplay: _selectedPatientDetails,
      loc: AppLocalizations.of(context)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is EmergencyRequestSuccessState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        if (state is RequestErrorState) {
          setState(() => _inlineError = state.message);
        }
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: ColorManger.pureWhite,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmergencyRequestHeader(),
                    const SizedBox(height: 16),
                    const AlertsCard(),
                    const SizedBox(height: 16),
                    EmergencyRequestBody(
                      unitsController: _unitsController,
                      selectedBloodType: _selectedBloodType,
                      onBloodTypeChanged: (value) =>
                          setState(() => _selectedBloodType = value),
                      selectedPatientDetails: _selectedPatientDetails,
                      onPatientDetailsChanged: (value) =>
                          setState(() => _selectedPatientDetails = value),
                    ),
                    const SizedBox(height: 24),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: _inlineError != null
                          ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.red.shade200),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.error_outline,
                                  color: Colors.red.shade700,
                                  size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _inlineError!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),

                    const SizedBox(height: 24),
                    EmergencyRequestNavigationButton(
                      onSubmit: _handleSubmit,
                      onCancel: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}