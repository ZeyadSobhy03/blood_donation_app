import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/rewards_localizer.dart';
import '../../../../../../../../l10n/app_localizations.dart';

enum RewardStatus { active, inactive }

class RewardItem extends StatefulWidget {
  const RewardItem({
    super.key,
    required this.rewardId,
    required this.rewardName,
    required this.rewardCategory,
    required this.rewardPoints,
    required this.rewardRedeemed,
    this.initialStatus = RewardStatus.active,
    this.onStatusChanged,
  });

  final String rewardId;
  final String rewardName;
  final String rewardCategory;
  final int rewardPoints;
  final int rewardRedeemed;
  final RewardStatus initialStatus;
  final ValueChanged<RewardStatus>? onStatusChanged;

  @override
  State<RewardItem> createState() => _RewardItemState();
}

class _RewardItemState extends State<RewardItem> {
  late RewardStatus _status;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  bool get _isActive => _status == RewardStatus.active;

  void _handleSelect(RewardStatus status) {
    setState(() => _status = status);
    widget.onStatusChanged?.call(status);
  }

  void _showStatusMenu(BuildContext context, Offset position, AppLocalizations loc) async {
    final selected = await showMenu<RewardStatus>(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          value: RewardStatus.active,
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: ColorManger.green),
              const SizedBox(width: 8),
              CustomText(
                text: loc.setRewardActive,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: RewardStatus.inactive,
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.grey),
              const SizedBox(width: 8),
              CustomText(
                text: loc.setRewardInactive,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (selected != null) {
      _handleSelect(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final localizedData = localizeReward(
      context,
      rawTitle: widget.rewardName,
      rawCategory: widget.rewardCategory,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: localizedData.title,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s14,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomText(
                        text: localizedData.category,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    // Points
                    CustomText(
                      text: '${widget.rewardPoints} ${appLocalizations.point}',
                      textStyle: TextStyle(
                        color: ColorManger.brightPurple,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s12,
                      ),
                    ),
                    CustomText(
                      text: '${widget.rewardRedeemed} ${appLocalizations.redeemed}',
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Builder(
            builder: (context) {
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTapDown: (details) {
                  _tapPosition = details.globalPosition;
                },
                onTap: () {
                  if (_tapPosition != null) {
                    _showStatusMenu(context, _tapPosition!, appLocalizations);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _isActive
                        ? ColorManger.successBackground
                        : ColorManger.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: _isActive ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        text: _isActive
                            ? appLocalizations.rewardStatusActive
                            : appLocalizations.rewardStatusInactive,
                        textStyle: TextStyle(
                          color: _isActive ? Colors.green : Colors.grey,
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: _isActive ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}