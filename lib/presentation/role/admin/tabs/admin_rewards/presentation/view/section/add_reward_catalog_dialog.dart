
import 'dart:developer';

import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _rewardNameController = TextEditingController();
  final _pointsController = TextEditingController();

  String? _selectedStatus;
  String? _selectedCategory;

  @override
  void dispose() {
    _rewardNameController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  String _getApiCategory(String localizedCategory, AppLocalizations loc) {
    if (localizedCategory == loc.rewardCategoryHealth) return 'HEALTH';
    if (localizedCategory == loc.rewardCategoryStatus) return 'STATUS';
    if (localizedCategory == loc.rewardCategoryFood) return 'FOOD';
    if (localizedCategory == loc.rewardCategoryEntertainment) return 'ENTERTAINMENT';
    return 'STATUS'; // Fallback
  }

  void _handleAddReward() {
    if (!_formKey.currentState!.validate()) return;

    final loc = AppLocalizations.of(context)!;

    if (_selectedStatus == null || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.fieldRequired)),
      );
      return;
    }

    final status = _selectedStatus == loc.active ? 'ACTIVE' : 'INACTIVE';
    final apiCategory = _getApiCategory(_selectedCategory!, loc);

    context.read<AdminRewardsCubit>().createReward(
      rewardName: _rewardNameController.text.trim(),
      rewardSubtitle: _selectedCategory!,
      category: apiCategory,
      status: status,
      pointsRequired: int.parse(_pointsController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    List<String> statusItems = [loc.active, loc.inactive];

    List<String> categoryItems = [
      loc.rewardCategoryHealth,
      loc.rewardCategoryStatus,
      loc.rewardCategoryFood,
      loc.rewardCategoryEntertainment,
    ];

    return BlocListener<AdminRewardsCubit, AdminRewardsState>(
      listener: (context, state) {
        if (state is AdminRewardsCreateSuccessState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loc.operationSuccessful,
                style: TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: ColorManger.green,
            ),
          );
          context.read<AdminRewardsCubit>().getAdminRewardsData();
        } else if (state is RewardOperationErrorState) {
          log('RewardOperationErrorState: ${state.error}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizeError(state.error, loc)),
              backgroundColor: ColorManger.brightRed,
            ),
          );
        }
      },
      child: Dialog(
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDialogHeader(
                      title: loc.addNewReward,
                      subtitle: loc.addNewRewardSubtitle,
                    ),
                    SizedBox(height: 20),

                    CustomLabel(text: loc.rewardName),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      hintText: loc.enterRewardName,
                      textEditingController: _rewardNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return loc.fieldRequired;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 4),

                    CustomLabel(text: loc.category),
                    SizedBox(height: 4),
                    CustomDropDownButtonFormField(
                      onChanged: (value) {
                        setState(() => _selectedCategory = value);
                      },
                      items: categoryItems,
                      hintText: loc.enterRewardCategory,
                    ),
                    SizedBox(height: 4),

                    CustomLabel(text: loc.pointsRequired),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      hintText: loc.enterPointsRequired,
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
                    SizedBox(height: 4),

                    CustomLabel(text: loc.initialState),
                    SizedBox(height: 4),
                    CustomDropDownButtonFormField(
                      onChanged: (value) {
                        setState(() => _selectedStatus = value);
                      },
                      items: statusItems,
                      hintText: loc.selectState,
                    ),
                    SizedBox(height: 20),

                    BlocBuilder<AdminRewardsCubit, AdminRewardsState>(
                      buildWhen: (previous, current) =>
                          current is RewardOperationLoadingState ||
                          current is RewardOperationErrorState ||
                          current is AdminRewardsCreateSuccessState,
                      builder: (context, state) {
                        final isLoading = state is RewardOperationLoadingState;
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
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
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.of(context).pop(),
                                child: CustomText(text: loc.cancel),
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              flex: 2,
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
                                onPressed: isLoading ? null : _handleAddReward,
                                child: isLoading
                                    ? SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorManger.pureWhite,
                                  ),
                                )
                                    : Row(
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}