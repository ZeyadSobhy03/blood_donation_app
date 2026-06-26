import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/recent_adjustments_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class RecentAdjustmentsCard extends StatelessWidget {
  const RecentAdjustmentsCard({super.key, required this.adjustments});

  final List<Adjustments> adjustments;

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      return DateFormat('MMM d').format(date);
    } catch (_) {
      return dateStr;
    }
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.recentAdjustments,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            const SizedBox(height: 12),
            if (adjustments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: CustomText(
                    text: loc.noDataFound,
                    textStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: adjustments.length,
                itemBuilder: (context, index) {
                  final adjustment = adjustments[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RecentAdjustmentsTile(
                      userName: adjustment.userName ?? '',
                      reason: adjustment.reason ?? '',
                      points: adjustment.points ?? 0,
                      date: _formatDate(adjustment.date),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}