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
    final parsedDate = email.receivedAt != null
        ? DateTime.tryParse(email.receivedAt!)
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
                    // Subject + date
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
                              color: unread
                                  ? ColorManger.black
                                  : ColorManger.grey800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          text: dateStr,
                          textStyle: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManger.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // From
                    CustomText(
                      text: l10n.inboundEmailFrom(email.from ?? ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textStyle: TextStyle(
                        fontSize: FontSize.s13,
                        color: ColorManger.grey600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Badges + action icons ─────────────────────────
                    Row(
                      children: [
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

                        // Mark as read
                        if (unread)
                          _actionIcon(
                            icon: Icons.mark_email_read_outlined,
                            color: ColorManger.successColor,
                            tooltip: l10n.inboundEmailMarkAsRead,
                            onTap: onMarkRead,
                          ),

                        if (!archived) ...[
                          const SizedBox(width: 4),
                          _actionIcon(
                            icon: Icons.archive_outlined,
                            color: ColorManger.orange,
                            tooltip: l10n.inboundEmailArchive,
                            onTap: onArchive,
                          ),
                        ],


                        const SizedBox(width: 4),
                        _actionIcon(
                          icon: Icons.delete_outline,
                          color: ColorManger.brightRed,
                          tooltip: l10n.inboundEmailDelete,
                          onTap: onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stops tap from bubbling up to the tile's InkWell ──────────────────
  Widget _actionIcon({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
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