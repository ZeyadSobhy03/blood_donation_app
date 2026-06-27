import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/support_tickets/support_tickets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  State<SupportTicketReplyDialog> createState() => _SupportTicketReplyDialogState();
}

class _SupportTicketReplyDialogState extends State<SupportTicketReplyDialog> {
  final _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
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
            text: widget.loc.replySubmitted,
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
            text: widget.loc.unknownError,
            textStyle: TextStyle(color: ColorManger.pureWhite),
          ),
          backgroundColor: Colors.red,
        ),
      );
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.chat_bubble_outline, color: ColorManger.brightRed, size: 24),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.loc.reply,
                        textStyle: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManger.brightRed,
                        ),
                      ),
                      CustomText(
                        text: widget.loc.replyToTicket,
                        textStyle: TextStyle(
                          fontSize: FontSize.s13,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _replyController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: widget.loc.yourReply,
                  labelStyle: TextStyle(color: ColorManger.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: ColorManger.grey400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: ColorManger.brightRed),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    text: widget.loc.reply,
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
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
                    text: widget.loc.close,
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
