
import 'package:blood_donation_app/core/resources/models/donor.dart';

import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_navigation_button.dart';

import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/contact_tile.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../l10n/app_localizations.dart';

class ContactDonorBody extends StatelessWidget {
  const ContactDonorBody({super.key, required this.donor});

  final DonorModel donor;

  @override
  Widget build(BuildContext context) {
    void callDonor(String phoneNumber) async {
      final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
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
        queryParameters: {'subject': subject, 'body': body},
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

    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        ContactTile(
          buttonText: appLocalization.call,
          icon: Icons.phone,
          label: appLocalization.phone,
          value: donor.phoneNumber,
          onPressed: () {
            callDonor(donor.phoneNumber);
          },
        ),
        SizedBox(height: 8),

        ContactTile(
          buttonText: appLocalization.email,
          icon: Icons.email,
          label: appLocalization.email,
          value: donor.email,
          onPressed: () {
            sendEmail(
              donor.email,
              appLocalization.donationMessage,
              appLocalization.donationMessage,
            );
          },
        ),
        SizedBox(height: 8),
        ContactTile(
          buttonText: appLocalization.message,
          icon: Icons.message,
          label: appLocalization.message,
          value: donor.phoneNumber,
          onPressed: () {
            sendWhatsapp(
              donor.phoneNumber,
              appLocalization.emergency_whatsapp_message(
                donor.name,
                donor.bloodType,
              ),
            );
          },
        ),
        SizedBox(height: 8),
        NoteCard(),
        SizedBox(height: 16),
        ContactNavigationButton(onSendRequest: (){}),
      ],
    );
  }
}
