import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';

class EmailDetailSheet extends StatelessWidget {
  final Items  email;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  const EmailDetailSheet({
    super.key,
    required this.email,
    required this.onArchive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parsedDate =
    email.createdAt != null ? DateTime.tryParse(email.createdAt!) : null;
    final dateStr = parsedDate != null
        ? DateFormat('MMM d, yyyy • h:mm a').format(parsedDate)
        : '';

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.35,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              color: ColorManger.pureWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: ColorManger.grey300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    text: email.subject ?? '',
                    textStyle: TextStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManger.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _infoRow(l10n.inboundEmailDetailFrom, email.fullName ?? ''),
                  _infoRow(l10n.inboundEmailDetailTo, email.email ?? ''),
                  _infoRow(l10n.inboundEmailDetailProvider, email.role ?? ''),
                  _infoRow(l10n.inboundEmailDetailReceived, dateStr),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (email.isArchived != true)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onArchive,
                            icon: const Icon(Icons.archive_outlined),
                            label: CustomText(text: l10n.inboundEmailArchive),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorManger.darkBlue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onDelete,
                          icon: Icon(Icons.delete_outline, color: ColorManger.brightRed),
                          label: CustomText(
                            text: l10n.inboundEmailDelete,
                            textStyle: TextStyle(color: ColorManger.brightRed),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: ColorManger.brightRed),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManger.grey500,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              text: value,
              textStyle: TextStyle(fontSize: FontSize.s12, color: ColorManger.darkBlue),
            ),
          ),
        ],
      ),
    );
  }
}