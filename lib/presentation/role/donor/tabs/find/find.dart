import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/section/blood_filter.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/section/hospital_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/custom_hospital_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../request_screen/widgets/map_card.dart';
import 'model/hospital_request_model.dart';

class FindHospital extends StatefulWidget {
  const FindHospital({super.key});

  @override
  State<FindHospital> createState() => _FindHospitalState();
}

class _FindHospitalState extends State<FindHospital> {
  late List<HospitalRequestModel> filteredHospitals;
  bool isSortedByDistance = false;
  bool isAscending = true;

  void sortByDistance() {
    filteredHospitals.sort((a, b) {
      return isAscending
          ? a.distanceKm.compareTo(b.distanceKm)
          : b.distanceKm.compareTo(a.distanceKm);
    });

    setState(() {
      isAscending = !isAscending;
    });
  }

  void filterByBloodType(String? bloodType) {
    if (bloodType == null) {
      filteredHospitals = hospitals;
    } else {
      filteredHospitals = hospitals
          .where((hospital) => hospital.bloodTypes == bloodType)
          .toList();
    }
    setState(() {});
  }

  bool showFilter = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredHospitals = hospitals;
  }

  final List<HospitalRequestModel> hospitals = [
    HospitalRequestModel(
      id: '1',
      hospitalName: 'City General Hospital',
      hospitalType: 'Government Hospital',
      phoneNumber: '+201551764651',
      bloodTypes: 'O+',
      isAvailable: true,
      distanceKm: 1.2,
      urgentNeedsCount: 2,
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    HospitalRequestModel(
      id: '2',
      hospitalName: 'Al Salam Hospital',
      hospitalType: 'Private Hospital',
      phoneNumber: '+201551764651',
      bloodTypes: 'A-',
      isAvailable: true,
      distanceKm: 3.5,
      urgentNeedsCount: 1,
      latitude: 30.0500,
      longitude: 31.2333,
    ),
    HospitalRequestModel(
      id: '3',
      hospitalName: 'El Noor Medical Center',
      hospitalType: 'Medical Center',
      phoneNumber: '+201551764651',
      bloodTypes: 'AB-',
      isAvailable: false,
      distanceKm: 5.0,
      urgentNeedsCount: 4,
      latitude: 30.0600,
      longitude: 31.2400,
    ),
    HospitalRequestModel(
      id: '4',
      hospitalName: 'Misr International Hospital',
      hospitalType: 'Private Hospital',
      phoneNumber: '+201551764651',
      bloodTypes: 'O+',
      isAvailable: true,
      distanceKm: 0.8,
      urgentNeedsCount: 3,
      latitude: 30.0420,
      longitude: 31.2300,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: appLocalization.findHospitals,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s15,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  prefixIcon: Icon(Icons.search, color: ColorManger.slateGrey),
                  hintText: appLocalization.searchHint,
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
                showFilter
                    ? BloodFilter(
                        onBloodTypeChanged: filterByBloodType,
                        onClear: () {
                          filterByBloodType(null);
                        },
                      )
                    : SizedBox(height: 12.h),
                MapCard(
                  hospitalName: appLocalization.hospitalsNearby(
                    filteredHospitals.length,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: appLocalization.hospitalsFound(
                        filteredHospitals.length,
                      ),
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s15,
                      ),
                    ),
                    CustomHospitalButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.rotate(
                            angle: -0.785,
                            child: Icon(
                              Icons.send_rounded,

                              color: ColorManger.black,
                            ),
                          ),
                          CustomText(
                            text: appLocalization.sortByDistance,
                            textStyle: TextStyle(fontSize: FontSize.s14),
                          ),
                        ],
                      ),
                      onPressed: sortByDistance,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredHospitals.length,
                  itemBuilder: (context, index) => HospitalCard(
                    hospitalRequestModel: filteredHospitals[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
