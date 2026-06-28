import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/widgets/donor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../data/models/home_nearby_donors_model.dart';

class NearbyDonorCard extends StatelessWidget {
  const NearbyDonorCard({super.key, required this.groups});

  final List<BloodTypeDonorGroup> groups;

  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;

  int _getCrossAxisCount(double width) {
    if (width >= _tabletBreakpoint) return 4;
    if (width >= _mobileBreakpoint) return 3;
    return 2;
  }

  double _getChildAspectRatio(double width) {
    if (width >= _tabletBreakpoint) return 4 / 3;
    if (width >= _mobileBreakpoint) return 3 / 2;
    return 3 / 2;
  }

  double _getHorizontalPadding(double width) {
    if (width >= _tabletBreakpoint) return 24;
    if (width >= _mobileBreakpoint) return 20;
    return 16;
  }

  double _getTitleFontSize(double width) {
    if (width >= _tabletBreakpoint) return FontSize.s18;
    if (width >= _mobileBreakpoint) return FontSize.s16;
    return FontSize.s15;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= _tabletBreakpoint;
        final hPadding = _getHorizontalPadding(width);

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isDesktop ? 16 : 12.r),
          ),
          color: ColorManger.pureWhite,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: hPadding,
              vertical: isDesktop ? 16 : 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: appLocalizations.nearby_donor,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: _getTitleFontSize(width),
                  ),
                ),
                SizedBox(height: isDesktop ? 20 : 16),
                if (groups.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CustomText(
                        text: appLocalizations.noNearbyDonorsFound,
                        textStyle: TextStyle(
                          color: ColorManger.slateGrey,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(width),
                      mainAxisSpacing: isDesktop ? 16 : 12,
                      crossAxisSpacing: isDesktop ? 16 : 12,
                      childAspectRatio: _getChildAspectRatio(width),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return DonorTile(
                        bloodType: group.bloodType ?? '',
                        numberOfDonor: group.count ?? 0,
                        nearestDistanceKm: group.nearestDistanceKm,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
