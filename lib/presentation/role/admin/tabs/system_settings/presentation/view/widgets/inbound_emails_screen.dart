import 'dart:async';
import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';
import '../../view_model/inbound_email/inbound_email_view_model.dart';
import 'email_detail_sheet.dart';
import 'email_tile.dart';

enum EmailFilter { all, unread, archived }

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

  List<InboundEmails> _applyFilter(List<InboundEmails> emails) {
    switch (_filter) {
      case EmailFilter.unread:
        return emails
            .where((e) => e.isRead != true && e.isArchived != true)
            .toList();
      case EmailFilter.archived:
        return emails.where((e) => e.isArchived == true).toList();
      case EmailFilter.all:
        return emails.where((e) => e.isArchived != true).toList();
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _confirmDelete(
      InboundEmails email,
      AppLocalizations l10n,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: AlertDialog(
          title: CustomText(text: l10n.inboundEmailDeleteTitle),
          content: CustomText(
            text: l10n.inboundEmailDeleteConfirm(email.subject ?? ''),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: CustomText(text: l10n.inboundEmailCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: CustomText(
                text: l10n.inboundEmailDelete,
                textStyle: TextStyle(color: ColorManger.brightRed),
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

  void _openDetail(InboundEmails email) {
    if (email.isRead != true && email.id != null) {
      context.read<InboundEmailCubit>().markAsReadInboundEmail(
        emailId: email.id!,
      );
    }
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

  void _openTicketReplySheet(SupportTickets ticket, AppLocalizations l10n) {
    final replyController = TextEditingController(
      text: ticket.adminReply as String? ?? '',
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 16,
        ),
        child: SafeArea(
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
              _ticketInfoRow(l10n.supportTicketCategory, ticket.category ?? ''),
              _ticketInfoRow(
                l10n.supportTicketStatus,
                _localizeStatus(ticket.status, l10n),
              ),
              const SizedBox(height: 12),
              if (ticket.adminReply != null &&
                  ticket.adminReply is String &&
                  (ticket.adminReply as String).isNotEmpty) ...[
                CustomText(
                  text: l10n.supportTicketAdminReply,
                  textStyle: TextStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManger.grey600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorManger.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: ticket.adminReply as String,
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManger.darkBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
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
                    Navigator.pop(ctx);
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

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'OPEN':
        return ColorManger.brightRed;
      case 'CLOSED':
        return ColorManger.successColor;
      case 'IN_PROGRESS':
        return ColorManger.orange;
      default:
        return ColorManger.grey500;
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
                          final emails = _applyFilter(cubit.allEmails);
                          final tickets = cubit.allSupportTickets;
                          final isLoadingMore = state is InboundEmailLoadingMoreState;
        
                          if (emails.isEmpty && tickets.isEmpty) {
                            return _buildEmptyState(
                              l10n,
                              Icons.mark_email_read_outlined,
                              l10n.inboundEmailEmptyState,
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
                                if (emails.isNotEmpty) ...[
                                  _sectionHeader(l10n.inboundEmails),
                                  const SizedBox(height: 8),
                                  ...emails.map(
                                        (email) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: EmailTile(
                                        email: email,
                                        onTap: () => _openDetail(email),
                                        onMarkRead: () {
                                          if (email.id != null) {
                                            cubit.markAsReadInboundEmail(
                                              emailId: email.id!,
                                            );
                                          }
                                        },
                                        onArchive: () {
                                          if (email.id != null) {
                                            cubit.archivedInboundEmail(
                                              emailId: email.id!,
                                            );
                                          }
                                        },
                                        onDelete: () => _confirmDelete(email, l10n),
                                      ),
                                    ),
                                  ),
                                  if (isLoadingMore)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: CustomLoadingWidget(
                                        indicatorColor: ColorManger.brightPurple,
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                ],
                                if (tickets.isNotEmpty) ...[
                                  _sectionHeader(l10n.supportTicketsTab),
                                  const SizedBox(height: 8),
                                  ...tickets.map(
                                        (ticket) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: _buildTicketCard(ticket, l10n),
                                    ),
                                  ),
                                ],
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

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomText(
        text: title,
        textStyle: TextStyle(
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.bold,
          color: ColorManger.grey700,
        ),
      ),
    );
  }

  Widget _buildTicketCard(SupportTickets ticket, AppLocalizations l10n) {
    final statusColor = _statusColor(ticket.status);
    final parsedDate = ticket.createdAt != null
        ? DateTime.tryParse(ticket.createdAt!)
        : null;
    final dateStr = parsedDate != null
        ? DateFormat('MMM d, yyyy').format(parsedDate)
        : '';
    final hasReply =
        ticket.adminReply != null &&
            ticket.adminReply is String &&
            (ticket.adminReply as String).isNotEmpty;

    return Material(
      color: ColorManger.pureWhite,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openTicketReplySheet(ticket, l10n),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ColorManger.grey100),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: statusColor.withValues(alpha: 0.12),
                    child: Icon(
                      Icons.support_agent_outlined,
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: ticket.subject ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textStyle: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManger.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        CustomText(
                          text: ticket.fullName ?? ticket.email ?? '',
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
                      color: ColorManger.grey500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _statusBadge(
                    _localizeStatus(ticket.status, l10n),
                    statusColor,
                  ),
                  const SizedBox(width: 8),
                  if (ticket.category != null) _categoryBadge(ticket.category!),
                  const Spacer(),
                  if (hasReply) ...[
                    Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: ColorManger.successColor,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: l10n.supportTicketAdminReply,
                      textStyle: TextStyle(
                        fontSize: FontSize.s12,
                        color: ColorManger.successColor,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ] else ...[
                    Icon(
                      Icons.hourglass_empty_outlined,
                      size: 14,
                      color: ColorManger.grey500,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: l10n.supportTicketNoReply,
                      textStyle: TextStyle(
                        fontSize: FontSize.s12,
                        color: ColorManger.grey500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: color,
        ),
      ),
    );
  }

  Widget _categoryBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: ColorManger.brightPurple.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: category,
        textStyle: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: ColorManger.brightPurple,
        ),
      ),
    );
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