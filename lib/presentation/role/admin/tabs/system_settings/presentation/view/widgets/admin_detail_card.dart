import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/profile/admin_profile_view_model.dart';
import 'admin_profile_tail.dart';
import 'edit_admin_dialog.dart';

class AdminDetailCard extends StatefulWidget {
  const AdminDetailCard({super.key});

  @override
  State<AdminDetailCard> createState() => _AdminDetailCardState();
}

class _AdminDetailCardState extends State<AdminDetailCard> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProfileCubit>().fetchAdminProfile();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<AdminProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState || state is ProfileInitialState) {
          return CustomLoadingWidget(
            indicatorColor: ColorManger.brightPurple,
          );
        }

        if (state is ProfileErrorState) {
          return CustomErrorWidget(message: localizeError(state.errorKey,appLocalization), onRetry: (){
              context.read<AdminProfileCubit>().fetchAdminProfile();
          });
        }

        final admin = (state as ProfileSuccessState).profile.data?.admin;

        final adminName = admin?.fullName ?? '-';
        final adminPosition = admin?.role ?? '-';

        final items = [
          {
            "label": appLocalization.email,
            "value": admin?.email ?? '-',
            "icon": null,
          },
          {
            "label": appLocalization.phone,
            "value": admin?.phone?.toString() ?? '-',
            "icon": Icons.phone_outlined,
          },
          {
            "label": appLocalization.admin_access_key,
            "value": admin?.role?? '-',
            "icon": Icons.key_outlined,
          },
          // {
          //   "label": appLocalization.department,
          //   "value": admin?. == true
          //       ? appLocalization.suspended
          //       : appLocalization.active,
          //   "icon": Icons.apartment_outlined,
          // },
        ];

        return Card(
          elevation: 0,
          color: ColorManger.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: ColorManger.green),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManger.green,
                      foregroundColor: ColorManger.pureWhite,
                      radius: 24,
                      child: Icon(Icons.person_outline_outlined),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: adminName,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManger.green,
                            ),
                          ),
                          SizedBox(height: 2),
                          CustomText(
                            text: adminPosition,
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManger.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    CustomElevatedButton(
                      elevation: 0,
                      foregroundColor: ColorManger.green,
                      backgroundColor: ColorManger.pureWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: ColorManger.green, width: 1.1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditAdminDialog();
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_outline_outlined, size: 16),
                          SizedBox(width: 4),
                          CustomText(
                            text: appLocalization.editProfile,
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManger.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AdminProfileTail(
                            label: items[0]['label'] as String,
                            value: items[0]['value'] as String,
                            icon: items[0]['icon'] as IconData?,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: AdminProfileTail(
                            label: items[1]['label'] as String,
                            value: items[1]['value'] as String,
                            icon: items[1]['icon'] as IconData?,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: AdminProfileTail(
                            label: items[2]['label'] as String,
                            value: items[2]['value'] as String,
                            icon: items[2]['icon'] as IconData?,
                          ),
                        ),
                        SizedBox(width: 8),

                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}