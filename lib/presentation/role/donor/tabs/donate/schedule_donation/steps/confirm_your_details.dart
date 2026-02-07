import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';
import '../widgets/input_with_label.dart';

class ConfirmYourDetails extends StatefulWidget {
  const ConfirmYourDetails({super.key, required this.nextStep});

  final VoidCallback nextStep;

  @override
  State<ConfirmYourDetails> createState() => _ConfirmYourDetailsState();
}

class _ConfirmYourDetailsState extends State<ConfirmYourDetails> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController emailController = TextEditingController();

  bool isFormValid = false;

  void _checkFormValid() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DonationScheduleCubit>();
    firstNameController = TextEditingController(text: cubit.state.schedule.firstName);
    lastNameController = TextEditingController(text: cubit.state.schedule.lastName);
    phoneController = TextEditingController(text: cubit.state.schedule.phone);
    emailController = TextEditingController(text: cubit.state.schedule.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        onChanged: _checkFormValid,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleStep(
                  title: appLocalization.confirmDetailsTitle,
                  subTitle: appLocalization.reviewConfirmSubtitle,
                ),
          
                SizedBox(height: 16.h),
          
                Row(
                  children: [
                    Expanded(
                      child: InputWithLabel(
                        label: appLocalization.firstNameLabel,
                        icon: Icons.person,
                        hintText:appLocalization.firstNameHint,
                        textEditingController: firstNameController,
                        validator: (value) => value?.nameValidator,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: InputWithLabel(
                        label: appLocalization.lastNameLabel,
                        hintText: appLocalization.lastNameHint,
                        textEditingController: lastNameController,
                        validator: (value) => value?.nameValidator,
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 8.h),
          
                InputWithLabel(
                  label: appLocalization.phoneNumberLabel,
                  icon: Icons.phone,
                  hintText: appLocalization.phoneHint,
                  textEditingController: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) => value?.phoneValidator,
                ),
          
                SizedBox(height: 8.h),
          
                InputWithLabel(
                  label: appLocalization.emailAddressLabel,
                  icon: Icons.email,
                  hintText: appLocalization.emailHint,
                  textEditingController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value?.emailValidator,
                ),
          
                SizedBox(height: 16.h),
          
                NavigationButton(
                  foregroundColor: ColorManger.pureWhite,
                  backgroundColor: ColorManger.brightRed,
                  text: appLocalization.continueStep,
                  nextStep: isFormValid
                      ? () {
                    final cubit = context.read<DonationScheduleCubit>();
                    cubit.updateFirstName(firstNameController.text);
                    cubit.updateLastName(lastNameController.text);
                    cubit.updatePhone(phoneController.text);
                    cubit.updateEmail(emailController.text);
          
                    widget.nextStep();
                  }
                      : null,
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
