import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donation_eligibility/donation_eligibility_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';


class DonationStatusCard extends StatelessWidget {
  const DonationStatusCard({
    super.key,
    required this.bloodType,
  });

  final String bloodType;

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String _getDaysRemainingText(int? days) {
    if (days == null || days <= 0) return '';
    if (days == 1) return '1 day remaining';
    return '$days days remaining';
  }

  String _getLocalizedReason(String? reason, AppLocalizations l10n) {
    if (reason == null || reason.isEmpty) return '';

    switch (reason) {
      case 'eligibility.donationCooldownActive':
        return l10n.donationCooldownActive;
      case 'eligibility.donorOptedOutOfMatching':
        return l10n.donorOptedOutOfMatching;
      case 'eligibility.donorHasNoBloodType':
        return l10n.donorHasNoBloodType;
      case 'eligibility.bloodTypeIncompatible':
        return l10n.bloodTypeIncompatible;
      case 'eligibility.dateOfBirthRequired':
        return l10n.dateOfBirthRequired;
      case 'eligibility.invalidDateOfBirth':
        return l10n.invalidDateOfBirth;
      case 'eligibility.ageVerificationFailed':
        return l10n.ageVerificationFailed;
      case 'eligibility.donorNotFound':
        return l10n.donorNotFound;
      case 'eligibility.hemoglobinBelowMinimum':
        return l10n.hemoglobinBelowMinimum;
      case 'eligibility.outsideMatchingRadius':
        return l10n.outsideMatchingRadius;
      case 'eligibility.donorNotEligible':
        return l10n.donorNotEligible;

    // Legacy cases (keeping for backward compatibility)
      case 'donorEligible':
        return l10n.donorEligible;
      case 'donorOrRequestNotFound':
        return l10n.donorOrRequestNotFound;
      case 'matchingLocationUnavailable':
        return l10n.matchingLocationUnavailable;
      case 'requestNotFound':
        return l10n.requestNotFound;
      case 'noTemporaryDeferral':
        return l10n.noTemporaryDeferral;
      case 'temporaryDeferralExpired':
        return l10n.temporaryDeferralExpired;
      case 'temporarilyDeferred':
        return l10n.temporarilyDeferred;
      case 'travelDeferral':
        return l10n.travelDeferral;
      case 'noDonationIntervalRestriction':
        return l10n.noDonationIntervalRestriction;
      case 'invalidLastDonationDateIgnored':
        return l10n.invalidLastDonationDateIgnored;
      case 'donationIntervalSatisfied':
        return l10n.donationIntervalSatisfied;
      case 'noHemoglobinRestriction':
        return l10n.noHemoglobinRestriction;
      case 'hemoglobinLevelAcceptable':
        return l10n.hemoglobinLevelAcceptable;
      case 'donorSuspended':
        return l10n.donorSuspended;
      case 'donorCurrentlyUnavailable':
        return l10n.donorCurrentlyUnavailable;
      case 'requestNoLongerActive':
        return l10n.requestNoLongerActive;

    // Plain text error messages (localized)
      case 'Donor account is deleted or inactive':
        return l10n.donorAccountDeletedOrInactive;
      case 'Invalid donor role':
        return l10n.invalidDonorRole;
      case 'Donor account is suspended':
        return l10n.donorAccountSuspended;
      case 'Donor has chronic medical conditions':
        return l10n.donorChronicMedicalConditions;
      case 'Donor already has an active donation in progress':
        return l10n.donorActiveDonationInProgress;
      case 'Donor has already completed or rejected this request':
        return l10n.donorCompletedOrRejectedRequest;
      case 'You cannot specify another donor\'s ID — only your authenticated ID is used':
        return l10n.cannotSpecifyAnotherDonorId;
      case 'requestId and donationType parameters are not accepted on this endpoint':
        return l10n.requestIdAndDonationTypeNotAccepted;
      case 'Donor not found':
        return l10n.donorNotFound;
      case 'Authenticated donor ID not found in authentication token':
        return l10n.authenticatedDonorIdNotFound;

    // Dynamic error messages
      default:
        if (reason.startsWith('Error validating eligibility:')) {
          return reason; // Return as-is (already contains error details)
        }
        return reason; // Fallback: return the reason as-is
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationEligibilityCubit, DonationEligibilityState>(
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final eligibilityData = state is DonationEligibilitySuccess
            ? state.donationEligibilityModel.data
            : null;

        final isEligible = eligibilityData?.isEligible ?? false;
        final reason = eligibilityData?.reason;
        final nextEligibleDate = eligibilityData?.nextEligibleDate;
        final daysRemaining = eligibilityData?.daysRemaining ?? 0;
        final lastDonationDate = eligibilityData?.lastDonationDate;

        return Card(
          color: isEligible ? ColorManger.brightRed : const Color(0xFFD32F2F),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double minWidth = 300;
              double maxWidth = constraints.maxWidth;

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: appLocalizations.donationStatus,
                                  textStyle: TextStyle(
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeightManager.bold,
                                    color: ColorManger.pureWhite,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                        color: isEligible ? ColorManger.green : Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: CustomText(
                                        text: isEligible
                                            ? appLocalizations.eligibleToDonate
                                            : appLocalizations.notEligible,
                                        textStyle: TextStyle(
                                          color: ColorManger.pureWhite,
                                          fontSize: FontSize.s14,
                                          fontWeight: FontWeightManager.semiBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ColorManger.pureWhite.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                  color: ColorManger.pureWhite,
                                  size: 36,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManger.pureWhite,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  text: '$bloodType ${appLocalizations.donor}',
                                  textStyle: TextStyle(
                                    color: isEligible ? ColorManger.brightRed : const Color(0xFFD32F2F),
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      if (isEligible) ...[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorManger.pureWhite.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: '✓ ${appLocalizations.readyToSaveLives}',
                                textStyle: TextStyle(
                                  color: ColorManger.pureWhite,
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.medium,
                                ),
                              ),
                              if (lastDonationDate != null && lastDonationDate.isNotEmpty) ...[
                                SizedBox(height: 6),
                                CustomText(
                                  text: '${appLocalizations.lastDonation}: ${_formatDate(lastDonationDate)}',
                                  textStyle: TextStyle(
                                    color: ColorManger.pureWhite.withValues(alpha: 0.8),
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ] else ...[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorManger.pureWhite.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (reason != null && reason.toString().isNotEmpty) ...[
                                CustomText(
                                  text: '${appLocalizations.reason}: ${_getLocalizedReason(reason.toString(), appLocalizations)}',
                                  textStyle: TextStyle(
                                    color: ColorManger.pureWhite,
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),
                                SizedBox(height: 6),
                              ],
                              if (nextEligibleDate != null && nextEligibleDate.toString().isNotEmpty) ...[
                                CustomText(
                                  text: '${appLocalizations.canDonate}: ${_formatDate(nextEligibleDate.toString())}',
                                  textStyle: TextStyle(
                                    color: ColorManger.pureWhite,
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),
                              ],
                              if (daysRemaining > 0) ...[
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: ColorManger.pureWhite,
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    CustomText(
                                      text: '⏱ ${_getDaysRemainingText(daysRemaining)}',
                                      textStyle: TextStyle(
                                        color: ColorManger.pureWhite.withValues(alpha: 0.9),
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeightManager.semiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (lastDonationDate != null && lastDonationDate.isNotEmpty) ...[
                                SizedBox(height: 6),
                                CustomText(
                                  text: '${appLocalizations.lastDonation}: ${_formatDate(lastDonationDate)}',
                                  textStyle: TextStyle(
                                    color: ColorManger.pureWhite.withValues(alpha: 0.8),
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}