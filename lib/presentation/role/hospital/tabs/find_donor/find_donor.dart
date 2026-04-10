import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/section/find_nearby_donors_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../core/resources/models/donor.dart';
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
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  late List<DonorModel> filteredDonors;
  bool showFilter = false;
  bool isAscending = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredDonors = donors;
  }

  void _applyFilters() {
    filteredDonors = donors.where((donor) {
      final matchesName = donor.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesBlood =
          _selectedBloodType == null || donor.bloodType == _selectedBloodType;
      return matchesName && matchesBlood;
    }).toList();
  }

  void filterByBloodType(String? bloodType) {
    setState(() {
      _selectedBloodType = bloodType;
      _applyFilters();
    });
  }

  void sortByDistance() {
    filteredDonors.sort((a, b) {
      return isAscending
          ? a.location.compareTo(b.location)
          : b.location.compareTo(a.location);
    });

    setState(() {
      isAscending = !isAscending;
    });
  }

  final List<DonorModel> donors = [
    DonorModel(
      donorRank: 3,
      id: '1',
      name: 'Ahmed Mohamed',
      email: 'ahmed@gmail.com',
      phoneNumber: '01012345678',
      bloodType: 'A+',
      totalDonations: 5,
      points: 120,
      isEligibleToDonate: true,
      location: 'Alexandria',
      isActive: true,
      isVerified: true,
      gender: 'Male',
      age: 25,
      weight: 75,
      healthStatus: 'Good',
      isBanned: false,
      isOnline: true,
      createdAt: DateTime.now(),
    ),

    DonorModel(
      donorRank: 4,
      id: '2',
      name: 'Sara Ali',
      email: 'sara@gmail.com',
      phoneNumber: '01123456789',
      bloodType: 'O-',
      totalDonations: 3,
      points: 80,
      isEligibleToDonate: true,
      location: 'Cairo',
      isActive: true,
      isVerified: true,
      gender: 'Female',
      age: 23,
      weight: 60,
      healthStatus: 'Very Good',
      isBanned: false,
      isOnline: false,
      createdAt: DateTime.now(),
    ),

    DonorModel(
      donorRank: 5,
      id: '3',
      name: 'Omar Hassan',
      email: 'omar@gmail.com',
      phoneNumber: '01234567890',
      bloodType: 'B+',
      totalDonations: 7,
      points: 200,
      isEligibleToDonate: false,
      location: 'Giza',
      isActive: true,
      isVerified: false,
      gender: 'Male',
      age: 30,
      weight: 82,
      healthStatus: 'Excellent',
      isBanned: false,
      isOnline: true,
      createdAt: DateTime.now(),
    ),

    DonorModel(
      donorRank: 6,
      id: '4',
      name: 'Mona Adel',
      email: 'mona@gmail.com',
      phoneNumber: '01598765432',
      bloodType: 'AB+',
      totalDonations: 2,
      points: 40,
      isEligibleToDonate: true,
      location: 'Tanta',
      isActive: false,
      isVerified: true,
      gender: 'Female',
      age: 28,
      weight: 65,
      healthStatus: 'Good',
      isBanned: false,
      isOnline: false,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
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
                  title: appLocalization.find_donors,
                  subTitle: appLocalization.find_donors_dec,
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _applyFilters();
                    });


                  },

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: appLocalization.donors_found(filteredDonors.length),
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
                  itemCount: filteredDonors.length,
                  itemBuilder: (context, index) {
                    final donors = filteredDonors[index];
                    return FindNearbyDonorsCard(donor: donors);
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
