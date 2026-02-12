import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/blood_need_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/hospital_info_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/map_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_details_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/response_matters_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/request_screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/resources/routes/route_manger.dart';
import 'model/urgent_request.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  UrgentRequestModel? urgentRequest;
  late MapCubit mapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    urgentRequest =
        ModalRoute.of(context)!.settings.arguments as UrgentRequestModel;
  }

  Future<void> _openDirections() async {
    final lat = urgentRequest!.locationHospital.latitude;
    final lng = urgentRequest!.locationHospital.longitude;

    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }

  String formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapCubit = context.read<MapCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: urgentRequest!.isEmergency
                      ? ColorManger.brightRed
                      : ColorManger.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      RequestScreenTitle(
                        statusColor: urgentRequest!.isEmergency
                            ? ColorManger.brightRed
                            : ColorManger.orange,
                        title: urgentRequest!.isEmergency
                            ? appLocalizations.emergencyRequest
                            : appLocalizations.criticalRequest,
                        time: formatTimeAgo(urgentRequest!.createdAt),
                        status: urgentRequest!.isEmergency
                            ? appLocalizations.emergency
                            : appLocalizations.critical,
                      ),
                      SizedBox(height: 8.h),
                      BloodNeedCard(
                        bloodType: urgentRequest!.bloodType,
                        background: urgentRequest!.isEmergency
                            ? ColorManger.brightRed
                            : ColorManger.orange,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              BlocBuilder<MapCubit, MapState>(
                builder: (context, state) {
                  double? distanceKm;
                  if (state is MapLoaded) {
                    final hospitalLat =
                        urgentRequest!.locationHospital.latitude;
                    final hospitalLng =
                        urgentRequest!.locationHospital.longitude;
                    final distanceInMeters = mapCubit.calculateDistance(
                      state.latitude,
                      state.longitude,
                      hospitalLat,
                      hospitalLng,
                    );

                    distanceKm = distanceInMeters / 1000;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HospitalInfoCard(
                      distance: distanceKm != null
                          ? AppLocalizations.of(context)!.kmAway(distanceKm.toStringAsFixed(1))
                          : AppLocalizations.of(context)!.gettingDistance,
                      hospitalName: urgentRequest!.hospitalName,
                      unitsNeeded:
                          '${urgentRequest!.unitsNeeded} ${appLocalizations.units}',
                      onNavigate: _openDirections,
                      iconColor: ColorManger.brightRed,
                      location: distanceKm != null
                          ? AppLocalizations.of(
                              context,
                            )!.distanceAway(distanceKm.toStringAsFixed(1))
                          : AppLocalizations.of(context)!.gettingDistance,
                    ),
                  );
                },
              ),

              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RequestDetailsSection(
                  posted: formatTimeAgo(urgentRequest!.createdAt),
                  contact: urgentRequest!.contactNumber,
                  patientType: urgentRequest!.patientType,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MapCard(
                  hospitalName: urgentRequest!.hospitalName,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManger.mapScreen,
                      arguments: urgentRequest!.locationHospital,
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ResponseMattersSection(),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RequestNavigationButtons(accept: () {}, cancel: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
