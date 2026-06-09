import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/input_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class UpdateRequestDialog extends StatefulWidget {
  const UpdateRequestDialog({
    super.key,
    required this.initialBloodTypes,
    required this.initialUnits,
    required this.initialUrgency,
    required this.initialRequiredBy,
    required this.initialPatientType,
    required this.initialContactNumber,
    required this.initialPatientDetails,
    this.onSave,
  });

  final List<String> initialBloodTypes;
  final int initialUnits;
  final String initialUrgency;
  final DateTime? initialRequiredBy;
  final String initialPatientType;
  final String initialContactNumber;
  final String initialPatientDetails;

  final void Function({
  required Set<String> bloodTypes,
  required String urgency,
  required DateTime? requiredBy,
  required String patientType,
  required String contactNumber,
  required String patientDetails,
  required int units,
  })? onSave;

  @override
  State<UpdateRequestDialog> createState() => _UpdateRequestDialogState();
}

class _UpdateRequestDialogState extends State<UpdateRequestDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final Set<String> _selectedBloodTypes;
  late final TextEditingController _unitsController;
  late final TextEditingController _contactController;
  late final TextEditingController _patientDetailsController;
  String? _selectedUrgency;
  String? _selectedPatientType;
  DateTime? _requiredByDate;

  static const List<String> _bloodTypeOptions = [
    'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-',
  ];

  @override
  void initState() {
    super.initState();
    _selectedBloodTypes = widget.initialBloodTypes.toSet();
    _unitsController =
        TextEditingController(text: widget.initialUnits.toString());
    _contactController =
        TextEditingController(text: widget.initialContactNumber);
    _patientDetailsController =
        TextEditingController(text: widget.initialPatientDetails);
    _selectedUrgency    = widget.initialUrgency;
    _selectedPatientType = widget.initialPatientType;
    _requiredByDate     = widget.initialRequiredBy;
  }

  @override
  void dispose() {
    _unitsController.dispose();
    _contactController.dispose();
    _patientDetailsController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _requiredByDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: ColorManger.skyBlue,
            onPrimary: ColorManger.pureWhite,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _requiredByDate = picked);
  }

  void _handleSave(AppLocalizations loc) {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBloodTypes.isEmpty) return;

    Navigator.of(context).pop();

    widget.onSave?.call(
      bloodTypes: _selectedBloodTypes,
      urgency: _selectedUrgency ?? widget.initialUrgency,
      requiredBy: _requiredByDate,
      patientType: _selectedPatientType ?? widget.initialPatientType,
      contactNumber: _contactController.text.trim(),
      patientDetails: _patientDetailsController.text.trim(),
      units: int.tryParse(_unitsController.text.trim()) ?? widget.initialUnits,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final urgencyOptions = [
      loc.critical,
      loc.urgency_high,
      loc.urgency_medium,
      loc.urgency_low,
    ];

    final patientTypeOptions = [
      loc.patientTypeAdult,
      loc.patientTypeChild,
      loc.patientTypeInfant,
    ];

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: loc.updateRequest,
                              textStyle: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManger.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: loc.updateRequestSubtitle,
                              textStyle: TextStyle(
                                fontSize: FontSize.s12,
                                color: ColorManger.slateGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  InputLabel(label: loc.bloodTypeNeededMulti),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _bloodTypeOptions.map((type) {
                      final isSelected = _selectedBloodTypes.contains(type);
                      return GestureDetector(
                        onTap: () => setState(() => isSelected
                            ? _selectedBloodTypes.remove(type)
                            : _selectedBloodTypes.add(type)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorManger.brightRed
                                : ColorManger.pureWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? ColorManger.brightRed
                                  : ColorManger.lightGrey,
                              width: 1.5,
                            ),
                          ),
                          child: CustomText(
                            text: type,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              fontWeight: isSelected
                                  ? FontWeightManager.bold
                                  : FontWeightManager.regular,
                              color: isSelected
                                  ? ColorManger.pureWhite
                                  : ColorManger.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  if (_selectedBloodTypes.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    CustomText(
                      text:
                      '${loc.selected}: ${_selectedBloodTypes.join(', ')}',
                      textStyle: TextStyle(
                        fontSize: FontSize.s12,
                        color: ColorManger.brightRed,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                  ],

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.units_needed),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    textEditingController: _unitsController,
                    keyboardType: TextInputType.number,
                    hintText: loc.enter_units_needed,
                    validator: (v) => (v == null || v.isEmpty)
                        ? loc.fieldIsRequired
                        : null,
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.urgency),
                  SizedBox(height: 8.h),
                  CustomDropDownButtonFormField(
                    items: urgencyOptions,
                    hintText: loc.select_urgency,
                    initialValue: _selectedUrgency,
                    onChanged: (v) => setState(() => _selectedUrgency = v),
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.requiredBy),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: ColorManger.pureWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorManger.lightGrey),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 18, color: ColorManger.slateGrey),
                          const SizedBox(width: 10),
                          CustomText(
                            text: _requiredByDate != null
                                ? DateFormat('dd / MM / yyyy')
                                .format(_requiredByDate!)
                                : loc.selectDateLabel,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              color: _requiredByDate != null
                                  ? ColorManger.black
                                  : ColorManger.slateGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.patientType),
                  SizedBox(height: 8.h),
                  CustomDropDownButtonFormField(
                    items: patientTypeOptions,
                    hintText: loc.selectPatientType,
                    initialValue: _selectedPatientType,
                    onChanged: (v) => setState(() => _selectedPatientType = v),
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.contactNumber),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    textEditingController: _contactController,
                    keyboardType: TextInputType.phone,
                    hintText: loc.contactNumberHint,
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.patient_details),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    textEditingController: _patientDetailsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    hintText: loc.patientDetailsHint,
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: ColorManger.lightGrey),
                          ),
                          child: CustomText(
                            text: loc.cancel,
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleSave(loc),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: ColorManger.skyBlue,
                            foregroundColor: ColorManger.pureWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: CustomText(
                            text: loc.saveChanges,
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManger.pureWhite,
                            ),
                          ),
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
}