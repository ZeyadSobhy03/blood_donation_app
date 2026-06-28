import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/summary_model.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/presentation/view_model/history_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_summary_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/recent_request_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/app_localizations.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final loc = AppLocalizations.of(context)!;
      context.read<HistoryCubit>().setAppLoc(loc);
      context.read<HistoryCubit>().fetchHistory(loc: loc);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context);
    if (loc != null) {
      context.read<HistoryCubit>().setAppLoc(loc);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          loc.requestHistory,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadingState) {
            return const Center(child: CustomLoadingWidget(indicatorColor: Colors.blueAccent,));
          }

          if (state is HistoryErrorState) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<HistoryCubit>().fetchHistory(loc: loc),
            );
          }

          if (state is HistoryEmptyState) {
            return _buildScrollContent(
              loc: loc,
              summaryModel: state.summaryModel,
              requests: const [],
              isPaginating: false,
              hasMore: false,
            );
          }

          final requests = switch (state) {
            HistorySuccessState s => s.requests,
            HistoryPaginatingState s => s.currentRequests,
            _ => [],
          };

          final summaryModel = switch (state) {
            HistorySuccessState s => s.summaryModel,
            HistoryPaginatingState s => s.summaryModel,
            _ => null,
          };

          final isPaginating = state is HistoryPaginatingState;
          final hasMore =
          state is HistorySuccessState ? state.hasMore : false;

          return _buildScrollContent(
            loc: loc,
            summaryModel: summaryModel,
            requests: requests,
            isPaginating: isPaginating,
            hasMore: hasMore,
          );
        },
      ),
    );
  }

  Widget _buildScrollContent({
    required AppLocalizations loc,
    required SummaryModel? summaryModel,
    required List requests,
    required bool isPaginating,
    required bool hasMore,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.trackBloodRequests,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          if (summaryModel != null)
            Row(
              children: [
                CustomSummaryItem(
                  count: summaryModel.completed,
                  label: loc.fulfilled,
                  bg: const Color(0xFFE8F5E9),
                  text: const Color(0xFF2E7D32),
                ),
                const SizedBox(width: 12),
                CustomSummaryItem(
                  count: summaryModel.active,
                  label: loc.active,
                  bg: const Color(0xFFFFF3E0),
                  text: const Color(0xFFEF6C00),
                ),
                const SizedBox(width: 12),
                CustomSummaryItem(
                  count: summaryModel.cancelled,
                  label: loc.cancelled,
                  bg: const Color(0xFFFFEBEE),
                  text: const Color(0xFFC62828),
                ),
              ],
            ),

          const SizedBox(height: 32),

          Text(
            loc.recentRequests,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          if (requests.isEmpty && !isPaginating)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 56,
                      color: ColorManger.slateGrey.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      loc.noRequestsFound,
                      style: TextStyle(color: ColorManger.slateGrey),
                    ),
                  ],
                ),
              ),
            ),

          ListView.builder(
            itemCount: requests.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final request = requests[index];

              final historyModel = request.toHistoryModel(loc);

              return CustomRequestCard(
                isFulfilled: historyModel.isFulfilled,
                type: '${historyModel.bloodType} ${loc.bloodRequest}',
                units: historyModel.units,
                date:
                '${historyModel.date.month}/${historyModel.date.day}/${historyModel.date.year}',
                priority: historyModel.priority,
                status: historyModel.status,
                color: historyModel.isFulfilled ? Colors.green : Colors.red,
                onViewDetails: () {
                  showDialog(
                    context: context,
                    builder: (_) => RecentRequestDetailDialog(
                      bloodRequestModel: historyModel,
                    ),
                  );
                },
              );
            },
          ),

          if (isPaginating)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),

          if (hasMore && !isPaginating)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: TextButton(
                  onPressed: () => context.read<HistoryCubit>().loadMore(
                    loc: loc,
                  ),
                  child: Text(
                    loc.loadMore,
                    style: TextStyle(
                      color: ColorManger.brightRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 56, color: ColorManger.brightRed),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorManger.slateGrey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      ),
    );
  }
}