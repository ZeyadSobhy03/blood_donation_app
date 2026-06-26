import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/add_reward_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/points_configuration_header.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/custom_reward_tile.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/admin_rewards_data_model.dart';

class PointsConfigurationCard extends StatefulWidget {
  const PointsConfigurationCard({super.key, required this.items});

  final List<Items> items;

  @override
  State<PointsConfigurationCard> createState() => _PointsConfigurationCardState();
}

class _PointsConfigurationCardState extends State<PointsConfigurationCard> {
  bool _isEditing = false;

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controllers = widget.items
        .map((item) => TextEditingController(
              text: (item.pointsRequired ?? 0).toString(),
            ))
        .toList();
  }

  @override
  void didUpdateWidget(covariant PointsConfigurationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      for (final c in _controllers) {
        c.dispose();
      }
      _initControllers();
      if (_isEditing) {
        setState(() => _isEditing = false);
      }
    }
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
    for (int i = 0; i < widget.items.length; i++) {
      _controllers[i].text = (widget.items[i].pointsRequired ?? 0).toString();
    }
    setState(() => _isEditing = false);
  }

  void _saveChanges() {
    final List<Map<String, dynamic>> updates = [];
    for (int i = 0; i < widget.items.length; i++) {
      final parsed = int.tryParse(_controllers[i].text);
      if (parsed != null && parsed != widget.items[i].pointsRequired) {
        updates.add({
          'rewardId': widget.items[i].id ?? '',
          'pointsRequired': parsed,
        });
      }
    }

    if (updates.isNotEmpty) {
      context.read<AdminRewardsCubit>().updateRewardPoints(updates: updates);
    }
    setState(() => _isEditing = false);
  }

  Future<void> _openAddRewardDialog() async {
    final result = await showDialog<NewRewardResult>(
      context: context,
      builder: (context) => const AddRewardDialog(),
    );

    if (result == null || !mounted) return;

    context.read<AdminRewardsCubit>().createReward(
      rewardName: result.rewardName,
      rewardSubtitle: result.rewardSubtitle,
      category: result.rewardSubtitle,
      status: 'ACTIVE',
      pointsRequired: result.pointsRedeemed,
    );
  }

  IconData _categoryIcon(String? category) {
    switch (category?.toUpperCase()) {
      case 'FOOD':
        return Icons.local_cafe;
      case 'ENTERTAINMENT':
        return Icons.movie;
      case 'HEALTH':
        return Icons.card_giftcard;
      case 'MERCHANDISE':
        return Icons.bloodtype;
      case 'FITNESS':
        return Icons.fitness_center;
      default:
        return Icons.card_giftcard;
    }
  }

  Color _categoryColor(String? category) {
    switch (category?.toUpperCase()) {
      case 'FOOD':
        return ColorManger.lightAmber;
      case 'ENTERTAINMENT':
        return ColorManger.brightPurple;
      case 'HEALTH':
        return ColorManger.green;
      case 'MERCHANDISE':
        return ColorManger.brightRed;
      case 'FITNESS':
        return ColorManger.orange;
      default:
        return ColorManger.brightPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocListener<AdminRewardsCubit, AdminRewardsState>(
      listener: (context, state) {
        if (state is AdminRewardsPointsUpdateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc.updateSuccess)),
          );
          context.read<AdminRewardsCubit>().getAdminRewardsData();
        } else if (state is AdminRewardsCreateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc.operationSuccessful)),
          );
          context.read<AdminRewardsCubit>().getAdminRewardsData();
        } else if (state is AdminRewardsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizeError(state.error, loc))),
          );
        }
      },
      child: Card(
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
                itemCount: widget.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final reward = widget.items[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRewardTile(
                      rewardName: reward.rewardName ?? '',
                      rewardSubtitle: reward.category ?? '',
                      pointsRedeemed: reward.pointsRequired ?? 0,
                      prefixWidget: Icon(
                        _categoryIcon(reward.category),
                        color: _categoryColor(reward.category),
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
      ),
    );
  }
}