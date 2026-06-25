import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../data/models/home_requests_model.dart';
import '../../presentation/view_model/home_view_model.dart';
import 'active_request_card.dart';

class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  State<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {
  final List<HomeRequestItem> _allRequests = [];
  final ScrollController _scrollController = ScrollController();

  int _page = 1;
  static const int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _allRequests.addAll(context.read<HomeCubit>().requests);
    _loadPage(reset: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore || !_hasMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadPage();
    }
  }

  Future<void> _loadPage({bool reset = false}) async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    try {
      final cubit = context.read<HomeCubit>();
      final token = await cubit.hospitalLocalDataSource.getAccessToken();
      if (token == null || token.isEmpty) return;

      final result = await cubit.homeUseCase.getRequests(
        token: token,
        page: reset ? 1 : _page,
        limit: _limit,
      );

      final newRequests = HomeCubit.filterActiveRequests(result.data?.requests ?? []);
      final pagination = result.data?.pagination;

      if (!mounted) return;
      setState(() {
        if (reset) {
          _allRequests
            ..clear()
            ..addAll(newRequests);
          _page = 2;
        } else {
          _allRequests.addAll(newRequests);
          _page++;
        }
        _hasMore = pagination?.totalPages != null
            ? (_page - 1) < pagination!.totalPages!
            : newRequests.length == _limit;
      });
    } catch (_) {
      if (mounted) setState(() => _hasMore = false);
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _onRefresh() async {
    await _loadPage(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.pureWhite,
        elevation: 0,
        foregroundColor: ColorManger.black,
        title: CustomText(
          text: appLocalizations.active_requests,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: _allRequests.isEmpty && !_isLoadingMore
              ? Center(
                  child: CustomText(
                    text: appLocalizations.noActiveRequests,
                    textStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                )
              : ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _allRequests.length + (_hasMore ? 1 : 0),
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    if (index >= _allRequests.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: _isLoadingMore
                              ? const CustomLoadingWidget(indicatorColor: Colors.blueAccent,)
                              : TextButton(
                                  onPressed: _loadPage,
                                  child: CustomText(
                                    text: appLocalizations.loadMore,
                                    textStyle: TextStyle(
                                      color: ColorManger.royalBlue,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    }
                    return ActiveRequestCard(request: _allRequests[index]);
                  },
                ),
        ),
      ),
    );
  }
}
