import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/manual_points_adjustment_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';

class ManualPointsAdjustmentCard extends StatefulWidget {
  const ManualPointsAdjustmentCard({super.key});

  @override
  State<ManualPointsAdjustmentCard> createState() => _ManualPointsAdjustmentCardState();
}

class _ManualPointsAdjustmentCardState extends State<ManualPointsAdjustmentCard> {
  late TextEditingController _userIdOrEmailController;
  late TextEditingController _amountController;
  late TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _userIdOrEmailController = TextEditingController();
    _amountController = TextEditingController();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _userIdOrEmailController.dispose();
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.lightPurple.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ManualPointsAdjustmentHeader(),
            const SizedBox(height: 24),
            CustomLabel(text: loc.userIdOrEmail),
            const SizedBox(height: 4),
            CustomTextFormField(
              textEditingController: _userIdOrEmailController,
              maxLines: 1,
              prefixIcon: Icon(Icons.search, color: ColorManger.slateGrey),
              hintText: loc.userIdOrEmailHint,
            ),
            const SizedBox(height: 12),
            CustomLabel(text: loc.amountPoints),
            const SizedBox(height: 4),
            CustomTextFormField(
              textEditingController: _amountController,
              maxLines: 1,
              hintText: loc.amountPointsHint,
            ),
            const SizedBox(height: 12),
            CustomLabel(text: loc.reason),
            const SizedBox(height: 4),
            CustomTextFormField(
              textEditingController: _reasonController,
              maxLines: 3,
              hintText: loc.reasonHint,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: ColorManger.lightPurple.withValues(alpha: 0.7)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onPressed: () {},
              backgroundColor: ColorManger.brightPurple,
              foregroundColor: ColorManger.pureWhite,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.electric_bolt, color: ColorManger.pureWhite),
                    const SizedBox(width: 8),
                    CustomText(
                      text: loc.submitAdjustment,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}