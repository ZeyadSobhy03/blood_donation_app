import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/utils/urgency_utils.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/admin_request_model.dart';
import 'manage_request_dialog.dart';

class CustomRequestCard extends StatelessWidget {
  final Requests request;

  const CustomRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.lightRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFEF4444), width: 4.0),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: request.hospitalName ?? '',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: UrgencyUtils.getBadgeColor(
                        request.urgencyLevel ?? request.urgency ?? 'low',
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      text: UrgencyUtils.getBadgeLabel(
                        request.urgencyLevel ?? request.urgency ?? 'low',
                        appLocalizations,
                      ),
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomText(
                text:
                    "${request.unitsRequested ?? request.unitsNeeded ?? 0} ${appLocalizations.units} • ${appLocalizations.hours_left(request.completionTimeInHours ?? 0)}",
                textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: CustomText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                           text: _formatAddress(request.hospital),
                            textStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Icon(
                            Icons.people_outline,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "${request.donorsContacted ?? 0}",
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              CustomText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: appLocalizations.donorsContactedLabel,
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: "${request.donorsConfirmed ?? 0}",
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              CustomText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: appLocalizations.donorsConfirmedLabel,
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context) => ManageRequestDialog(
                        request: request,

                      ),
                    );
                  },
                  child: CustomText(
                    text: appLocalizations.manageButton,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _formatAddress(Hospital? hospital) {
    if (hospital == null) return '';
    if (hospital.addressRaw != null && hospital.addressRaw!.isNotEmpty) {
      return hospital.addressRaw!;
    }
    final address = hospital.address;
    if (address == null) return '';
    final parts = [
      address.district,
      address.city,
      address.governorate,
    ].where((p) => p != null && p.isNotEmpty).toList();
    return parts.join(', ');
  }
}
