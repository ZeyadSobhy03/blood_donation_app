import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/created_hospital_summary.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';

import '../../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../../core/resources/models/create_hospital_model.dart';
import '../../../../../../../../core/widgets/location_picker_map.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/users_view_model.dart';
import '../controllers/hospital_form_controllers.dart';
import 'hospital_form_body.dart';


class AddHospitalDialog extends StatefulWidget {
  const AddHospitalDialog({super.key});

  @override
  State<AddHospitalDialog> createState() => _AddHospitalDialogState();
}

class _AddHospitalDialogState extends State<AddHospitalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = HospitalFormControllers();

  String? _selectedHospitalType;
  bool _isSaving = false;
  final Set<String> _selectedBloodBanks = {};

  CreatedHospitalSummary? _createdSummary;

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  SnackBar _buildSnackBar({required String message, required bool isSuccess}) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: isSuccess ? ColorManger.successColor : ColorManger.brightRed,
          fontWeight: FontWeight.w600,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: isSuccess
          ? ColorManger.successBackground
          : ColorManger.errorLightBackground,
    );
  }

  Future<void> _openMapPicker() async {
    final currentLat = double.tryParse(_controllers.latitude.text.trim());
    final currentLng = double.tryParse(_controllers.longitude.text.trim());

    final result = await Navigator.of(context).push<PickedLocation>(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => MapCubit(),
          child: LocationPickerMap(
            initialLatitude: currentLat,
            initialLongitude: currentLng,
          ),
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      _controllers.latitude.text = result.latitude.toStringAsFixed(6);
      _controllers.longitude.text = result.longitude.toStringAsFixed(6);
      if (_controllers.location.text.trim().isEmpty) {
        _controllers.location.text = result.address;
      }
    });
  }

  String _hospitalTypeApiValue(AppLocalizations loc) {
    if (_selectedHospitalType == loc.governmentHospital) return 'government';
    if (_selectedHospitalType == loc.privateHospital) return 'private';
    if (_selectedHospitalType == loc.specializedHospital) return 'specialized';
    if (_selectedHospitalType == loc.communityHospital) return 'community';
    if (_selectedHospitalType == loc.medicalCenter) return 'medical_center';
    return _selectedHospitalType ?? '';
  }

  Future<void> _onSave() async {
    final loc = AppLocalizations.of(context)!;
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (_selectedHospitalType == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(message: loc.selectHospitalType, isSuccess: false),
        );
      return;
    }

    if (!_controllers.hasPickedLocation) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(message: loc.selectLocationOnMap, isSuccess: false),
        );
      return;
    }

    if (_selectedBloodBanks.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(
            message: loc.selectAtLeastOneBloodBank,
            isSuccess: false,
          ),
        );
      return;
    }

    if (!isFormValid) return;

    final createHospitalModel = CreateHospitalModel(
      name: _controllers.name.text.trim(),
      email: _controllers.email.text.trim(),
      password: _controllers.password.text.trim(),
      hospitalCode: _controllers.hospitalCode.text.trim(),
      phone: _controllers.phone.text.trim(),
      latitude: double.parse(_controllers.latitude.text.trim()),
      longitude: double.parse(_controllers.longitude.text.trim()),
      address: _controllers.location.text.trim(),
      city: _controllers.city.text.trim(),
      state: _controllers.state.text.trim(),
      zipCode: _controllers.zipCode.text.trim(),
      type: _hospitalTypeApiValue(loc),
      licenseNumber: _controllers.licenseNumber.text.trim(),
      emergencyContactNumber: _controllers.emergencyContact.text.trim(),
      adminContactName: _controllers.adminContactName.text.trim(),
      adminContactPhone: _controllers.adminContactPhone.text.trim(),
      capacity: int.parse(_controllers.capacity.text.trim()),
      bloodBanksAvailable: _selectedBloodBanks.toList(),
    );

    setState(() => _isSaving = true);

    final result = await context.read<UsersCubit>().createHospital(
      createHospitalModel: createHospitalModel,
    );

    if (!mounted) return;

    if (result.success) {
      setState(() {
        _isSaving = false;
        _createdSummary = CreatedHospitalSummary(
          hospitalName: _controllers.name.text.trim(),
          hospitalCode: _controllers.hospitalCode.text.trim(),
          email: _controllers.email.text.trim(),
          password: _controllers.password.text.trim(),
          phone: _controllers.phone.text.trim(),
          address: _controllers.location.text.trim(),
        );
      });
    } else {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(
            message: localizeError( result.errorMessage ?? loc.failedToCreateHospital , loc),
            isSuccess: false,
          ),
        );
    }
  }

  void _finishWithSuccess() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Scaffold(
          backgroundColor: ColorManger.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.86,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _createdSummary != null
                    ? HospitalCreatedSuccessView(
                  key: const ValueKey('success'),
                  summary: _createdSummary!,
                  onDone: _finishWithSuccess,
                )
                    : _buildForm(context, loc, key: const ValueKey('form')),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations loc, {Key? key}) {
    return Form(
      key: _formKey,
      child: Column(
        key: key,
        children: [
          CustomDialogHeader(
            title: loc.addHospital,
            subtitle: loc.addHospitalSubtitle,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: HospitalFormBody(
              controllers: _controllers,
              selectedHospitalType: _selectedHospitalType,
              onHospitalTypeChanged: (value) {
                setState(() => _selectedHospitalType = value);
              },
              selectedBloodBanks: _selectedBloodBanks,
              onBloodBanksChanged: (updated) {
                setState(() {
                  _selectedBloodBanks
                    ..clear()
                    ..addAll(updated);
                });
              },
              onPickLocation: _openMapPicker,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  backgroundColor: ColorManger.pureWhite,
                  foregroundColor: ColorManger.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManger.slateGrey.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                  ),
                  onPressed:
                  _isSaving ? null : () => Navigator.of(context).pop(),
                  child: CustomText(text: loc.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomElevatedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManger.royalBlue.withValues(alpha: 0.45),
                      width: 1,
                    ),
                  ),
                  backgroundColor: ColorManger.royalBlue,
                  foregroundColor: ColorManger.pureWhite,
                  onPressed: _isSaving ? null : _onSave,
                  child: _isSaving
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorManger.pureWhite,
                    ),
                  )
                      : CustomText(text: loc.save),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}