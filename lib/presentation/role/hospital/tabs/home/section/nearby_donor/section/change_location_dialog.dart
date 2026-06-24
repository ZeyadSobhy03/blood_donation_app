import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../../request_header.dart';

class ChangeLocationDialog extends StatefulWidget {
  const ChangeLocationDialog({super.key});

  @override
  State<ChangeLocationDialog> createState() => _ChangeLocationDialogState();
}

class _ChangeLocationDialogState extends State<ChangeLocationDialog> {
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipCodeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    zipCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDialogHeader(
                title: appLocalizations.change_location,
                subtitle: appLocalizations.change_location_desc,
              ),
              SizedBox(height: 16.h),
              CustomLabel(text: appLocalizations.address),
              CustomTextFormField(
                keyboardType: TextInputType.streetAddress,
                hintText: appLocalizations.enter_address,
                textEditingController: addressController,
              ),
              SizedBox(height: 4.h),
              CustomLabel(text: appLocalizations.city),
              CustomTextFormField(
                keyboardType: TextInputType.text,
                hintText: appLocalizations.enter_city,
                textEditingController: cityController,
              ),
              SizedBox(height: 4.h),
              CustomLabel(text: appLocalizations.state),
              CustomTextFormField(
                keyboardType: TextInputType.text,
                hintText: appLocalizations.enter_state,
                textEditingController: stateController,
              ),
              SizedBox(height: 4.h),
              CustomLabel(text: appLocalizations.zip_code),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                hintText: appLocalizations.enter_zip_code,
                textEditingController: zipCodeController,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Spacer(),
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: ColorManger.slateGrey.withValues(alpha: 0.5),
                    foregroundColor: ColorManger.pureWhite,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: ColorManger.lightGrey.withValues(alpha: 0.5),
                      ),
                    ),
                    child: CustomText(text: appLocalizations.save),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
