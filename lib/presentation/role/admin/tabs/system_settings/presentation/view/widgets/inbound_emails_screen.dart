import 'dart:async';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
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

  Future<void> _confirmDelete(InboundEmails email, AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
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
    );
    if (confirmed == true && email.id != null) {
      context.read<InboundEmailCubit>().deleteInboundEmail(emailId: email.id!);
    }
  }

  void _openDetail(InboundEmails email) {
    if (email.isRead != true && email.id != null) {
      context.read<InboundEmailCubit>().markAsReadInboundEmail(emailId: email.id!);
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EmailDetailSheet(
        email: email,
        onArchive: () {
          Navigator.pop(context);
          if (email.id != null) {
            context.read<InboundEmailCubit>().archivedInboundEmail(emailId: email.id!);
          }
        },
        onDelete: () {
          Navigator.pop(context);
          _confirmDelete(email, AppLocalizations.of(context)!);
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        title: CustomText(text: l10n.inboundEmailsTitle),
        backgroundColor: ColorManger.pureWhite,
        foregroundColor: ColorManger.black,
        elevation: 0.5,
      ),
      body: BlocListener<InboundEmailCubit, InboundEmailState>(
        listenWhen: (previous, current) =>
        current is InboundEmailActionSuccessState ||
            current is InboundEmailActionErrorState,
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
            _showSnack(localizeError(state.errorKey,l10n));
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
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                    return CustomErrorWidget(message: localizeError(state.errorKey,l10n ), onRetry: (){
                      context.read<InboundEmailCubit>().fetchInboundEmails();
                    });
                  }

                  final cubit = context.read<InboundEmailCubit>();
                  final emails = _applyFilter(cubit.allEmails);
                  final isLoadingMore = state is InboundEmailLoadingMoreState;

                  if (emails.isEmpty) {
                    return _buildEmptyState(l10n);
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.refresh(),
                    child: ListView.separated(
                      controller: _scrollController,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: emails.length + (isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        if (index >= emails.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child:  CustomLoadingWidget(
                              indicatorColor: ColorManger.brightPurple,
                            ),
                          );
                        }
                        final email = emails[index];
                        return EmailTile(
                          email: email,
                          onTap: () => _openDetail(email),
                          onMarkRead: () {
                            if (email.id != null) {
                              cubit.markAsReadInboundEmail(emailId: email.id!);
                            }
                          },
                          onArchive: () {
                            if (email.id != null) {
                              cubit.archivedInboundEmail(emailId: email.id!);
                            }
                          },
                          onDelete: () => _confirmDelete(email, l10n),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
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
        fontWeight:
        selected ? FontWeightManager.semiBold : FontWeightManager.regular,
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

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mark_email_read_outlined,
            size: 56,
            color: ColorManger.grey400,
          ),
          const SizedBox(height: 12),
          CustomText(
            text: l10n.inboundEmailEmptyState,
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