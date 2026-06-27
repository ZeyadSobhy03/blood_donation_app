import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/widgets/support_ticket_detail_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/support_tickets/support_tickets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SupportTicketsSection extends StatefulWidget {
  const SupportTicketsSection({super.key});

  @override
  State<SupportTicketsSection> createState() => _SupportTicketsSectionState();
}

class _SupportTicketsSectionState extends State<SupportTicketsSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupportTicketsCubit>().fetchSupportTickets();
    });
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

  String _localizeStatus(String? status, AppLocalizations loc) {
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

  String _localizeCategory(String? category, AppLocalizations loc) {
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<SupportTicketsCubit, SupportTicketsState>(
      builder: (context, state) {
        if (state is SupportTicketsLoadingState) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CustomLoadingWidget(),
          );
        }

        if (state is SupportTicketsErrorState) {
          log('[SupportTicketsSection] Error: ${state.error}');
          return CustomErrorWidget(
            message: localizeError(state.error, loc),
            onRetry: () => context.read<SupportTicketsCubit>().fetchSupportTickets(),
          );
        }

        if (state is SupportTicketsSuccessState) {
          final tickets = state.ticketsModel.data?.tickets ?? [];

          if (tickets.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              color: ColorManger.pureWhite,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: loc.supportTickets,
                      textStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...tickets.map((ticket) => _buildTicketCard(ticket, loc)),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTicketCard(Ticket ticket, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorManger.lightGreyBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(ticket.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _statusColor(ticket.status).withValues(alpha: 0.3)),
                    ),
                    child: CustomText(
                      text: _localizeStatus(ticket.status, loc),
                      textStyle: TextStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: _statusColor(ticket.status),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.chat_bubble_outline, size: 14, color: ColorManger.slateGrey),
                  const SizedBox(width: 6),
                  CustomText(
                    text: _localizeCategory(ticket.category, loc),
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: ColorManger.slateGrey),
                  const SizedBox(width: 6),
                  CustomText(
                    text: '${_formatDate(ticket.createdAt)} ${_formatTime(ticket.createdAt)}',
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showSupportTicketDetailDialog(context, ticket, loc),
                  child: CustomText(
                    text: loc.viewDetails,
                    textStyle: TextStyle(
                      color: ColorManger.brightRed,
                      fontSize: FontSize.s13,
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
