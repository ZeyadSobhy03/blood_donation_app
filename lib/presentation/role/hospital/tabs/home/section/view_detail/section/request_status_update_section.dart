import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../request/data/model/request_enum_mapper.dart';
import '../../../widgets/request_action_buttons.dart';
import '../../../presentation/view_model/home_view_model.dart';

class RequestStatusUpdateSection extends StatefulWidget {
  const RequestStatusUpdateSection({
    super.key,
    required this.requestId,
    this.currentStatusKey,
  });

  final String requestId;
  final String? currentStatusKey;

  @override
  State<RequestStatusUpdateSection> createState() =>
      _RequestStatusUpdateSectionState();
}

class _RequestStatusUpdateSectionState
    extends State<RequestStatusUpdateSection> {
  String? _selectedStatusDisplay;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final statusOptions = RequestEnumMapper.editableStatusDisplayOptions(loc);

    _selectedStatusDisplay ??= RequestEnumMapper.statusKeyToDisplay(
      widget.currentStatusKey,
      loc,
    );
    if (!statusOptions.contains(_selectedStatusDisplay)) {
      _selectedStatusDisplay = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: loc.requestStatusLabel),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: _selectedStatusDisplay,
          items: statusOptions
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) => setState(() => _selectedStatusDisplay = value),
          decoration: InputDecoration(
            hintText: loc.selectStatus,
            filled: true,
            fillColor: ColorManger.textFormFieldGrey,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManger.lightGrey),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is RequestActionSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.of(context).pop();
            } else if (state is RequestActionErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is RequestActionLoadingState;
            return Row(
              children: [
                Expanded(
                  child: RequestActionButtons(
                    text: isLoading ? loc.processing : loc.updateStatus,
                    backgroundColor: ColorManger.royalBlue,
                    foregroundColor: ColorManger.pureWhite,
                    borderColor: ColorManger.royalBlue,
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_selectedStatusDisplay == null) return;
                            final statusKey =
                                RequestEnumMapper.editableStatusDisplayToKey(
                              _selectedStatusDisplay,
                              loc,
                            );
                            context.read<HomeCubit>().updateRequestStatus(
                                  requestId: widget.requestId,
                                  status: statusKey,
                                );
                          },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: RequestActionButtons(
                    text: loc.cancelRequestBtn,
                    backgroundColor: ColorManger.pureWhite,
                    foregroundColor: ColorManger.brightRed,
                    borderColor: ColorManger.brightRed,
                    onPressed: isLoading
                        ? null
                        : () => _confirmCancel(context, loc),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _confirmCancel(BuildContext context, AppLocalizations loc) {
    final homeCubit = context.read<HomeCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: CustomText(
          text: loc.cancelRequestBtn,
          textStyle: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.bold,
            color: ColorManger.black,
          ),
        ),
        content: CustomText(
          text: loc.cancelRequestConfirmation,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(loc.keepRequest),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              homeCubit.cancelRequest(widget.requestId);
            },
            child: Text(
              loc.yesCancelRequest,
              style: TextStyle(color: ColorManger.brightRed),
            ),
          ),
        ],
      ),
    );
  }
}
