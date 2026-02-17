import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/two_factor_authentication/widgets/info_box.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/two_factor_authentication/widgets/header_banner.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/two_factor_authentication/widgets/options_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sheets/setup_bottom_sheet.dart';

class TwoFactorAuthenticationScreen extends StatefulWidget {
  const TwoFactorAuthenticationScreen({super.key});

  @override
  State<TwoFactorAuthenticationScreen> createState() =>
      _TwoFactorAuthenticationScreenState();
}

class _TwoFactorAuthenticationScreenState
    extends State<TwoFactorAuthenticationScreen> {

  bool _isSmsEnabled = false;
  bool _isAuthAppEnabled = false;
  bool _isEmailEnabled = false;


  void _handleToggle(String method, bool value)  {


    setState(() {
      if (method == 'sms') _isSmsEnabled = value;
      if (method == 'app') _isAuthAppEnabled = value;
      if (method == 'email') _isEmailEnabled = value;
    });

    if (value) _showSetupBottomSheet(method);
  }

  void _showSetupBottomSheet(String method) {
    final appLocalization=AppLocalizations.of(context)!;
    String title = '';
    String description = '';
    IconData icon = Icons.security;

    switch (method) {
      case 'sms':
        title = appLocalization.smsVerificationTitle;
        description =
        appLocalization.smsVerificationSubtitle;
        icon = Icons.sms_outlined;
        break;
      case 'app':
        title = appLocalization.authAppTitle;
        description =
        appLocalization.authAppSubtitle;
        icon = Icons.apps_outlined;
        break;
      case 'email':
        title = appLocalization.emailVerificationTitle;
        description =
        appLocalization.emailVerificationSubtitle;
        icon = Icons.email_outlined;
        break;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SetupBottomSheet(
        title: title,
        description: description,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.transparent,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,
              color: ColorManger.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          text: appLocalization.twoFactorAuthTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: FontSize.s16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderBanner(),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                child: CustomText(
                  text: appLocalization.verificationMethods,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s12,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              OptionsCard(
                isSmsEnabled: _isSmsEnabled,
                isAuthAppEnabled: _isAuthAppEnabled,
                isEmailEnabled: _isEmailEnabled,
                onToggle: _handleToggle,
              ),

              SizedBox(height: 24.h),
              const InfoBox(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
