import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/blood_need_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/hospital_info_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/map_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_details_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/response_matters_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/request_screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'model/urgent_request.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  UrgentRequestModel? urgentRequest;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    urgentRequest =
    ModalRoute.of(context)!.settings.arguments as UrgentRequestModel;
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
                        time: urgentRequest!.time,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HospitalInfoCard(
                  distance: urgentRequest!.hospitalDistance,
                  hospitalName: urgentRequest!.hospitalName,
                  unitsNeeded:
                  '${urgentRequest!.unitsNeeded} ${appLocalizations.units}',
                  onNavigate: () {},
                  iconColor: ColorManger.brightRed,
                  location: urgentRequest!.location,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RequestDetailsSection(
                  posted: urgentRequest!.time,
                  contact: urgentRequest!.contactNumber,
                  patientType: urgentRequest!.patientType,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MapCard(hospitalName: urgentRequest!.hospitalName),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ResponseMattersSection(),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RequestNavigationButtons(
                  accept: () {},
                  cancel: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
