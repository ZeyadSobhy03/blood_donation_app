import 'dart:async';
import 'dart:developer';

import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view/section/hospital_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view/section/blood_filter.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view/widgets/custom_hospital_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

import '../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../core/resources/models/coordinates.dart';
import '../../../../../../../core/resources/routes/route_manger.dart';

import '../../../donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../view_model/nearby_hospitals_view_model.dart';
import '../../data/model/nearby_hospitals.dart';

import '../../../request_screen/widgets/map_card.dart';

class FindHospital extends StatefulWidget {
  const FindHospital({super.key});

  @override
  State<FindHospital> createState() => _FindHospitalState();
}

class _FindHospitalState extends State<FindHospital> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;

  bool isAscending = true;
  bool showFilter = false;

  String _searchQuery = '';
  String? _selectedBloodType;

  @override
  void initState() {
    super.initState();
    _fetchNearby();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    final atBottom =
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200;

    if (atBottom) {
      final mapState = context.read<MapCubit>().state;
      if (mapState is! MapLoaded) return;

      context.read<NearbyHospitalsCubit>().loadMore(
        latitude: mapState.latitude,
        longitude: mapState.longitude,
        searchQuery: _searchQuery,
        bloodType: _selectedBloodType,
        isAscending: isAscending,
      );
    }
  }

  void _fetchNearby() {
    final state = context.read<MapCubit>().state;
    if (state is! MapLoaded) return;

    context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
      latitude: state.latitude,
      longitude: state.longitude,
      radius: 10,
      bloodType: _selectedBloodType,
      sortBy: 'distance',
      order: isAscending ? 'asc' : 'desc',
      page: 1,
    );
  }

  void _onSearchChanged(String value) {
    _searchQuery = value;
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final mapState = context.read<MapCubit>().state;
      if (mapState is! MapLoaded) return;

      if (value.trim().isEmpty) {
        context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
          latitude: mapState.latitude,
          longitude: mapState.longitude,
          radius: 10,
          bloodType: _selectedBloodType,
          sortBy: 'distance',
          order: isAscending ? 'asc' : 'desc',
          page: 1,
        );
      } else {
        context.read<NearbyHospitalsCubit>().searchNearbyHospitals(
          query: value,
          bloodType: _selectedBloodType,
          availableOnly: true,
          page: 1,
        );
      }
    });
  }

  void _filterByBloodType(String? bloodType) {
    _selectedBloodType = bloodType;
    final mapState = context.read<MapCubit>().state;
    if (mapState is! MapLoaded) return;

    if (_searchQuery.isNotEmpty) {
      context.read<NearbyHospitalsCubit>().searchNearbyHospitals(
        query: _searchQuery,
        bloodType: bloodType,
        availableOnly: true,
        page: 1,
      );
    } else {
      context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
        latitude: mapState.latitude,
        longitude: mapState.longitude,
        radius: 10,
        bloodType: bloodType,
        sortBy: 'distance',
        order: isAscending ? 'asc' : 'desc',
        page: 1,
      );
    }
  }

  void _sortByDistance() {
    setState(() => isAscending = !isAscending);
    _fetchNearby();
  }

  Coordinates? _cords(Hospitals h) {
    final lat = h.location?.lat ?? h.lat;
    final lng = h.location?.lng ?? h.lng;
    if (lat == null || lng == null) return null;
    return Coordinates(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocListener<MapCubit, MapState>(
          listener: (context, state) {
            if (state is MapLoaded) _fetchNearby();
          },
          child: BlocBuilder<NearbyHospitalsCubit, NearbyHospitalsState>(
            builder: (context, state) {
              final cubit = context.read<NearbyHospitalsCubit>();
              final hospitals = cubit.hospitals;
              final isLoadingMore = cubit.isLoadingMore;
              final hasMore = cubit.hasMore;

              if (state is NearbyHospitalsLoadingState && hospitals.isEmpty) {
                return const CustomLoadingWidget();
              }

              if (state is NearbyHospitalsErrorState && hospitals.isEmpty) {
                log('Error fetching nearby hospitals: ${state.error}');
                return CustomErrorWidget(
                  message: localizeError(state.error, app),
                  onRetry: _fetchNearby,
                  onDismiss: null,
                );
              }

              final hasData = hospitals.isNotEmpty;

              return SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: app.findHospitals,
                        textStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      CustomTextFormField(
                        textEditingController: _searchController,
                        onChanged: _onSearchChanged,
                        prefixIcon: const Icon(Icons.search),
                        hintText: app.searchHint,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => showFilter = !showFilter),
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            color: showFilter
                                ? ColorManger.brightRed
                                : ColorManger.slateGrey,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      if (showFilter)
                        BloodFilter(
                          onBloodTypeChanged: _filterByBloodType,
                          onClear: () => _filterByBloodType(null),
                        ),

                      SizedBox(height: 10.h),

                      MapCard(
                        onTap: hasData
                            ? () {
                          final c = _cords(hospitals.first);
                          if (c != null) {
                            Navigator.pushNamed(
                              context,
                              RouteManger.mapScreen,
                              arguments: c,
                            );
                          }
                        }
                            : null,
                        hospitalName: app.hospitalsNearby(hospitals.length),
                      ),

                      SizedBox(height: 10.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: app.hospitalsFound(hospitals.length),
                            textStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeightManager.medium,
                            ),
                          ),
                          CustomHospitalButton(
                            widget: Row(
                              children: [
                                Transform.rotate(
                                  angle: -0.785,
                                  child: const Icon(Icons.send_rounded),
                                ),
                                SizedBox(width: 5.w),
                                CustomText(text: app.sortByDistance),
                              ],
                            ),
                            onPressed: _sortByDistance,
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hospitals.length,
                        itemBuilder: (context, index) {
                          return HospitalCard(hospitals: hospitals[index]);
                        },
                      ),

                      if (isLoadingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(child: CircularProgressIndicator()),
                        ),

                      if (!hasMore && hasData)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Center(
                            child: CustomText(
                              text: app.noMoreHospitals,
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                color: ColorManger.slateGrey,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}