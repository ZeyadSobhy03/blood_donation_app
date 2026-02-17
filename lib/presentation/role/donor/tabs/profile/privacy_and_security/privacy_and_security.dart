import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/title_colum.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/password_and_security_card.dart';
import 'package:flutter/material.dart';

class PrivacyAndSecurity extends StatelessWidget {
  const PrivacyAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: 'Privacy & Security',
          subTitle: 'Manage your privacy settings',
        ),
      ),
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(



          child: Column(

            children: [
              PasswordAndSecurityCard(),







            ],
          ),
        ),
      ),
    );
  }
}
