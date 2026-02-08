import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/navigate_hospital_button.dart';
import 'package:flutter/material.dart';

import '../model/hospital_request_model.dart';
import 'contact_hospital_button.dart';

class HospitalActions extends StatelessWidget {
  const HospitalActions({super.key, required this.hospitalRequestModel});

  final HospitalRequestModel hospitalRequestModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContactHospitalButton(
            hospitalNumber: hospitalRequestModel.phoneNumber,

            hospitalName: hospitalRequestModel.hospitalName,
            bloodType: hospitalRequestModel.bloodTypes,
          ),
        ),
        Expanded(
          child: NavigateHospitalButton(
            hospitalName: hospitalRequestModel.hospitalName,
            distanceKm: hospitalRequestModel.distanceKm,
          ),
        ),
      ],
    );
  }
}
