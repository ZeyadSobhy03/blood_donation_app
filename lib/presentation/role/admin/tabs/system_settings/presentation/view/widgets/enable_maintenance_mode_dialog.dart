import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'maintenance_note_card.dart';
import 'maintenance_warning_card.dart';



class EnableMaintenanceModeDialog extends StatefulWidget {
  const EnableMaintenanceModeDialog({super.key});

  @override
  State<EnableMaintenanceModeDialog> createState() =>
      _EnableMaintenanceModeDialogState();
}

class _EnableMaintenanceModeDialogState
    extends State<EnableMaintenanceModeDialog> {
  late TextEditingController _reasonCtrl;
  late TextEditingController _durationCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _reasonCtrl = TextEditingController();
    _durationCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _reasonCtrl.dispose();
    _durationCtrl.dispose();
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
                  SizedBox(height: 16),
                  MaintenanceWarningCard(),
                  CustomLabel(text: localizations.reasonForMaintenanceMode),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    hintText: localizations.enterReasonForMaintenance,
                    validator: (value) => _requiredValidator(value, context),
                    textEditingController: _reasonCtrl,
                  ),
                  SizedBox(height: 16),
                  CustomLabel(text: localizations.estimatedDurationMinutes),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    hintText: localizations.enterEstimatedDuration,
                    validator: (value) => _numberValidator(value, context),
                    textEditingController: _durationCtrl,
                  ),
                  SizedBox(height: 16),
                  MaintenanceNoteCard(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,

                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: ColorManger.orange,
                              width: 1.1,
                            )
                          ),
                          backgroundColor: ColorManger.orange,
                          foregroundColor: ColorManger.pureWhite,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: CustomText(text: localizations.enableMaintenanceButton,textStyle: TextStyle(
                            fontSize: 12
                          ),),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomElevatedButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,

                          ),

                          backgroundColor: ColorManger.pureWhite,
                          foregroundColor: ColorManger.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: ColorManger.lightGrey),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: CustomText(text: localizations.cancel),
                        ),
                      ),
                    ],
                  ),
                ],
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

  String? _numberValidator(String? value, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return localizations.fieldIsRequired;
    }
    if (int.tryParse(value.trim()) == null) {
      return localizations.pleaseEnterValidNumber;
    }
    return null;
  }
}
