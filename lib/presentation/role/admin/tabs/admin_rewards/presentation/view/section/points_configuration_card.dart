import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/add_reward_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/points_configuration_header.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/custom_reward_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class PointsConfigurationCard extends StatefulWidget {
  const PointsConfigurationCard({super.key});

  @override
  State<PointsConfigurationCard> createState() => _PointsConfigurationCardState();
}

class _PointsConfigurationCardState extends State<PointsConfigurationCard> {
  bool _isEditing = false;

  final List<Map<String, dynamic>> _rewardsData = [
    {
      'rewardName': 'Free Health Checkup',
      'rewardSubtitle': 'Voucher',
      'pointsRedeemed': 120,
      'iconData': Icons.card_giftcard,
      'iconColor': ColorManger.brightPurple,
    },
    {
      'rewardName': 'Blood Donor T-Shirt',
      'rewardSubtitle': 'Merchandise',
      'pointsRedeemed': 95,
      'iconData': Icons.bloodtype,
      'iconColor': ColorManger.brightRed,
    },
    {
      'rewardName': 'Pharmacy Discount',
      'rewardSubtitle': '15% Off',
      'pointsRedeemed': 80,
      'iconData': Icons.local_pharmacy,
      'iconColor': ColorManger.green,
    },
    {
      'rewardName': 'Gym Membership',
      'rewardSubtitle': '1 Month',
      'pointsRedeemed': 60,
      'iconData': Icons.fitness_center,
      'iconColor': ColorManger.orange,
    },
    {
      'rewardName': 'Coffee Shop Voucher',
      'rewardSubtitle': 'Free Drink',
      'pointsRedeemed': 45,
      'iconData': Icons.local_cafe,
      'iconColor': ColorManger.lightAmber,
    },
  ];

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = _rewardsData
        .map((r) => TextEditingController(text: r['pointsRedeemed'].toString()))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _enterEditMode() {
    setState(() => _isEditing = true);
  }

  void _cancelEdit() {
    for (int i = 0; i < _rewardsData.length; i++) {
      _controllers[i].text = _rewardsData[i]['pointsRedeemed'].toString();
    }
    setState(() => _isEditing = false);
  }

  void _saveChanges() {
    setState(() {
      for (int i = 0; i < _rewardsData.length; i++) {
        final parsed = int.tryParse(_controllers[i].text);
        if (parsed != null) {
          _rewardsData[i]['pointsRedeemed'] = parsed;
        }
      }
      _isEditing = false;
    });
  }

  Future<void> _openAddRewardDialog() async {
    final result = await showDialog<NewRewardResult>(
      context: context,
      builder: (context) => const AddRewardDialog(),
    );

    if (result == null) return;

    setState(() {
      _rewardsData.add({
        'rewardName': result.rewardName,
        'rewardSubtitle': result.rewardSubtitle,
        'pointsRedeemed': result.pointsRedeemed,

        'iconData': Icons.card_giftcard,
        'iconColor': ColorManger.brightPurple,
      });
      _controllers.add(
        TextEditingController(text: result.pointsRedeemed.toString()),
      );
    });
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PointsConfigurationHeader(
              isEditing: _isEditing,
              onEditPressed: _enterEditMode,
              onAddPressed: _openAddRewardDialog,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: _rewardsData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reward = _rewardsData[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRewardTile(
                    rewardName: reward['rewardName'] as String,
                    rewardSubtitle: reward['rewardSubtitle'] as String,
                    pointsRedeemed: reward['pointsRedeemed'] as int,
                    prefixWidget: Icon(
                      reward['iconData'] as IconData,
                      color: reward['iconColor'] as Color,
                      size: 24,
                    ),
                    label: loc.points,
                    isEditing: _isEditing,
                    pointsController: _controllers[index],
                  ),
                );
              },
            ),
            if (_isEditing) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: ColorManger.slateGrey.withValues(alpha: 0.4)),

                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      onPressed: _cancelEdit,
                      elevation: 0,
                      backgroundColor: ColorManger.pureWhite,
                      foregroundColor: ColorManger.black,
                      child: CustomText(
                        text: loc.cancel,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                        backgroundColor: ColorManger.brightPurple,
                        foregroundColor: ColorManger.pureWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        onPressed: _saveChanges,
                        child: CustomText(
                          text: loc.save,
                          textStyle: TextStyle(
                            color: ColorManger.pureWhite,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        )
                    ),
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}