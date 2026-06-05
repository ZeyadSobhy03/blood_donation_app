import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../hospital/tabs/home/section/request_header.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    subjectController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      'Account Management',
      'Technical Issue',
      'Donation Process',
      'Rewards Point',
      'Other',
    ];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDialogHeader(
                  title: 'Contact Support',
                  subtitle:
                      'Fill out the form below to submit a support ticket.',
                ),
                SizedBox(height: 20),
                CustomTextFormField(hintText: 'Name'),
                SizedBox(height: 12),
                CustomTextFormField(hintText: 'Email'),
                SizedBox(height: 12),
                CustomTextFormField(hintText: 'Subject'),
                SizedBox(height: 12),
                CustomDropDownButtonFormField(
                  items: items,
                  hintText: 'Select a category',
                ),
                SizedBox(height: 12),
                CustomTextFormField(hintText: 'Message', maxLines: 5),
                SizedBox(height: 20),
                CustomElevatedButton(
                  elevation: 0,
                   backgroundColor: ColorManger.pureWhite,

                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: ColorManger.grey400),
                  ),
                  child: CustomText(
                    text: 'Submit Ticket',
                    textStyle: TextStyle(color: ColorManger.black),
                  ),
                  onPressed: (){},

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
