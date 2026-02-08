import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/hospital_icon.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/hospital_info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../model/hospital_request_model.dart';


class HospitalHeader extends StatelessWidget {
  const HospitalHeader({super.key, required this.hospitalRequestModel});
  final  HospitalRequestModel hospitalRequestModel;
  void callHospital(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HospitalIcon(),
        SizedBox(width: 16),
        HospitalInfo(
          hospitalRequestModel:hospitalRequestModel ,
        ),
        Spacer(),
        IconButton(
          onPressed: () => callHospital(hospitalRequestModel.phoneNumber),
          icon: Icon(Icons.phone, color: ColorManger.brightRed),
        ),

      ],
    );
  }
}
