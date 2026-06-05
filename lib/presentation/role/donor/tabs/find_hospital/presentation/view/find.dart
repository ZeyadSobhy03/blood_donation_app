import 'dart:async';

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
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../core/resources/models/coordinates.dart';
import '../../../../../../../core/resources/routes/route_manger.dart';

import '../view_model/nearby_hospitals_view_model.dart';
import '../../data/model/nearby_hospitals.dart';

import '../../../request_screen/widgets/map_card.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

class FindHospital extends StatefulWidget {
  const FindHospital({super.key});

  @override
  State<FindHospital> createState() => _FindHospitalState();
}

class _FindHospitalState extends State<FindHospital> {
  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final List<Hospitals> _hospitals = [];

  Timer? _debounce;

  bool isAscending = true;
  bool showFilter = false;

  String _searchQuery = '';
  String? _selectedBloodType;

  double? _lat;
  double? _lng;

  int _currentPage = 1;

  bool _hasMore = true;
  bool _isLoadingMore = false;

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
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    final mapState = context.read<MapCubit>().state;

    if (mapState is! MapLoaded) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;

    try {
      final cubit = context.read<NearbyHospitalsCubit>();

      if (_searchQuery.isNotEmpty) {
        await cubit.searchNearbyHospitals(
          query: _searchQuery,
          bloodType: _selectedBloodType,
          availableOnly: true,
          page: _currentPage,
          limit: 10,
        );
      } else {
        await cubit.fetchNearbyHospitals(
          latitude: mapState.latitude,
          longitude: mapState.longitude,
          radius: 10,
          bloodType: _selectedBloodType,
          sortBy: 'distance',
          order: isAscending ? 'asc' : 'desc',
          page: _currentPage,
          limit: 10,
        );
      }
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _fetchNearby() {
    final state = context.read<MapCubit>().state;

    if (state is! MapLoaded) return;

    _lat = state.latitude;
    _lng = state.longitude;

    _currentPage = 1;

    _hasMore = true;

    context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
      latitude: _lat!,
      longitude: _lng!,
      radius: 10,
      search: null,
      bloodType: _selectedBloodType,
      sortBy: 'distance',
      order: isAscending ? 'asc' : 'desc',
      page: 1,
      limit: 10,
    );
  }

  void _onSearchChanged(String value) {
    _searchQuery = value;

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final mapState = context.read<MapCubit>().state;

      if (mapState is! MapLoaded) return;

      _currentPage = 1;

      _hasMore = true;

      if (value.trim().isEmpty) {
        context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
          latitude: mapState.latitude,
          longitude: mapState.longitude,
          radius: 10,
          bloodType: _selectedBloodType,
          sortBy: 'distance',
          order: isAscending ? 'asc' : 'desc',
          page: 1,
          limit: 10,
        );
      } else {
        context.read<NearbyHospitalsCubit>().searchNearbyHospitals(
          query: value,
          bloodType: _selectedBloodType,
          availableOnly: true,
          page: 1,
          limit: 10,
        );
      }
    });
  }

  void filterByBloodType(String? bloodType) {
    _selectedBloodType = bloodType;

    final mapState = context.read<MapCubit>().state;

    if (mapState is! MapLoaded) return;

    _currentPage = 1;

    _hasMore = true;

    if (_searchQuery.isNotEmpty) {
      context.read<NearbyHospitalsCubit>().searchNearbyHospitals(
        query: _searchQuery,
        bloodType: bloodType,
        availableOnly: true,
        page: 1,
        limit: 10,
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
        limit: 10,
      );
    }
  }

  void sortByDistance() {
    setState(() {
      isAscending = !isAscending;
    });

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
        child: MultiBlocListener(
          listeners: [
            BlocListener<MapCubit, MapState>(
              listener: (context, state) {
                if (state is MapLoaded) {
                  _fetchNearby();
                }
              },
            ),
            BlocListener<NearbyHospitalsCubit, NearbyHospitalsState>(
              listener: (context, state) {
                if (state is NearbyHospitalsSuccessState) {
                  final data = state.nearbyHospitals.data?.hospitals ?? [];

                  setState(() {
                    if (_currentPage == 1) {
                      _hospitals.clear();
                    }

                    _hospitals.addAll(data);

                    if (data.length < 10) {
                      _hasMore = false;
                    }
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<NearbyHospitalsCubit, NearbyHospitalsState>(
           builder: (context, state) {
               if (state is NearbyHospitalsLoadingState && _hospitals.isEmpty) {
                 return CustomLoadingWidget();
               }

               if (state is NearbyHospitalsErrorState && _hospitals.isEmpty) {
                return CustomErrorWidget(
                  message: localizeError(state.error, app),
                  onRetry: _fetchNearby,
                  onDismiss: null,
                );
              }

              final hasData = _hospitals.isNotEmpty;

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
                          onPressed: () {
                            setState(() {
                              showFilter = !showFilter;
                            });
                          },
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
                          onBloodTypeChanged: filterByBloodType,
                          onClear: () => filterByBloodType(null),
                        ),

                      SizedBox(height: 10.h),

                      MapCard(
                        onTap: hasData
                            ? () {
                                final c = _cords(_hospitals.first);

                                if (c != null) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteManger.mapScreen,
                                    arguments: c,
                                  );
                                }
                              }
                            : null,
                        hospitalName: app.hospitalsNearby(_hospitals.length),
                      ),

                      SizedBox(height: 10.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: app.hospitalsFound(_hospitals.length),
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
                            onPressed: sortByDistance,
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _hospitals.length,
                        itemBuilder: (context, index) {
                          return HospitalCard(hospitals: _hospitals[index]);
                        },
                      ),

                       if (_isLoadingMore)
                         Padding(
                           padding: EdgeInsets.symmetric(vertical: 16.h),
                           child: Skeletonizer(
                             enabled: true,
                             child: Center(
                               child: Container(
                                 width: 40.w,
                                 height: 40.w,
                                 decoration: BoxDecoration(
                                   color: Colors.grey.shade300,
                                   shape: BoxShape.circle,
                                 ),
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
