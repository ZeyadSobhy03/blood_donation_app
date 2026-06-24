import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../../../../hospital/tabs/home/section/request_header.dart';

class AddRewardCatalogDialog extends StatefulWidget {
  const AddRewardCatalogDialog({super.key});

  @override
  State<AddRewardCatalogDialog> createState() => _AddRewardCatalogDialogState();
}

class _AddRewardCatalogDialogState extends State<AddRewardCatalogDialog> {
  @override
  Widget build(BuildContext context) {
    final loc= AppLocalizations.of(context)!;
    List<String> items = [loc.active, loc.inactive];
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDialogHeader(
                  title: loc.addNewReward,
                  subtitle:
                      loc.addNewRewardSubtitle,
                ),
                SizedBox(height: 20),
                CustomLabel(text: loc.rewardName),
                SizedBox(height: 4),
                CustomTextFormField(hintText: loc.enterRewardName),
                SizedBox(height: 4),
                CustomLabel(text: loc.category),
                SizedBox(height: 4),
                CustomTextFormField(hintText: loc.enterRewardCategory),
                SizedBox(height: 4),
                CustomLabel(text: loc.pointsRequired),
                SizedBox(height: 4),
                CustomTextFormField(
                  hintText: loc.enterPointsRequired,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 4),
                CustomLabel(text: loc.initialState),
                SizedBox(height: 4),
                CustomDropDownButtonFormField(
                  onChanged: (value) {
                    // Handle state change
                  },
                  items: items,
                  hintText: loc.selectState,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: CustomElevatedButton(
                        backgroundColor: ColorManger.pureWhite,
                        foregroundColor: ColorManger.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: ColorManger.lightGrey),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: CustomText(text: loc.cancel),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      flex:2,
                      child: CustomElevatedButton(
                        backgroundColor: ColorManger.brightPurple,
                        foregroundColor: ColorManger.pureWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        onPressed: () {
                          // Handle save action
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18),
                            SizedBox(width: 8),
                            CustomText(text: loc.addReward),
                          ],
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
    );
  }
}
