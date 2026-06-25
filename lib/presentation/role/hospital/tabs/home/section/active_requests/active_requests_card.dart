import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../data/models/home_requests_model.dart';
import '../../presentation/view_model/home_view_model.dart';
import 'active_request_card.dart';
import 'all_requests_screen.dart';

class ActiveRequestsCard extends StatelessWidget {
  const ActiveRequestsCard({
    super.key,
    required this.requests,
    this.maxVisible = 2,
  });

  final List<HomeRequestItem> requests;
  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (requests.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: CustomText(
          text: appLocalizations.noActiveRequests,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      );
    }

    final visibleRequests = requests.take(maxVisible).toList();
    final hasMore = requests.length > maxVisible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleRequests.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) =>
              ActiveRequestCard(request: visibleRequests[index]),
        ),
        if (hasMore) ...[
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<HomeCubit>(),
                      child: const AllRequestsScreen(),
                    ),
                  ),
                );
              },
              child: CustomText(
                text: appLocalizations.viewAll,
                textStyle: TextStyle(
                  color: ColorManger.royalBlue,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
