import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/section/change_location_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/widgets/donor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class NearbyDonorCard extends StatelessWidget {
  const NearbyDonorCard({super.key});

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
        final isTablet = width >= _mobileBreakpoint;
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
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: appLocalizations.nearby_donor,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontWeight: FontWeightManager.semiBold,
                          fontSize: _getTitleFontSize(width),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isDesktop ? 200 : (isTablet ? 180 : null),
                      child: CustomElevatedButton(
                        backgroundColor: ColorManger.pureWhite,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const ChangeLocationDialog(),
                          );
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 16 : 12,
                          vertical: isDesktop ? 8 : 6,
                        ),
                        foregroundColor: ColorManger.black,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(isDesktop ? 10 : 8.r),
                          side: BorderSide(
                            color: ColorManger.lightGrey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: isDesktop ? 18 : 16,
                            ),
                            SizedBox(width: isDesktop ? 6 : 4),
                            Flexible(
                              child: CustomText(
                                text: appLocalizations.change_location,
                                textStyle: TextStyle(
                                  color: ColorManger.black,
                                  fontSize:
                                  isDesktop ? FontSize.s13 : FontSize.s12,
                                  fontWeight: FontWeightManager.regular,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isDesktop ? 20 : 16),

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(width),
                    mainAxisSpacing: isDesktop ? 16 : 12,
                    crossAxisSpacing: isDesktop ? 16 : 12,
                    childAspectRatio: _getChildAspectRatio(width),
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) => DonorTile(
                    bloodType: 'A+',
                    numberOfDonor: 5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}