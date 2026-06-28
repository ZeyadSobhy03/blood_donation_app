import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../presentation/view_model/home_view_model.dart';
import 'section/available_donor_card.dart';
import 'section/request_info.dart';
import '../request_header.dart';

class ContactDonorDialog extends StatefulWidget {
  const ContactDonorDialog({
    super.key,
    required this.requestId,
    this.bloodType,
    this.unitsNeeded,
    this.urgencyDisplay,
  });

  final String requestId;
  final String? bloodType;
  final int? unitsNeeded;
  final String? urgencyDisplay;

  @override
  State<ContactDonorDialog> createState() => _ContactDonorDialogState();
}

class _ContactDonorDialogState extends State<ContactDonorDialog> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchRequestResponses(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: ColorManger.pureWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDialogHeader(
                  title: appLocalizations.contact_donor,
                  subtitle: appLocalizations.contact_donor_desc,
                ),
                SizedBox(height: 16.h),
                if (widget.bloodType != null &&
                    widget.unitsNeeded != null &&
                    widget.urgencyDisplay != null) ...[
                  RequestInfo(
                    bloodType: widget.bloodType!,
                    unitsNeeded: widget.unitsNeeded!,
                    urgency: widget.urgencyDisplay!,
                  ),
                  SizedBox(height: 16.h),
                ],
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is RequestResponsesLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is RequestResponsesErrorState) {
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

                    if (state is RequestResponsesLoadedState &&
                        state.requestId == widget.requestId) {
                      final donors = state.donors;

                      if (donors.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CustomText(
                              text: appLocalizations.noResponsesYet,
                              textStyle: TextStyle(color: ColorManger.slateGrey),
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(
                            text: appLocalizations.available_donors(donors.length),
                          ),
                          SizedBox(height: 8.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: donors.length,
                            itemBuilder: (context, index) {
                              return AvailableDonorCard(donor: donors[index]);
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: ColorManger.pureWhite,
                      foregroundColor: ColorManger.black,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: ColorManger.lightGrey.withValues(alpha: 0.5),
                        ),
                      ),
                      child: CustomText(text: appLocalizations.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
