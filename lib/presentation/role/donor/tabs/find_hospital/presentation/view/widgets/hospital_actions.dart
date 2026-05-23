import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:flutter/material.dart';

import 'contact_hospital_button.dart';
import 'navigate_hospital_button.dart';

class HospitalActions extends StatelessWidget {
  const HospitalActions({super.key, required this.hospitals});

  final Hospitals hospitals;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContactHospitalButton(
            hospitalNumber: hospitals.phoneNumber ?? 'No phone number available',

            hospitalName: hospitals.name ?? 'No hospital name available',
            bloodType: hospitals.bloodTypes ?? [],
          ),
        ),
        Expanded(
          child: NavigateHospitalButton(
            hospitals: hospitals,

          ),
        ),
      ],
    );
  }
}
