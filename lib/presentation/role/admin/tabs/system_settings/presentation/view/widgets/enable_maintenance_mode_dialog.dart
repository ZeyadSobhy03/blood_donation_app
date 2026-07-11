import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';
import '../../view_model/system_maintenance/system_maintenance_view_model.dart';
import 'maintenance_warning_card.dart';

class EnableMaintenanceModeDialog extends StatefulWidget {
  const EnableMaintenanceModeDialog({super.key});

  @override
  State<EnableMaintenanceModeDialog> createState() =>
      _EnableMaintenanceModeDialogState();
}

class _EnableMaintenanceModeDialogState
    extends State<EnableMaintenanceModeDialog> {
  late TextEditingController _messageCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _messageCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _messageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      elevation: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: BlocListener<SystemMaintenanceCubit, SystemMaintenanceState>(
              listener: (context, state) {
                if (state is SystemMaintenanceSuccessState) {
                  Navigator.of(context).pop();
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDialogHeader(
                      title: localizations.enableMaintenanceModeTitle,
                      subtitle: localizations.enableMaintenanceModeSubtitle,
                    ),
                    const SizedBox(height: 16),
                    MaintenanceWarningCard(),
                    const SizedBox(height: 16),
                    CustomLabel(text: localizations.reasonForMaintenanceMode),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      hintText: localizations.enterReasonForMaintenance,
                      validator: (value) => _requiredValidator(value, context),
                      textEditingController: _messageCtrl,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<SystemMaintenanceCubit, SystemMaintenanceState>(
                      builder: (context, state) {
                        final isLoading = state is SystemMaintenanceLoadingState;

                        return Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: ColorManger.orange,
                                    width: 1.1,
                                  ),
                                ),
                                backgroundColor: ColorManger.orange,
                                foregroundColor: ColorManger.pureWhite,
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    context.read<SystemMaintenanceCubit>()
                                        .toggleSystemMaintenance(
                                      enabled: true,
                                      message: _messageCtrl.text.trim(),
                                    );
                                  }
                                },
                                child: isLoading
                                    ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                      ColorManger.pureWhite,
                                    ),
                                  ),
                                )
                                    : CustomText(
                                  text: localizations.enableMaintenanceButton,
                                  textStyle: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomElevatedButton(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: ColorManger.pureWhite,
                                foregroundColor: ColorManger.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: ColorManger.lightGrey),
                                ),
                                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                                child: CustomText(text: localizations.cancel),
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
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }
}