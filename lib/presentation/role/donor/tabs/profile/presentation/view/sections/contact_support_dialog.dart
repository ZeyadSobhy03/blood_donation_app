import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../hospital/tabs/home/section/request_header.dart';
import '../../../../donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';
import '../../view_model/support_contact/support_contact_view_model.dart';

class ContactSupportDialog extends StatefulWidget {
  const ContactSupportDialog({super.key});

  @override
  State<ContactSupportDialog> createState() => _ContactSupportDialogState();
}

class _ContactSupportDialogState extends State<ContactSupportDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController messageController;
  late TextEditingController subjectController;
  String? selectedCategory;
  String? selectedCategoryValue; // Store the backend enum value
  final _formKey = GlobalKey<FormState>();

  // Mapping from backend enum values to localized display names
  late Map<String, String> categoryMap;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    subjectController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    categoryMap = {
      'ACCOUNT': appLocalization.accountManagement,
      'TECHNICAL': appLocalization.technicalIssue,
      'DONATION': appLocalization.donationProcess,
      'REWARDS': appLocalization.rewardsPoint,
      'OTHER': appLocalization.other,
    };

    final items = categoryMap.values.toList();

    return BlocConsumer<SupportContactCubit, SupportContactState>(
      listener: (context, state) {
        if (state is SupportContactSuccessState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: appLocalization.ticket_submitted_successfully,
                textStyle: TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: ColorManger.green,
            ),
          );
        } else if (state is SupportContactErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: localizeError(state.error, appLocalization),
              ),
              backgroundColor: ColorManger.brightRed,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SupportContactLoadingState;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: ColorManger.pureWhite,
          insetPadding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDialogHeader(
                        title: appLocalization.contactSupport,
                        subtitle: appLocalization.contact_support_subtitle,
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        hintText: appLocalization.subject,
                        textEditingController: subjectController,
                      ),
                      const SizedBox(height: 12),
                      CustomDropDownButtonFormField(
                        items: items,
                        hintText: appLocalization.select_category,
                        onChanged: (value) {
                          // Find the enum value that corresponds to this localized string
                          final enumValue = categoryMap.entries
                              .firstWhere((entry) => entry.value == value)
                              .key;
                          setState(() {
                            selectedCategory = value;
                            selectedCategoryValue = enumValue;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        hintText: appLocalization.message,
                        textEditingController: messageController,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      if (state is SupportContactErrorState)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  state.error,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      CustomElevatedButton(
                        elevation: 0,
                        backgroundColor: ColorManger.pureWhite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: ColorManger.grey400),
                        ),
                        onPressed: isLoading
                            ? null
                            : () => _submit(context, state, appLocalization),
                        child: isLoading
                            ? const CustomLoadingWidget()
                            : CustomText(
                                text: state is SupportContactErrorState
                                    ? appLocalization.retry
                                    : appLocalization.submit_ticket,
                                textStyle: TextStyle(color: ColorManger.black),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit(
    BuildContext context,
    SupportContactState state,
    AppLocalizations appLocalization,
  ) {
    if (_formKey.currentState?.validate() != true) return;
    if (selectedCategoryValue == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(appLocalization.select_category)));
      return;
    }

    final cubit = context.read<SupportContactCubit>();

    if (state is SupportContactErrorState) {
      cubit.retrySendSupportRequest(
        subject: subjectController.text.trim(),
        category: selectedCategoryValue!,
        message: messageController.text.trim(),
      );
    } else {
      cubit.sendSupportRequest(
        subject: subjectController.text.trim(),
        category: selectedCategoryValue!,
        message: messageController.text.trim(),
      );
    }
  }
}
