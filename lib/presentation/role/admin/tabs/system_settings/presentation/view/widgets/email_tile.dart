import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';

class EmailTile extends StatelessWidget {
  final Items email;
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
    final parsedDate = email.createdAt != null
        ? DateTime.tryParse(email.createdAt!)
        : null;
    final dateStr = parsedDate != null
        ? DateFormat('MMM d, h:mm a').format(parsedDate)
        : '';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First row: Avatar + Subject + Date
              Row(
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
                        // Subject
                        CustomText(
                          text: email.subject ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textStyle: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: unread
                                ? FontWeightManager.bold
                                : FontWeightManager.medium,
                            color: unread
                                ? ColorManger.black
                                : ColorManger.grey800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // From
                        CustomText(
                          text: l10n.inboundEmailFrom(email.fullName ?? ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textStyle: TextStyle(
                            fontSize: FontSize.s13,
                            color: ColorManger.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: dateStr,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      color: ColorManger.grey600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Second row: Badges + Action buttons
              Row(
                children: [
                  // Badges on left
                  if (archived)
                    _badge(
                      l10n.inboundEmailArchivedBadge,
                      ColorManger.orange,
                    ),
                  if (unread) ...[
                    if (archived) const SizedBox(width: 6),
                    _badge(
                      l10n.inboundEmailUnreadBadge,
                      ColorManger.brightRed,
                    ),
                  ],
                  const Spacer(),
                  // Action buttons - ALWAYS VISIBLE, NEVER HIDDEN
                  _actionIcon(
                    icon: Icons.mark_email_read_outlined,
                    color: unread
                        ? ColorManger.successColor
                        : ColorManger.grey300,
                    tooltip: l10n.inboundEmailMarkAsRead,
                    onTap: onMarkRead,
                    isEnabled: unread,
                  ),
                  const SizedBox(width: 6),
                  _actionIcon(
                    icon: Icons.archive_outlined,
                    color: !archived
                        ? ColorManger.orange
                        : ColorManger.grey300,
                    tooltip: l10n.inboundEmailArchive,
                    onTap: !archived ? onArchive : () {},
                    isEnabled: !archived,
                  ),
                  const SizedBox(width: 6),
                  _actionIcon(
                    icon: Icons.delete_outline,
                    color: ColorManger.brightRed,
                    tooltip: l10n.inboundEmailDelete,
                    onTap: onDelete,
                    isEnabled: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionIcon({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isEnabled ? onTap : null,
      child: Tooltip(
        message: tooltip,
        child: Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(7),
          child: Icon(icon, size: 20, color: color),
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