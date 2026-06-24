import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../donate/presentation/view/widgets/title_colum.dart';
import '../sections/password_and_security_card.dart';


class PrivacyAndSecurity extends StatelessWidget {
  const PrivacyAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.zero,
        backgroundColor: ColorManger.brightRed,
        foregroundColor: ColorManger.pureWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: TitleColum(
          title: appLocalization.privacy_Security,
          subTitle: appLocalization.mange_your_privacy_settings,
        ),
      ),
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [PasswordAndSecurityCard()]),
        ),
      ),
    );
  }
}
