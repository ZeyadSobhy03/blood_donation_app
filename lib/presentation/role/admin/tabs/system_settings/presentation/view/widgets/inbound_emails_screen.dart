import 'dart:async';
import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/email_localizer.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';
import '../../view_model/inbound_email/inbound_email_view_model.dart';
import 'email_detail_sheet.dart';
import 'email_tile.dart';

enum EmailFilter { all, unread, archived }
class _ChatBubbleData {
  final String text;
  final bool isAdmin;
  final String? time;

  _ChatBubbleData({required this.text, required this.isAdmin, this.time});
}
class InboundEmailsScreen extends StatefulWidget {
  const InboundEmailsScreen({super.key});

  @override
  State<InboundEmailsScreen> createState() => _InboundEmailsScreenState();
}

class _InboundEmailsScreenState extends State<InboundEmailsScreen> {
  EmailFilter _filter = EmailFilter.all;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<InboundEmailCubit>().fetchInboundEmails();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<InboundEmailCubit>().loadMoreInboundEmails();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<InboundEmailCubit>().fetchInboundEmails(
        search: value.trim().isEmpty ? null : value.trim(),
      );
    });
  }

  List<Items> _applyFilter(List<Items> items) {
    switch (_filter) {
      case EmailFilter.unread:
        return items
            .where((item) => item.isRead != true && item.isArchived != true)
            .toList();
      case EmailFilter.archived:
        return items.where((item) => item.isArchived == true).toList();
      case EmailFilter.all:
        return items.where((item) => item.isArchived != true).toList();
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: ColorManger.green,
          content: Text(msg,style: TextStyle(
color: ColorManger.pureWhite
          ),), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _confirmDelete(
      Items email,
      AppLocalizations l10n,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: AlertDialog(
          backgroundColor: ColorManger.pureWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: CustomText(text: l10n.inboundEmailDeleteTitle),
          content: CustomText(
            text: l10n.inboundEmailDeleteConfirm(email.subject ?? ''),
          ),
          actions: [
            CustomElevatedButton(
              backgroundColor: ColorManger.grey300,
              foregroundColor: ColorManger.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              onPressed: () => Navigator.pop(context, false),
              child: CustomText(text: l10n.inboundEmailCancel),
            ),
            CustomElevatedButton(
              backgroundColor: ColorManger.brightRed,
              foregroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              onPressed: () => Navigator.pop(context, true),
              child: CustomText(
                text: l10n.inboundEmailDelete,
              ),
            ),
          ],
        ),
      ),
    );
    if (confirmed == true && email.id != null) {
      context.read<InboundEmailCubit>().deleteInboundEmail(emailId: email.id!);
    }
  }

  void _openDetail(Items email) {
    if (email.isRead != true && email.id != null) {
      context.read<InboundEmailCubit>().markAsReadInboundEmail(
        emailId: email.id!,
      );
    }

    if (email.type == 'supportTicket') {
      _openTicketReplySheet(email, AppLocalizations.of(context)!);
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: EmailDetailSheet(
            email: email,
            onArchive: () {
              Navigator.pop(context);
              if (email.id != null) {
                context.read<InboundEmailCubit>().archivedInboundEmail(
                  emailId: email.id!,
                );
              }
            },
            onDelete: () {
              Navigator.pop(context);
              _confirmDelete(email, AppLocalizations.of(context)!);
            },
          ),
        ),
      );
    }
  }

  void _openTicketReplySheet(Items ticket, AppLocalizations l10n) {
    final replyController = TextEditingController();

    // Build chat-like list of messages in chronological order
    final List<_ChatBubbleData> chatMessages = [];

    if (ticket.message != null && ticket.message!.isNotEmpty) {
      chatMessages.add(
        _ChatBubbleData(
          text: ticket.message!,
          isAdmin: false,
          time: ticket.createdAt,
        ),
      );
    }

    if (ticket.replies != null && ticket.replies!.isNotEmpty) {
      for (final reply in ticket.replies!) {
        if (reply.text != null && reply.text!.isNotEmpty) {
          chatMessages.add(
            _ChatBubbleData(
              text: reply.text!,
              isAdmin: reply.sender == 'admin',
              time: reply.createdAt,
            ),
          );
        }
      }
    } else {
      if (ticket.adminReply != null &&
          ticket.adminReply is String &&
          (ticket.adminReply as String).isNotEmpty) {
        chatMessages.add(
          _ChatBubbleData(
            text: ticket.adminReply as String,
            isAdmin: true,
            time: ticket.adminReplyAt as String?,
          ),
        );
      }
      if (ticket.donorReply != null &&
          ticket.donorReply is String &&
          (ticket.donorReply as String).isNotEmpty) {
        chatMessages.add(
          _ChatBubbleData(
            text: ticket.donorReply as String,
            isAdmin: false,
            time: ticket.donorReplyAt as String?,
          ),
        );
      }
    }

    chatMessages.sort((a, b) {
      final ta = a.time != null ? DateTime.tryParse(a.time!) : null;
      final tb = b.time != null ? DateTime.tryParse(b.time!) : null;
      if (ta == null || tb == null) return 0;
      return ta.compareTo(tb);
    });

    showModalBottomSheet(
      backgroundColor: ColorManger.pureWhite,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        // StatefulBuilder lets us rebuild just this sheet when a new reply is sent
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return BlocListener<InboundEmailCubit, InboundEmailState>(
              listener: (context, state) {
                if (state is SupportTicketReplySuccessState) {
                  _showSnack(l10n.supportTicketReplySentSnack);
                } else if (state is SupportTicketReplyErrorState) {
                  _showSnack(l10n.supportTicketReplyErrorSnack);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  left: 20,
                  right: 20,
                  top: 16,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                          text: ticket.subject ?? '',
                          textStyle: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManger.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _ticketInfoRow(
                          l10n.supportTicketFrom,
                          ticket.fullName ?? ticket.email ?? '',
                        ),
                        _ticketInfoRow(
                          l10n.supportTicketCategory,
                          EmailLocalizer.localizeCategory(ticket.subject, l10n),
                        ),
                        _ticketInfoRow(
                          l10n.supportTicketStatus,
                          EmailLocalizer.localizeStatus(ticket.status, l10n),
                        ),
                        const SizedBox(height: 12),

                        // ---- Chat-style conversation ----
                        ...chatMessages.map((msg) => _chatBubble(msg)),

                        const SizedBox(height: 12),
                        TextField(
                          controller: replyController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: l10n.supportTicketReplyHint,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManger.brightRed,
                              foregroundColor: ColorManger.pureWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              final replyText = replyController.text.trim();
                              if (replyText.isEmpty) return;

                              // 1. Optimistically add the new admin reply to the
                              //    chat list and rebuild the sheet in place —
                              //    this is what replaces "old" with "new" visually.
                              setSheetState(() {
                                chatMessages.add(
                                  _ChatBubbleData(
                                    text: replyText,
                                    isAdmin: true,
                                    time: DateTime.now().toIso8601String(),
                                  ),
                                );
                                replyController.clear();
                              });

                              // 2. Send it to the backend (sheet stays open)
                              if (ticket.id != null) {
                                context.read<InboundEmailCubit>().replyToSupportTicket(
                                  ticketId: ticket.id!,
                                  reply: replyText,
                                );
                              }
                            },
                            child: CustomText(
                              text: l10n.supportTicketSendReply,
                              textStyle: TextStyle(
                                color: ColorManger.pureWhite,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  Widget _chatBubble(_ChatBubbleData msg) {
    final isAdmin = msg.isAdmin;
    return Align(
      alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isAdmin ? ColorManger.lightBlue : ColorManger.grey100,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isAdmin ? 12 : 2),
            bottomRight: Radius.circular(isAdmin ? 2 : 12),
          ),
        ),
        child: CustomText(
          text: msg.text,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            height: 1.4,
            color: isAdmin ? ColorManger.darkBlue : ColorManger.black,
          ),
        ),
      ),
    );
  }
  String _localizeStatus(String? status, AppLocalizations l10n) {
    switch (status?.toUpperCase()) {
      case 'OPEN':
        return l10n.supportTicketStatusOpen;
      case 'CLOSED':
        return l10n.supportTicketStatusClosed;
      case 'IN_PROGRESS':
        return l10n.supportTicketStatusInProgress;
      default:
        return status ?? '';
    }
  }

  Widget _ticketInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: CustomText(
              text: label,
              textStyle: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManger.grey500,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              text: value,
              textStyle: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManger.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomText(
                  text: l10n.inboundEmails,
                  textStyle: TextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocListener<InboundEmailCubit, InboundEmailState>(
                listenWhen: (previous, current) =>
                current is InboundEmailActionSuccessState ||
                    current is InboundEmailActionErrorState ||
                    current is SupportTicketReplySuccessState ||
                    current is SupportTicketReplyErrorState,
                listener: (context, state) {
                  if (state is InboundEmailActionSuccessState) {
                    switch (state.action) {
                      case InboundEmailAction.delete:
                        _showSnack(l10n.inboundEmailDeletedSnack);
                        break;
                      case InboundEmailAction.markAsRead:
                        _showSnack(l10n.inboundEmailMarkedAsReadSnack);
                        break;
                      case InboundEmailAction.archive:
                        _showSnack(l10n.inboundEmailArchivedSnack);
                        break;
                    }
                  } else if (state is InboundEmailActionErrorState) {
                    log('InboundEmailActionErrorState: ${state.errorKey}');
                    _showSnack(localizeError(state.errorKey, l10n));
                  } else if (state is SupportTicketReplySuccessState) {
                    _showSnack(l10n.supportTicketReplySentSnack);
                  } else if (state is SupportTicketReplyErrorState) {
                    _showSnack(l10n.supportTicketReplyErrorSnack);
                  }
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: l10n.inboundEmailSearchHint,
                          prefixIcon: const Icon(Icons.search),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: ColorManger.grey300),
                          ),
                        ),
                      ),
                    ),
                    _buildFilterChips(l10n),
                    const Divider(height: 1),
                    Expanded(
                      child: BlocBuilder<InboundEmailCubit, InboundEmailState>(
                        builder: (context, state) {
                          if (state is InboundEmailLoadingState) {
                            return CustomLoadingWidget(
                              indicatorColor: ColorManger.brightPurple,
                            );
                          }
                          if (state is InboundEmailErrorState) {
                            log('InboundEmailErrorState: ${state.errorKey}');
                            return CustomErrorWidget(
                              message: localizeError(state.errorKey, l10n),
                              onRetry: () {
                                context.read<InboundEmailCubit>().fetchInboundEmails();
                              },
                            );
                          }

                          final cubit = context.read<InboundEmailCubit>();

                          // Apply filter to both emails and tickets
                          final filteredEmails = _applyFilter(cubit.allEmails);
                          final filteredTickets = _applyFilter(cubit.allSupportTickets);

                          // Combine filtered emails and tickets in ONE list
                          final allItems = <Items>[
                            ...filteredEmails,
                            ...filteredTickets,
                          ];

                          final isLoadingMore = state is InboundEmailLoadingMoreState;

                          if (allItems.isEmpty) {
                            return _buildEmptyState(
                              l10n,
                              Icons.mark_email_read_outlined,
                              _getEmptyStateMessage(l10n),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () => cubit.refresh(),
                            child: ListView(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              children: [
                                // Display all filtered items using EmailTile
                                ...allItems.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: EmailTile(
                                      email: item,
                                      onTap: () => _openDetail(item),
                                      onMarkRead: () {
                                        if (item.id != null) {
                                          cubit.markAsReadInboundEmail(
                                            emailId: item.id!,
                                          );
                                        }
                                      },
                                      onArchive: () {
                                        if (item.id != null) {
                                          cubit.archivedInboundEmail(
                                            emailId: item.id!,
                                          );
                                        }
                                      },
                                      onDelete: () => _confirmDelete(item, l10n),
                                    ),
                                  );
                                }),
                                if (isLoadingMore)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: CustomLoadingWidget(
                                      indicatorColor: ColorManger.brightPurple,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmptyStateMessage(AppLocalizations l10n) {
    switch (_filter) {
      case EmailFilter.unread:
        return l10n.inboundEmailEmptyUnread;
      case EmailFilter.archived:
        return l10n.inboundEmailEmptyArchived;
      case EmailFilter.all:
        return l10n.inboundEmailEmptyState;
    }
  }

  Widget _buildFilterChips(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _chip(l10n.inboundEmailFilterAll, EmailFilter.all),
          const SizedBox(width: 8),
          _chip(l10n.inboundEmailFilterUnread, EmailFilter.unread),
          const SizedBox(width: 8),
          _chip(l10n.inboundEmailFilterArchived, EmailFilter.archived),
        ],
      ),
    );
  }

  Widget _chip(String label, EmailFilter value) {
    final selected = _filter == value;
    return ChoiceChip(
      label: CustomText(text: label),
      selected: selected,
      onSelected: (_) => setState(() => _filter = value),
      selectedColor: ColorManger.brightRed.withValues(alpha: 0.12),
      labelStyle: TextStyle(
        color: selected ? ColorManger.brightRed : ColorManger.grey700,
        fontWeight: selected
            ? FontWeightManager.semiBold
            : FontWeightManager.regular,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? ColorManger.brightRed : ColorManger.grey300,
        ),
      ),
      backgroundColor: ColorManger.pureWhite,
    );
  }

  Widget _buildEmptyState(
      AppLocalizations l10n,
      IconData icon,
      String message,
      ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: ColorManger.grey400),
          const SizedBox(height: 12),
          CustomText(
            text: message,
            textStyle: TextStyle(
              color: ColorManger.grey500,
              fontSize: FontSize.s16,
            ),
          ),
        ],
      ),
    );
  }
}