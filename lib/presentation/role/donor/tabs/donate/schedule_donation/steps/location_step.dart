// import 'dart:developer';
//
// import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
// import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
// import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/presentation/view_model/schedule_donation_view_model.dart';
// import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/hospital_card.dart';
// import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../../l10n/app_localizations.dart';
// import '../cubit/donation_schedule.dart';
//
// class LocationStep extends StatefulWidget {
//   const LocationStep({super.key, required this.nextStep});
//
//   final VoidCallback nextStep;
//
//   @override
//   State<LocationStep> createState() => _LocationStepState();
// }
//
// class _LocationStepState extends State<LocationStep> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch nearby hospitals when screen loads
//     Future.microtask(() {
//       context.read<ScheduleDonationCubit>().fetchNearbyHospitals();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appLocalization = AppLocalizations.of(context)!;
//     final donationScheduleCubit = context.watch<DonationScheduleCubit>();
//     final selectedHospital = donationScheduleCubit.state.schedule.location;
//
//
//     return Padding(
//       padding: EdgeInsets.all(8.r),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TitleStep(
//               title: appLocalization.chooseLocationTitle,
//               subTitle: appLocalization.chooseLocationSubtitle,
//             ),
//             SizedBox(height: 12.h),
//             Expanded(
//               child: _buildHospitalsList(
//                 context,
//                 selectedHospital,
//                 appLocalization,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHospitalsList(
//     BuildContext context,
//     String? selectedHospital,
//     AppLocalizations appLocalization,
//   ) {
//     return BlocBuilder<ScheduleDonationCubit, ScheduleDonationState>(
//       builder: (context, state) {
//         if (state is ScheduleDonationLoadingState) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         if (state is ScheduleDonationLoadedState) {
//           if (state.hospitals.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.location_off, size: 48, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text('No hospitals found nearby'),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<ScheduleDonationCubit>()
//                           .retryFetchingHospitals();
//                     },
//                     child: Text('Try Again'),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.builder(
//             itemCount: state.hospitalCount,
//             itemBuilder: (context, index) {
//               // Get hospital from state
//               final hospital = state.getHospitalAt(index);
//               if (hospital == null) return SizedBox.shrink();
//
//               final hospitalName = hospital.name ?? 'Unknown Hospital';
//               final distance = _calculateDistance(hospital) ?? 'Distance unknown';
//               final isSelected = selectedHospital == hospitalName;
//
//               return HospitalCard(
//                 hospitalName: hospitalName,
//                 distance: distance,
//                 isSelect: isSelected,
//                 onTap: () {
//                   context
//                       .read<DonationScheduleCubit>()
//                       .setLocation(hospitalName);
//                   widget.nextStep();
//                 },
//               );
//             },
//           );
//         }
//
//         // Error state
//         if (state is ScheduleDonationErrorState) {
//           log('Error fetching hospitals: ${state.error}');
//           return CustomErrorWidget(
//             message: state.error,
//             onRetry: () {
//               context.read<ScheduleDonationCubit>().retryFetchingHospitals();
//             },
//             errorCode: state.isLocationPermissionError ? 'PERMISSION_DENIED' : null,
//           );
//         }
//
//         // Initial state
//         return CustomLoadingWidget(
//           indicatorSize: 50,
//           message: appLocalization.processingRequest,
//         );
//       },
//     );
//   }
//
//   String? _calculateDistance(dynamic hospital) {
//     try {
//       if (hospital?.location?.coordinates?.lat != null &&
//           hospital?.location?.coordinates?.lng != null) {
//         final distance = hospital.location.coordinates.lat as double;
//         return '${distance.toStringAsFixed(1)} km away';
//       }
//     } catch (e) {
//       // Fallback if distance calculation fails
//     }
//     return null;
//   }
// }
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/hospital_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';

class LocationStep extends StatelessWidget {
  const LocationStep({super.key, required this.nextStep});

  final VoidCallback nextStep;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    List<Map<String, String>> hospitals = [
      {"name": "City Hospital", "dist": "2.3 km away"},
      {"name": "Metro Hospital", "dist": "4.1 km away"},
      {"name": "Central Blood Bank", "dist": "5.8 km away"},
      {"name": "Community Health Center", "dist": "7.2 km away"},
    ];

    final scheduleCubit = context.watch<DonationScheduleCubit>();
    final selectedHospital = scheduleCubit.state.schedule.location;

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
              child: ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospitalName = hospitals[index]['name']!;
                  return HospitalCard(
                    hospitalName: hospitalName,
                    distance: hospitals[index]['dist']!,
                    isSelect: selectedHospital == hospitalName,
                    onTap: () {
                      scheduleCubit.setLocation(hospitalName);
                      nextStep();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
