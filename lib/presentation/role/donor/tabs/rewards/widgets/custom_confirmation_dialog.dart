import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_success_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomConfirmationDialog extends StatefulWidget {
  final int cost;
  final String title;
  final IconData icon;
  final String rewardId;

  const CustomConfirmationDialog({
    required this.cost,
    required this.title,
    required this.icon,
    required this.rewardId,
    super.key});

  @override
  State<CustomConfirmationDialog> createState() => _CustomConfirmationDialogState();
}

class _CustomConfirmationDialogState extends State<CustomConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    void processRedemption(int cost) {
      context.read<RewardsCubit>().redeemReward(widget.rewardId, cost);

      Navigator.pop(context);

      setState(() {
        RewardsScreen.userPoints.value -= cost;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomSuccessDialog(),
      );
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalizations.redeem_reward,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 30),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: const Color(0xFFFF0F22), size: 24),
                  ),
                  const SizedBox(width: 12),
                  CustomText(
                    text: widget.title,
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: CustomText(
                text: appLocalizations.are_you_sure_you_want_to_redeem,
                textAlign: TextAlign.center,
                textStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6), // Light grey
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: CustomText(text: appLocalizations.cancel, textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => processRedemption(widget.cost),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A), // Dark Black/Navy
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: CustomText(text: appLocalizations.redeem, textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
