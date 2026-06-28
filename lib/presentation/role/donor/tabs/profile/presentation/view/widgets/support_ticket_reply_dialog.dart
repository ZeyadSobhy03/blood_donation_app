import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/support_tickets/support_tickets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showSupportTicketReplyDialog(
    BuildContext context, Ticket ticket, AppLocalizations loc) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => SupportTicketReplyDialog(ticket: ticket, loc: loc),
  );
}

class SupportTicketReplyDialog extends StatefulWidget {
  final Ticket ticket;
  final AppLocalizations loc;

  const SupportTicketReplyDialog({
    super.key,
    required this.ticket,
    required this.loc,
  });

  @override
  State<SupportTicketReplyDialog> createState() =>
      _SupportTicketReplyDialogState();
}

class _SupportTicketReplyDialogState extends State<SupportTicketReplyDialog> {
  final _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
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

  String _localizeStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'open':
        return widget.loc.ticketOpen;
      case 'reviewed':
        return widget.loc.ticketReviewed;
      case 'closed':
        return widget.loc.ticketClosed;
      default:
        return status ?? '';
    }
  }

  Future<void> _submitReply(BuildContext context) async {
    final reply = _replyController.text.trim();
    if (reply.isEmpty) return;

    final cubit = context.read<SupportTicketsCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final success = await cubit.replyToTicket(widget.ticket.id ?? '', reply);

    if (!mounted) return;

    if (success) {
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: CustomText(
            text: widget.loc.supportTicketReplySentSnack,
            textStyle: TextStyle(color: ColorManger.pureWhite),
          ),
          backgroundColor: Colors.green,
        ),
      );
      cubit.fetchSupportTickets();
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: CustomText(
            text: widget.loc.supportTicketReplyErrorSnack,
            textStyle: TextStyle(color: ColorManger.pureWhite),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final loc = widget.loc;
    final hasAdminReply =
        ticket.adminReply != null && ticket.adminReply!.isNotEmpty;
    final hasDonorReply =
        ticket.donorReply != null && ticket.donorReply!.isNotEmpty;
    final hasAnyMessage = hasAdminReply || hasDonorReply;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: ticket.subject ?? '',
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.black,
                  ),
                ),
                const SizedBox(height: 6),
                CustomText(
                  text: '${loc.supportTicketFrom}: ${loc.admin}',
                  textStyle: TextStyle(
                    fontSize: FontSize.s13,
                    color: ColorManger.slateGrey,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: '${loc.supportTicketStatus}: ${_localizeStatus(ticket.status)}',
                  textStyle: TextStyle(
                    fontSize: FontSize.s13,
                    color: ColorManger.slateGrey,
                  ),
                ),
                if (hasAnyMessage) ...[
                  const SizedBox(height: 16),
                  Divider(color: ColorManger.grey400.withValues(alpha: 0.3)),
                  const SizedBox(height: 12),
                  if (hasAdminReply)
                    _ChatBubble(
                      message: ticket.adminReply!,
                      time: _formatTime(ticket.adminReplyAt),
                      isDonor: false,
                    ),
                  if (hasAdminReply && hasDonorReply)
                    const SizedBox(height: 10),
                  if (hasDonorReply)
                    _ChatBubble(
                      message: ticket.donorReply!,
                      time: _formatTime(ticket.donorReplyAt),
                      isDonor: true,
                    ),
                ],
                const SizedBox(height: 16),
                Divider(color: ColorManger.grey400.withValues(alpha: 0.3)),
                const SizedBox(height: 12),
                TextField(
                  controller: _replyController,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: loc.supportTicketReplyHint,
                    hintStyle: TextStyle(color: ColorManger.slateGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorManger.grey400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorManger.grey400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: ColorManger.brightRed, width: 1.5),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManger.brightRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _submitReply(context),
                    child: CustomText(
                      text: loc.supportTicketSendReply,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isDonor;

  const _ChatBubble({
    required this.message,
    required this.time,
    required this.isDonor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDonor ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDonor
              ? ColorManger.brightRed.withValues(alpha: 0.1)
              : ColorManger.lightGreyBorder.withValues(alpha: 0.4),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: isDonor
                ? const Radius.circular(14)
                : const Radius.circular(4),
            bottomRight: isDonor
                ? const Radius.circular(4)
                : const Radius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: message,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                color: isDonor ? ColorManger.brightRed : ColorManger.black,
              ),
            ),
            const SizedBox(height: 4),
            CustomText(
              text: time,
              textStyle: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManger.slateGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
