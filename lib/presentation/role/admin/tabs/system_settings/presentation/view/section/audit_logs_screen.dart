import 'dart:developer';

import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/extension/data_ex.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/utils/audit_logs_localizer.dart';
import '../../../../../../../../core/utils/error_localizer.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/audit_logs/audit_logs_view_model.dart';

class AuditLogsScreen extends StatefulWidget {
  const AuditLogsScreen({super.key});

  @override
  State<AuditLogsScreen> createState() => _AuditLogsScreenState();
}

class _AuditLogsScreenState extends State<AuditLogsScreen> {
  String? _selectedTargetType;

  static const List<String> _targetTypes = ['user', 'request', 'donation', 'system'];

  @override
  void initState() {
    super.initState();
    context.read<AuditLogsCubit>().getAuditLogs(isRefresh: true);
  }

  void _onFilterChanged(String? value) {
    setState(() => _selectedTargetType = value);
    log('Filter changed: $_selectedTargetType');
    context.read<AuditLogsCubit>().getAuditLogs(
      isRefresh: true,
      targetType: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
    
      body: SafeArea(
        child: Column(
          
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CustomText(
                  text: loc.auditLogs,
                  textStyle: TextStyle(fontSize: FontSize.s18, fontWeight: FontWeightManager.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  CustomText(
                    text: loc.filterByTargetType,
                    textStyle: TextStyle(fontSize: FontSize.s13, color: ColorManger.slateGrey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManger.slateGrey.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String?>(
                          dropdownColor: ColorManger.pureWhite,
                          value: _selectedTargetType,
                          isExpanded: true,
                          hint: CustomText(
                              text: loc.allTypes,
                              textStyle: TextStyle(fontSize: FontSize.s13, color: ColorManger.slateGrey)
                          ),
                          items: [
                            DropdownMenuItem<String?>(
                              value: null,
                              child: CustomText(text: loc.allTypes, textStyle: TextStyle(fontSize: FontSize.s13)),
                            ),
                            ..._targetTypes.map(
                                  (type) => DropdownMenuItem<String?>(
                                value: type,
                                child: CustomText(
                                    text: AuditLogsLocalizer.localizeTargetType(type, loc),
                                    textStyle: TextStyle(fontSize: FontSize.s13)
                                ),
                              ),
                            ),
                          ],
                          onChanged: _onFilterChanged,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AuditLogsCubit, AuditLogsState>(
                builder: (context, state) {
                  if (state is AuditLogsLoadingState) {
                    return const CustomLoadingWidget(
                      indicatorColor: ColorManger.brightPurple,
                    );
                  }
        
                  if (state is AuditLogsErrorState) {
                    return CustomErrorWidget(
                        message: localizeError(state.errorMessage, loc),
                        onRetry: () {
                          context.read<AuditLogsCubit>().getAuditLogs(
                            isRefresh: true,
                            targetType: _selectedTargetType,
                          );
                        }
                    );
                  }
        
                  if (state is AuditLogsLoadedState) {
                    if (state.logs.isEmpty) {
                      return Center(child: CustomText(text: loc.noAuditLogsFound));
                    }
        
                    return RefreshIndicator(
                      onRefresh: () => context.read<AuditLogsCubit>().getAuditLogs(
                        isRefresh: true,
                        targetType: _selectedTargetType,
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.logs.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index == state.logs.length) {
                            if (state.hasReachedMax) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: state.isLoadingMore
                                    ? const CircularProgressIndicator(strokeWidth: 2)
                                    : OutlinedButton(
                                  onPressed: () => context.read<AuditLogsCubit>().getAuditLogs(
                                    isLoadMore: true,
                                    targetType: _selectedTargetType,
                                  ),
                                  child: CustomText(text: loc.loadMore),
                                ),
                              ),
                            );
                          }
        
                          final log = state.logs[index];
        
        
        
        
                          final translatedAction = AuditLogsLocalizer.localizeAction(log.action ?? '', loc);
                          final translatedDetails = AuditLogsLocalizer.localizeDetails(log.details ?? '', loc);
                          final translatedTargetType = log.targetType != null
                              ? AuditLogsLocalizer.localizeTargetType(log.targetType!, loc)
                              : null;
                         
        
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: ColorManger.pureWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: ColorManger.slateGrey.withValues(alpha: 0.2)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: translatedAction, // Translated!
                                        textStyle: TextStyle(fontWeight: FontWeightManager.semiBold, fontSize: FontSize.s15),
                                      ),
                                    ),
                                    if (translatedTargetType != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: ColorManger.brightRed.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: CustomText(
                                          text: translatedTargetType, // Translated!
                                          textStyle: TextStyle(fontSize: FontSize.s12, color: ColorManger.brightRed),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                if (log.details != null)
                                  CustomText(
                                    text: translatedDetails, // Translated!
                                    textStyle: TextStyle(fontSize: FontSize.s13, color: ColorManger.black.withValues(alpha: 0.7)),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline, size: 14, color: ColorManger.slateGrey),
                                    const SizedBox(width: 4),
                                    CustomText(
                                      text: log.adminName ?? '',
                                      textStyle: TextStyle(fontSize: FontSize.s12, color: ColorManger.slateGrey),
                                    ),
                                    const Spacer(),
                                    CustomText(
                                      text: log.createdAt.toFormattedDate(),
                                      textStyle: TextStyle(fontSize: FontSize.s12, color: ColorManger.slateGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
        
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}