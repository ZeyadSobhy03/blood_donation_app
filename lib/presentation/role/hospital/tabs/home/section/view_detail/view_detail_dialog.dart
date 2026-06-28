import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../request_header.dart';
import '../../presentation/view_model/home_view_model.dart';
import 'section/request_detail_body.dart';

class ViewDetailDialog extends StatefulWidget {
  const ViewDetailDialog({
    super.key,
    required this.requestId,
  });

  final String requestId;

  @override
  State<ViewDetailDialog> createState() => _ViewDetailDialogState();
}

class _ViewDetailDialogState extends State<ViewDetailDialog> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchRequestDetail(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDialogHeader(
                  title: appLocalizations.request_details,
                  subtitle: appLocalizations.request_details_desc,
                ),
                SizedBox(height: 16.h),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is RequestDetailLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CustomLoadingWidget(indicatorColor: Colors.blueAccent,)),
                      );
                    }

                    if (state is RequestDetailErrorState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: CustomText(
                            text: state.message,
                            textStyle: TextStyle(color: ColorManger.brightRed),
                          ),
                        ),
                      );
                    }

                    if (state is RequestDetailLoadedState &&
                        state.requestId == widget.requestId) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RequestDetailBody(detail: state.detail),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: CustomText(
                      text: appLocalizations.close,
                      textStyle: TextStyle(
                        color: ColorManger.royalBlue,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
