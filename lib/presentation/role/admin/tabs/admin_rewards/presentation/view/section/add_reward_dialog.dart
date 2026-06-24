import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';

class NewRewardResult {
  const NewRewardResult({
    required this.rewardName,
    required this.rewardSubtitle,
    required this.pointsRedeemed,
  });

  final String rewardName;
  final String rewardSubtitle;
  final int pointsRedeemed;
}

class AddRewardDialog extends StatefulWidget {
  const AddRewardDialog({super.key});

  @override
  State<AddRewardDialog> createState() => _AddRewardDialogState();
}

class _AddRewardDialogState extends State<AddRewardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _pointsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _subtitleController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final result = NewRewardResult(
      rewardName: _nameController.text.trim(),
      rewardSubtitle: _subtitleController.text.trim(),
      pointsRedeemed: int.parse(_pointsController.text.trim()),
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: loc.addReward,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              const SizedBox(height: 16),

              CustomText(
                text: loc.rewardName,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextFormField(

                hintText: loc.rewardName,
                textEditingController: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomText(
                text: loc.rewardSubtitle,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextFormField(
                hintText: loc.rewardSubtitle,

                textEditingController: _subtitleController,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomText(
                text: loc.points,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextFormField(
                hintText: loc.points,

                textEditingController: _pointsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return loc.invalidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.pureWhite,
                      foregroundColor: ColorManger.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: ColorManger.slateGrey.withValues(alpha: 0.4),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        text: loc.cancel,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.brightPurple,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      onPressed: _handleSave,
                      child: CustomText(
                        text: loc.save,
                        textStyle: TextStyle(
                          color: ColorManger.pureWhite,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
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
    );
  }
}