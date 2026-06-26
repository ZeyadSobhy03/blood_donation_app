import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/earning_rules_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import  'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_model.dart' ;

class ConfigurationTab extends StatefulWidget {
  const ConfigurationTab({super.key});

  @override
  State<ConfigurationTab> createState() => _ConfigurationTabState();
}

class _ConfigurationTabState extends State<ConfigurationTab> {
  List<Data> _cachedRules = [];

  @override
  void initState() {
    super.initState();
    context.read<AdminRewardsCubit>().getEarningRules();
  }

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;
    return BlocBuilder<AdminRewardsCubit, AdminRewardsState>(
      builder: (context, state) {
        if (state is AdminRewardsLoadingState && _cachedRules.isEmpty) {
          return CustomLoadingWidget(indicatorColor: ColorManger.brightPurple);
        }

        if (state is EarningRuleGetSuccessState) {
          _cachedRules = state.earningRuleModel.data ?? [];
        }

        if (state is AdminRewardsErrorState && _cachedRules.isEmpty) {
          log('Error fetching earning rules: ${state.error}');
          return CustomErrorWidget(
            message: localizeError(state.error, app),
            onRetry: () =>
                context.read<AdminRewardsCubit>().getEarningRules(),
          );
        }

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: EarningRulesCard(rules: _cachedRules),
            ),

            if (state is AdminRewardsLoadingState && _cachedRules.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  color: ColorManger.brightPurple,
                  backgroundColor:
                      ColorManger.lightPurple.withValues(alpha: 0.4),
                  minHeight: 3,
                ),
              ),
          ],
        );
      },
    );
  }
}
