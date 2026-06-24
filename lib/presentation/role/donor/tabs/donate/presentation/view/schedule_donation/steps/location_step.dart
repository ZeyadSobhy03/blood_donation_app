import 'dart:developer';

import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/widgets/hospital_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view_model/nearby_hospitals_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../../../l10n/app_localizations.dart';

import '../../../../../find_hospital/data/model/nearby_hospitals.dart';
import '../cubit/donation_schedule.dart';
import '../widgets/title_step.dart';

class LocationStep extends StatefulWidget {
  const LocationStep({super.key, required this.nextStep});

  final VoidCallback nextStep;

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  double? _lat;
  double? _lng;

  @override
  void initState() {
    super.initState();
    _fetchNearby();
  }

  void _fetchNearby() {
    final state = context.read<MapCubit>().state;
    if (state is! MapLoaded) return;

    _lat = state.latitude;
    _lng = state.longitude;

    context.read<NearbyHospitalsCubit>().fetchNearbyHospitals(
      latitude: _lat!,
      longitude: _lng!,
      radius: 10,
      search: null,
      sortBy: 'distance',
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final selectedHospital = context
        .watch<DonationScheduleCubit>()
        .state
        .schedule
        .location;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleStep(
              title: appLocalization.chooseLocationTitle,
              subTitle: appLocalization.chooseLocationSubtitle,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: _buildHospitalsList(
                context,
                selectedHospital,
                appLocalization,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalsList(
    BuildContext context,
    String? selectedHospital,
    AppLocalizations appLocalization,
  ) {
    return BlocBuilder<NearbyHospitalsCubit, NearbyHospitalsState>(
      builder: (context, state) {
        if (state is NearbyHospitalsLoadingState) {
          return const CustomLoadingWidget();
        }

        if (state is NearbyHospitalsSuccessState) {
          final hospitals = state.hospitals ;

          if (hospitals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(appLocalization.noHospitalsFound),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchNearby,
                    child: Text(appLocalization.retry),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final hospital = hospitals[index];
              final hospitalName =
                  hospital.name ?? appLocalization.unknownHospital;

              final distance = _formatDistance(hospital);
              final isSelected = selectedHospital == hospitalName;

              return HospitalCard(
                hospitalName: hospitalName,
                distance: distance,
                isSelect: isSelected,
                onTap: () {
                  context.read<DonationScheduleCubit>().setLocation(
                    hospitalName,
                    hospital.hospitalId ?? 'unknown_id',
                  );
                  widget.nextStep();
                },
              );
            },
          );
        }

        if (state is NearbyHospitalsErrorState) {
          log('Error fetching hospitals: ${state.error}');

          final isPermissionError = state.error.toLowerCase().contains(
            'permission',
          );

          return CustomErrorWidget(
            message: state.error,
            onRetry: _fetchNearby,
            errorCode: isPermissionError ? 'PERMISSION_DENIED' : null,
          );
        }

        return CustomLoadingWidget(
          indicatorSize: 50,
          message: appLocalization.processingRequest,
        );
      },
    );
  }

  String _formatDistance(Hospitals hospital) {
    final km = hospital.distanceKm;
    if (km == null) return 'Distance unknown';
    return '${km.toStringAsFixed(1)} km away';
  }
}
