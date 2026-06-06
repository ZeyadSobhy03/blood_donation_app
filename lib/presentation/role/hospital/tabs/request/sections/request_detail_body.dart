import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/input_label.dart';

class RequestDetailBody extends StatefulWidget {
  const RequestDetailBody({super.key});

  @override
  State<RequestDetailBody> createState() => _RequestDetailBodyState();
}

class _RequestDetailBodyState extends State<RequestDetailBody> {
  final List<String> _bloodTypes = [
    'O+', 'O-', 'A+', 'A-',
    'B+', 'B-', 'AB+', 'AB-',
  ];
  final Set<String> _selectedBloodTypes = {};

  late TextEditingController _unitsController;
  late TextEditingController _contactController;
  late TextEditingController _patientDetailsController;

  String? _selectedUrgency;
  String? _selectedPatientType;
  DateTime? _requiredByDate;

  @override
  void initState() {
    super.initState();
    _unitsController = TextEditingController();
    _contactController = TextEditingController();
    _patientDetailsController = TextEditingController();
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManger.skyBlue,
              onPrimary: ColorManger.pureWhite,
              surface: ColorManger.pureWhite,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _requiredByDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<String> urgencyLevels = [
      loc.urgency_low,
      loc.urgency_medium,
      loc.urgency_high,
    ];

    final List<String> patientTypes = [
      loc.patientTypeAdult,
      loc.patientTypeChild,
      loc.patientTypeInfant,
    ];

    return SingleChildScrollView(
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
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedBloodTypes.remove(type);
                    } else {
                      _selectedBloodTypes.add(type);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManger.brightRed
                        : ColorManger.pureWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? ColorManger.brightRed
                          : ColorManger.slateGrey.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: ColorManger.brightRed.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
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
              text: '${loc.selected}: ${_selectedBloodTypes.join(', ')}',
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
          ),

          SizedBox(height: 14.h),

          InputLabel(label: loc.urgency),
          SizedBox(height: 8.h),
          CustomDropDownButtonFormField(
            items: urgencyLevels,
            hintText: loc.select_urgency,
            onChanged: (value) => setState(() => _selectedUrgency = value),
            initialValue: _selectedUrgency,
          ),

          SizedBox(height: 14.h),

          InputLabel(label: loc.requiredBy),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: _pickDate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: ColorManger.slateGrey,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: _requiredByDate != null
                        ? DateFormat('dd / MM / yyyy').format(_requiredByDate!)
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
            onChanged: (value) => setState(() => _selectedPatientType = value),
            initialValue: _selectedPatientType,
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
        ],
      ),
    );
  }
}