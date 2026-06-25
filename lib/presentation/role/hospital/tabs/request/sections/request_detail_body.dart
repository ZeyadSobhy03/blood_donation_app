import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/presentation/view_model/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/input_label.dart';
import '../data/model/request_enum_mapper.dart';

class RequestDetailBody extends StatefulWidget {
  const RequestDetailBody({super.key});

  @override
  State<RequestDetailBody> createState() => _RequestDetailBodyState();
}

class _RequestDetailBodyState extends State<RequestDetailBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _bloodTypes = [
    'O+', 'O-', 'A+', 'A-',
    'B+', 'B-', 'AB+', 'AB-',
  ];
  final Set<String> _selectedBloodTypes = {};

  final TextEditingController _unitsController        = TextEditingController();
  final TextEditingController _contactController      = TextEditingController();

  String? _selectedUrgency;
  String? _selectedPatientType;
  String? _selectedPatientDetails;
  DateTime? _requiredByDate;

  @override
  void dispose() {
    _unitsController.dispose();
    _contactController.dispose();
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
            surface: ColorManger.pureWhite,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _requiredByDate = picked);
  }

  void _submit(AppLocalizations loc) {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedBloodTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.select_blood_type),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_requiredByDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.selectDateLabel),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<RequestCubit>().createRequest(
      selectedBloodTypes: _selectedBloodTypes,
      selectedUrgencyDisplay: _selectedUrgency,
      requiredByDate: _requiredByDate,
      selectedPatientTypeDisplay: _selectedPatientType,
      contactNumber: _contactController.text.trim(),
      selectedPatientDetailsDisplay: _selectedPatientDetails,
      unitsNeeded: int.tryParse(_unitsController.text.trim()) ?? 1,
      loc: loc,
    );
  }

  void _resetForm() {
    setState(() {
      _selectedBloodTypes.clear();
      _selectedUrgency = null;
      _selectedPatientType = null;
      _selectedPatientDetails = null;
      _requiredByDate = null;
    });
    _unitsController.clear();
    _contactController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<String> urgencyLevels = [
      loc.critical,
      loc.urgency_high,
      loc.urgency_medium,
      loc.urgency_low,
    ];

    final List<String> patientTypes = [
      loc.patientTypeAdult,
      loc.patientTypeChild,
      loc.patientTypeInfant,
    ];

    final List<String> patientDetailsOptions =
        RequestEnumMapper.patientDetailsDisplayOptions(loc);

    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          _resetForm();
          context.read<RequestCubit>().reset();
        }

        if (state is RequestErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          final isLoading = state is RequestLoadingState;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomLabel(text: loc.bloodTypeNeededMulti),
                  SizedBox(height: 10.h),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _bloodTypes.map((type) {
                      final isSelected = _selectedBloodTypes.contains(type);
                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : () => setState(() => isSelected
                            ? _selectedBloodTypes.remove(type)
                            : _selectedBloodTypes.add(type)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorManger.brightRed
                                : ColorManger.pureWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? ColorManger.brightRed
                                  : ColorManger.slateGrey
                                  .withValues(alpha: 0.35),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: ColorManger.brightRed
                                    .withValues(alpha: 0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ]
                                : [],
                          ),
                          child: CustomText(
                            text: type,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              fontWeight: isSelected
                                  ? FontWeightManager.bold
                                  : FontWeightManager.medium,
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
                    SizedBox(height: 8.h),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.fieldIsRequired;
                      }
                      if (int.tryParse(value) == null ||
                          int.parse(value) < 1) {
                        return loc.invalidUnits;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.urgency),
                  SizedBox(height: 8.h),
                  CustomDropDownButtonFormField(
                    items: urgencyLevels,
                    hintText: loc.select_urgency,
                    onChanged: (value) =>
                        setState(() => _selectedUrgency = value),
                    initialValue: _selectedUrgency,
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.requiredBy),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: isLoading ? null : _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: ColorManger.pureWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ColorManger.slateGrey.withValues(alpha: 0.35),
                          width: 1.5,
                        ),
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
                              fontWeight: FontWeightManager.regular,
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
                    items: patientTypes,
                    hintText: loc.selectPatientType,
                    onChanged: (value) =>
                        setState(() => _selectedPatientType = value),
                    initialValue: _selectedPatientType,
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.contactNumber),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    textEditingController: _contactController,
                    keyboardType: TextInputType.phone,
                    hintText: loc.contactNumberHint,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.fieldIsRequired;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 14.h),

                  InputLabel(label: loc.patient_details),
                  SizedBox(height: 8.h),
                  CustomDropDownButtonFormField(
                    items: patientDetailsOptions,
                    hintText: loc.enter_patient_details,
                    onChanged: (value) =>
                        setState(() => _selectedPatientDetails = value),
                    initialValue: _selectedPatientDetails,
                  ),

                  SizedBox(height: 24.h),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: isLoading ? null : () => _submit(loc),
                      icon: isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(Icons.favorite_border,
                          color: Colors.white),
                      label: Text(
                        isLoading ? '' : loc.submit_request,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManger.skyBlue,
                        disabledBackgroundColor:
                        ColorManger.skyBlue.withValues(alpha: 0.6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}