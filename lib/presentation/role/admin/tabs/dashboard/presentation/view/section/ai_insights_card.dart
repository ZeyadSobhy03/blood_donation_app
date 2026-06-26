import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/insight_localizer.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import '../widgets/insight_card.dart';

class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightBlue,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.royalBlue.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.safety_check_outlined,
                  color: ColorManger.royalBlue,
                  size: 22,
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: appLocalization.aiInsights,
                  textStyle: TextStyle(
                    color: ColorManger.royalBlue,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            BlocBuilder<AnalyticsCubit, AnalyticsState>(
              builder: (context, state) {
                if (state is AnalyticsLoadingState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.royalBlue,
                  );
                }

                if (state is AnalyticsErrorState) {
                  return CustomErrorWidget(message: localizeError(state.errorMessage, appLocalization), onRetry: (){
                    context.read<AnalyticsCubit>().fetchAnalytics();
                  });
                }

                if (state is AnalyticsSuccessState) {
                  final insights =
                      state.analyticsModel.data?.aiInsights ?? [];

                  if (insights.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          appLocalization.noInsightsAvailable,
                          style: TextStyle(color: ColorManger.royalBlue),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: insights.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final insight = insights[index];
                      final localizedData = localizeInsight(
                        context,
                        insight.title ?? '',
                        insight.description ?? '',
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: InsightCard(
                          title: localizedData.title,
                          description: localizedData.description,
                          confidence: insight.confidence ?? 0,
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

    


}