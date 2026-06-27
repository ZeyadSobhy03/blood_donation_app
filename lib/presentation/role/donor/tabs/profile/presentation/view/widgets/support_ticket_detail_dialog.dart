import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/widgets/support_ticket_reply_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSupportTicketDetailDialog(
    BuildContext context, Ticket ticket, AppLocalizations loc) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => SupportTicketDetailDialog(ticket: ticket, loc: loc),
  );
}

class SupportTicketDetailDialog extends StatelessWidget {
  final Ticket ticket;
  final AppLocalizations loc;

  const SupportTicketDetailDialog({
    super.key,
    required this.ticket,
    required this.loc,
  });

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('d/M/yyyy').format(dt);
    } catch (_) {
      return '';
    }
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('h:mm a').format(dt);
    } catch (_) {
      return '';
    }
  }

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'reviewed':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _localizeStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'open':
        return loc.ticketOpen;
      case 'reviewed':
        return loc.ticketReviewed;
      case 'closed':
        return loc.ticketClosed;
      default:
        return status ?? '';
    }
  }

  String _localizeCategory(String? category) {
    switch (category?.toUpperCase()) {
      case 'ACCOUNT':
        return loc.accountManagement;
      case 'TECHNICAL':
        return loc.technicalIssue;
      case 'DONATION':
        return loc.donationProcess;
      case 'REWARDS':
        return loc.rewardsPoint;
      case 'OTHER':
        return loc.other;
      default:
        return category ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.receipt, color: ColorManger.brightRed, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: loc.ticketDetails,
                          textStyle: TextStyle(
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManger.black,
                          ),
                        ),
                        CustomText(
                          text: loc.ticketDetailsSubtitle,
                          textStyle: TextStyle(
                            fontSize: FontSize.s13,
                            color: ColorManger.slateGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorManger.lightGreyBorder.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: ticket.subject ?? '',
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManger.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(ticket.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _statusColor(ticket.status).withValues(alpha: 0.3)),
                      ),
                      child: CustomText(
                        text: _localizeStatus(ticket.status),
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          color: _statusColor(ticket.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorManger.lightGreyBorder.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: loc.category,
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: _localizeCategory(ticket.category),
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManger.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorManger.lightGreyBorder.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: loc.createdAt,
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: _formatDate(ticket.createdAt),
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManger.black,
                            ),
                          ),
                          CustomText(
                            text: _formatTime(ticket.createdAt),
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (ticket.message != null && ticket.message!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManger.lightGreyBorder.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 16, color: ColorManger.slateGrey),
                          const SizedBox(width: 6),
                          CustomText(
                            text: loc.messageLabel,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomText(
                        text: ticket.message!,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (ticket.adminReply != null && ticket.adminReply!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorManger.brightRed.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shield, size: 16, color: ColorManger.brightRed),
                          const SizedBox(width: 6),
                          CustomText(
                            text: loc.adminReply,
                            textStyle: TextStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManger.brightRed,
                            ),
                          ),
                          const Spacer(),
                          CustomText(
                            text: _formatTime(ticket.adminReplyAt),
                            textStyle: TextStyle(
                              fontSize: FontSize.s12,
                              color: ColorManger.slateGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomText(
                        text: ticket.adminReply!,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  if (ticket.status?.toLowerCase() == 'reviewed')
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManger.brightRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showSupportTicketReplyDialog(context, ticket, loc);
                        },
                        child: CustomText(
                          text: loc.reply,
                          textStyle: TextStyle(
                            color: ColorManger.pureWhite,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                  if (ticket.status?.toLowerCase() == 'reviewed')
                    const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorManger.grey400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        text: loc.close,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s14,
                        ),
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
  }
}
