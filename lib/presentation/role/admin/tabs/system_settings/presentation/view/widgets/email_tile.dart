import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';

class EmailTile extends StatelessWidget {
  final InboundEmails email;
  final VoidCallback onTap;
  final VoidCallback onMarkRead;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  const EmailTile({
    super.key,
    required this.email,
    required this.onTap,
    required this.onMarkRead,
    required this.onArchive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parsedDate =
    email.receivedAt != null ? DateTime.tryParse(email.receivedAt!) : null;
    final dateStr =
    parsedDate != null ? DateFormat('MMM d, h:mm a').format(parsedDate) : '';
    final unread = email.isRead != true;
    final archived = email.isArchived == true;

    return Material(
      color: unread
          ? ColorManger.brightRed.withValues(alpha: 0.04)
          : ColorManger.pureWhite,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ColorManger.grey100),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: unread
                    ? ColorManger.brightRed.withValues(alpha: 0.12)
                    : ColorManger.grey100,
                child: Icon(
                  Icons.mail_outline,
                  color: unread ? ColorManger.brightRed : ColorManger.grey600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: email.subject ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textStyle: TextStyle(
                              fontSize: FontSize.s15,
                              fontWeight: unread
                                  ? FontWeightManager.bold
                                  : FontWeightManager.medium,
                              color:
                              unread ? ColorManger.black : ColorManger.grey800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          text: dateStr,
                          textStyle:
                          TextStyle(fontSize: FontSize.s12, color: ColorManger.grey600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: l10n.inboundEmailFrom(email.from ?? ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textStyle:
                      TextStyle(fontSize: FontSize.s13, color: ColorManger.grey600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (archived)
                          _badge(l10n.inboundEmailArchivedBadge, ColorManger.orange),
                        if (unread) ...[
                          if (archived) const SizedBox(width: 6),
                          _badge(l10n.inboundEmailUnreadBadge, ColorManger.brightRed),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: ColorManger.pureWhite,
                icon: Icon(Icons.more_vert, color: ColorManger.grey600),
                onSelected: (value) {
                  switch (value) {
                    case 'read':
                      onMarkRead();
                      break;
                    case 'archive':
                      onArchive();
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (unread)
                    PopupMenuItem(
                      value: 'read',
                      child: Row(
                        children: [
                          const Icon(Icons.mark_email_read_outlined, size: 18),
                          const SizedBox(width: 8),
                          CustomText(text: l10n.inboundEmailMarkAsRead),
                        ],
                      ),
                    ),
                  if (!archived)
                    PopupMenuItem(
                      value: 'archive',
                      child: Row(
                        children: [
                          const Icon(Icons.archive_outlined, size: 18),
                          const SizedBox(width: 8),
                          CustomText(text: l10n.inboundEmailArchive),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: ColorManger.brightRed),
                        const SizedBox(width: 8),
                        CustomText(
                          text: l10n.inboundEmailDelete,
                          textStyle: TextStyle(color: ColorManger.brightRed),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: text,
        textStyle: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: color,
        ),
      ),
    );
  }
}