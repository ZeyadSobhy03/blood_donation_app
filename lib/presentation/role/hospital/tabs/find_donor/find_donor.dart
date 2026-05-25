import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/presentation/view_model/find_donors_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/find_nearby_donors_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../donor/tabs/find_hospital/section/blood_filter.dart';
import '../../../donor/tabs/find_hospital/widgets/custom_hospital_button.dart';

class FindDonor extends StatefulWidget {
  const FindDonor({super.key});

  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  String? _selectedBloodType;
  bool _showFilter = false;

  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FindDonorsCubit>().fetchDonors();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DonorModel> _applyNameFilter(List<DonorModel> donors) {
    if (_searchQuery.isEmpty) return donors;
    return donors
        .where((d) =>
        d.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<DonorModel> _applySorting(List<DonorModel> donors) {
    final sorted = List<DonorModel>.from(donors);
    sorted.sort((a, b) {
      final da = a.distanceInKm ?? double.maxFinite;
      final db = b.distanceInKm ?? double.maxFinite;
      return _isAscending ? da.compareTo(db) : db.compareTo(da);
    });
    return sorted;
  }

  List<DonorModel> _processedDonors(List<DonorModel> raw) {
    return _applySorting(_applyNameFilter(raw));
  }

  void _onBloodTypeChanged(String? bloodType) {
    setState(() => _selectedBloodType = bloodType);
    context.read<FindDonorsCubit>().fetchDonors(
      bloodType: bloodType,
    );
  }

  void _onSortPressed() {
    setState(() => _isAscending = !_isAscending);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  title: loc.find_donors,
                  subTitle: loc.find_donors_dec,
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  textEditingController: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  prefixIcon:
                  Icon(Icons.search, color: ColorManger.slateGrey),
                  hintText: loc.searchHint,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _showFilter = !_showFilter),
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: _showFilter
                          ? ColorManger.brightRed
                          : ColorManger.slateGrey,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                _showFilter ? BloodFilter(
                  onBloodTypeChanged: _onBloodTypeChanged,
                  onClear: () => _onBloodTypeChanged(null),
                )
                    : SizedBox(height: 12.h),

                BlocBuilder<FindDonorsCubit, FindDonorsState>(
                  builder: (context, state) {
                    if (state is FindDonorsLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Center(child: CustomLoadingWidget(indicatorColor: Colors.blueAccent,)),
                      );
                    }

                    if (state is FindDonorsErrorState) {
                      return _ErrorView(
                        message: state.message,
                        onRetry: () => context
                            .read<FindDonorsCubit>()
                            .fetchDonors(bloodType: _selectedBloodType),
                      );
                    }

                    if (state is FindDonorsEmptyState) {
                      return _EmptyView(message: loc.noDonorsFound);
                    }

                    final rawDonors = switch (state) {
                      FindDonorsSuccessState s => s.donors,
                      FindDonorsPaginatingState s => s.currentDonors,
                      _ => <DonorModel>[],
                    };

                    final isPaginating = state is FindDonorsPaginatingState;
                    final hasMore = state is FindDonorsSuccessState
                        ? state.hasMore
                        : false;

                    final displayed = _processedDonors(rawDonors);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: loc.donors_found(displayed.length),
                              textStyle: TextStyle(
                                color: ColorManger.black,
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s15,
                              ),
                            ),
                            CustomHospitalButton(
                              onPressed: _onSortPressed,
                              widget: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.rotate(
                                    angle: -0.785,
                                    child: Icon(
                                      _isAscending
                                          ? Icons.send_rounded
                                          : Icons.send_rounded,
                                      color: ColorManger.black,
                                    ),
                                  ),
                                  CustomText(
                                    text: loc.sortByDistance,
                                    textStyle:
                                    TextStyle(fontSize: FontSize.s14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayed.length,
                          itemBuilder: (context, index) =>
                              FindNearbyDonorsCard(donor: displayed[index]),
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
                                onPressed: () => context
                                    .read<FindDonorsCubit>()
                                    .loadMore(
                                    bloodType: _selectedBloodType),
                                child: Text(
                                  loc.loadMore,
                                  style: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline,
                size: 48, color: ColorManger.brightRed),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorManger.slateGrey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final String message;

  const _EmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.person_search,
                size: 56, color: ColorManger.slateGrey.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: ColorManger.slateGrey),
            ),
          ],
        ),
      ),
    );
  }
}