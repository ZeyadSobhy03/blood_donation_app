
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/choose_role/section/role_card.dart';

import 'package:blood_donation_app/presentation/choose_role/section/role_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          if (!isWide) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        SizedBox(height: 20.h),
                        TitleRole(
                          roleTitle: appLocalization.choose_role_title,
                          roleSubTitle: appLocalization.choose_role_subTitle,
                        ),
                        SizedBox(height: 8.h),
                        RoleCard(
                          icon: Icons.favorite_border_outlined,
                          borderColor: ColorManger.brightRed.withValues(
                            alpha: 0.2,
                          ),
                          iconColor: ColorManger.brightRed,
                          cardTitle: appLocalization.role_blood_donor_title,
                          cardDesc: appLocalization.role_blood_donor_desc,
                          text: appLocalization.role_blood_donor_button,
                          onPressed: ()=>Navigator.pushNamed(context, RouteManger.donorLogin),
                        ),
                        RoleCard(
                          icon: Icons.local_hospital,
                          borderColor: ColorManger.royalBlue.withValues(
                            alpha: 0.2,
                          ),
                          iconColor: ColorManger.royalBlue,
                          cardTitle: appLocalization.role_hospital_title,
                          cardDesc: appLocalization.role_hospital_desc,
                          text: appLocalization.role_hospital_button,
                          onPressed: ()=>Navigator.pushNamed(context, RouteManger.hospitalAuth),
                        ),
                        RoleCard(
                          borderColor: ColorManger.green.withValues(alpha: 0.2),
                          icon: Icons.admin_panel_settings,
                          iconColor: ColorManger.green,
                          cardTitle: appLocalization.role_admin_title,
                          cardDesc: appLocalization.role_admin_desc,
                          text: appLocalization.role_admin_button,
                          onPressed: ()=>Navigator.pushNamed(context, RouteManger.adminAuth),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(height: 20.h),
                      TitleRole(
                        roleTitle: appLocalization.choose_role_title,
                        roleSubTitle: appLocalization.choose_role_subTitle,

                      ),
                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Expanded(
                            child: RoleCard(
                              icon: Icons.favorite_border_outlined,
                              borderColor: ColorManger.brightRed.withValues(
                                alpha: 0.2,
                              ),
                              iconColor: ColorManger.brightRed,
                              cardTitle: appLocalization.role_blood_donor_title,
                              cardDesc: appLocalization.role_blood_donor_desc,
                              text: appLocalization.role_blood_donor_button,
                              onPressed: ()=>Navigator.pushNamed(context, RouteManger.donorLogin),
                            ),
                          ),
                          Expanded(
                            child: RoleCard(
                              icon: Icons.local_hospital,
                              borderColor: ColorManger.royalBlue.withValues(
                                alpha: 0.2,
                              ),
                              iconColor: ColorManger.royalBlue,
                              cardTitle: appLocalization.role_hospital_title,
                              cardDesc: appLocalization.role_hospital_desc,
                              text: appLocalization.role_hospital_button,
                              onPressed: ()=>Navigator.pushNamed(context, RouteManger.hospitalAuth),
                            ),
                          ),
                        ],
                      ),

                      RoleCard(
                        borderColor: ColorManger.green.withValues(alpha: 0.2),
                        icon: Icons.admin_panel_settings,
                        iconColor: ColorManger.green,
                        cardTitle: appLocalization.role_admin_title,
                        cardDesc: appLocalization.role_admin_desc,
                        text: appLocalization.role_admin_button,
                        onPressed: ()=>Navigator.pushNamed(context, RouteManger.adminAuth),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
