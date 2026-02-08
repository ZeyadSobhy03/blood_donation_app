import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindHospital extends StatelessWidget {
  const FindHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomText(
                  text: 'Find Hospitals',
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s15,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  prefixIcon: Icon(Icons.search,color: ColorManger.slateGrey,),
                  hintText: 'Search by name or location..',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_alt_outlined,color: ColorManger.slateGrey,),
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
