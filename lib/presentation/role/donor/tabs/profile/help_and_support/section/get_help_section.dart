
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/help_and_support/widgets/tiles/help_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class GetHelpSection extends StatelessWidget {
  const GetHelpSection({super.key});

  @override
  Widget build(BuildContext context) {
      final appLocalization=AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: EdgeInsets.all(16.w.clamp(12, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.getHelp,
              textStyle: TextStyle(
                color: ColorManger.darkBlue,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 12.h),

            HelpOptionTile(
              icon: Icons.chat_bubble_outline_rounded,
              title: appLocalization.contactSupport,
              subtitle: appLocalization.chatSupport,
              onTap: () {
                sendWhatsapp("+201141935341", appLocalization.whatsappHelpMessage);
              },
            ),
            HelpOptionTile(
              icon: Icons.email_outlined,
              title: appLocalization.emailUs,
              subtitle: 'support@lifelink.com',
              onTap: () {
                sendEmail(
                  'ziad60189@gmail.com',
                  appLocalization.documentationRequestSubject,
                  appLocalization.emailBodyRequestDocumentation,
                );
              },
            ),
            HelpOptionTile(
              icon: Icons.description_outlined,
              title: appLocalization.documentation,
              subtitle: appLocalization.userGuides,
              onTap: () {
                Navigator.pushNamed(context, RouteManger.pdfViewer);

              },
            ),
          ],
        ),
      ),
    );
  }

  void sendWhatsapp(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  void sendEmail(String email, String subject, String body) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      return;
    }

    final Uri gmailWeb = Uri.parse(
      'https://mail.google.com/mail/?view=cm&to=$email&su=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    if (await canLaunchUrl(gmailWeb)) {
      await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch any email client.');
    }
  }




}
