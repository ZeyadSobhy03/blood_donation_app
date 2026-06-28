import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/widgets/input_label.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/data/models/home_request_detail_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/presentation/view_model/home_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_enum_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UpdateRequestDialog extends StatefulWidget {
  const UpdateRequestDialog({
    super.key,
    required this.requestId,
    required this.detail,
  });

  final String requestId;
  final HomeRequestDetailData detail;

  @override
  State<UpdateRequestDialog> createState() => _UpdateRequestDialogState();
}

class _UpdateRequestDialogState extends State<UpdateRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  static const List<String> _bloodTypes = [
    'O+', 'O-', 'A+', 'A-',
    'B+', 'B-', 'AB+', 'AB-',
  ];
  final Set<String> _selectedBloodTypes = {};

  String? _selectedStatus;
  String? _selectedUrgency;
  String? _selectedPatientType;
  String? _selectedPatientDetails;
  DateTime? _requiredByDate;

  @override
  void initState() {
    super.initState();
    final detail = widget.detail;

    _selectedBloodTypes.addAll(detail.bloodTypes ?? []);
    _unitsController.text = detail.unitsNeeded?.toString() ?? '';
    _contactController.text = detail.contactNumber ?? '';
    _requiredByDate = detail.requiredBy;
  }

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

  String _formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
  }

  void _submit(AppLocalizations loc) {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedBloodTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.bloodTypeNeededMulti)),
      );
      return;
    }
    if (_requiredByDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.requiredBy)),
      );
      return;
    }

    final statusKey = _selectedStatus != null
        ? RequestEnumMapper.editableStatusDisplayToKey(_selectedStatus, loc)
        : widget.detail.status ?? 'pending';
    final urgencyKey = _selectedUrgency == loc.critical
        ? 'critical'
        : (_selectedUrgency == loc.urgency_high
        ? 'high'
        : (_selectedUrgency == loc.urgency_medium ? 'medium' : 'low'));
    final patientTypeKey = RequestEnumMapper.patientTypeDisplayToKey(
      _selectedPatientType,
      loc,
    );
    final patientDetailsKey = RequestEnumMapper.patientDetailsDisplayToKey(
      _selectedPatientDetails,
      loc,
    );

    context.read<HomeCubit>().updateRequest(
      requestId: widget.requestId,
      status: statusKey,
      bloodTypes: _selectedBloodTypes.toList(),
      urgency: urgencyKey,
      unitsNeeded: int.tryParse(_unitsController.text.trim()) ?? 1,
      requiredBy: _formatDate(_requiredByDate!),
      patientType: patientTypeKey,
      contactNumber: _contactController.text.trim(),
      patientDetails: patientDetailsKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final urgencyOptions = [loc.critical, loc.urgency_high, loc.urgency_medium, loc.urgency_low];
    final patientTypeOptions = RequestEnumMapper.patientTypeDisplayOptions(loc);
    final patientDetailsOptions = RequestEnumMapper.patientDetailsDisplayOptions(loc);

    final currentStatusKey = widget.detail.status;

    final showStatusDropdown = currentStatusKey == 'accepted';
    if (showStatusDropdown) {
      _selectedStatus ??= RequestEnumMapper.statusKeyToDisplay('in-progress', loc);
    }
    _selectedUrgency ??= RequestEnumMapper.urgencyKeyToDisplay(
      widget.detail.urgency,
      loc,
    );
    _selectedPatientType ??= widget.detail.patientType != null
        ? RequestEnumMapper.patientTypeKeyToDisplay(widget.detail.patientType, loc)
        : null;
    _selectedPatientDetails ??= widget.detail.patientDetails != null
        ? RequestEnumMapper.patientDetailsKeyToDisplay(widget.detail.patientDetails, loc)
        : null;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    if (state is RequestActionSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      Navigator.of(context).pop();
                    } else if (state is RequestActionErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is RequestActionLoadingState;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDialogHeader(
                          title: loc.updateRequest,
                          subtitle: loc.updateRequestSubtitle,
                        ),
                        SizedBox(height: 16.h),

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
                        SizedBox(height: 14.h),

                        InputLabel(label: loc.units_needed),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          textEditingController: _unitsController,
                          keyboardType: TextInputType.number,
                          hintText: loc.enter_units_needed,
                          validator: (value) {
                            final n = int.tryParse(value?.trim() ?? '');
                            if (n == null || n < 1) return loc.invalidUnits;
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),

                        InputLabel(label: loc.urgency),
                        SizedBox(height: 8.h),
                        CustomDropDownButtonFormField(
                          items: urgencyOptions,
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
                          items: patientTypeOptions,
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
                          validator: (value) => (value == null || value.trim().isEmpty)
                              ? loc.fieldIsRequired
                              : null,
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
                        SizedBox(height: 14.h),

                        if (showStatusDropdown) ...[
                          InputLabel(label: loc.requestStatusLabel),
                          SizedBox(height: 8.h),
                          CustomDropDownButtonFormField(
                            items: [RequestEnumMapper.statusKeyToDisplay('in-progress', loc)],
                            hintText: loc.selectStatus,
                            onChanged: (value) =>
                                setState(() => _selectedStatus = value),
                            initialValue: _selectedStatus,
                          ),
                          SizedBox(height: 14.h),
                        ],

                        Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                backgroundColor: ColorManger.pureWhite,
                                foregroundColor: ColorManger.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: ColorManger.lightGrey),
                                ),
                                child: CustomText(text: loc.cancel),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: isLoading ? null : () => _submit(loc),
                                backgroundColor: ColorManger.royalBlue,
                                foregroundColor: ColorManger.pureWhite,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomText(
                                  text: isLoading ? loc.processing : loc.update,
                                  textStyle: TextStyle(color: ColorManger.pureWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
