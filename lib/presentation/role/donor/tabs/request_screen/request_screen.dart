import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/blood_need_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/hospital_info_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/map_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_details_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/request_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/section/response_matters_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/widgets/request_screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/resources/models/coordinates.dart';
import '../../../../../core/resources/routes/route_manger.dart';
import '../donate/section/qr_code_card.dart';
import '../home/presentation/view_model/requests/accept_request_view_model.dart';
import '../home/presentation/view_model/requests/cancel_request_view_model.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Requests? urgentRequest;
  DateTime _createdAt = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    urgentRequest = ModalRoute.of(context)!.settings.arguments as Requests;
    _createdAt = urgentRequest?.createdAt != null
        ? DateTime.tryParse(urgentRequest!.createdAt!) ?? DateTime.now()
        : DateTime.now();
  }

  Future<void> _openDirections() async {
    final lat = urgentRequest?.hospital?.latitude ?? 0.0;
    final lng = urgentRequest?.hospital?.longitude ?? 0.0;
    final Uri googleMapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }

  String formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 60) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  // ── Accept ──────────────────────────────────────────────────────────────────
  void _handleAccept(BuildContext context) {
    final requestId = urgentRequest?.id ?? '';
    log('Accepting request with ID: $requestId');
    if (requestId.isEmpty) return;
    context.read<AcceptRequestCubit>().acceptRequest(requestId: requestId);
  }

  // ── Cancel ──────────────────────────────────────────────────────────────────
  void _handleCancel(BuildContext context) {
    final requestId = urgentRequest?.id ?? '';
    log('Cancelling request with ID: $requestId');
    if (requestId.isEmpty) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.cancelRequest),
        content: Text(AppLocalizations.of(context)!.cancelRequestConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.no),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<CancelRequestCubit>()
                  .cancelRequest(requestId: requestId);
            },
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEmergency = urgentRequest?.isEmergency ?? false;
    final statusColor =
    isEmergency ? ColorManger.brightRed : ColorManger.orange;

    return MultiBlocListener(
      listeners: [
        BlocListener<AcceptRequestCubit, AcceptRequestState>(
          listener: (context, state) {
            if (state is AcceptRequestLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AcceptRequestSuccessState) {
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.requestAcceptedSuccessfully),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is AcceptRequestErrorState) {
              log(state.message);
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),

        BlocListener<CancelRequestCubit, CancelRequestState>(
          listener: (context, state) {
            if (state is CancelRequestLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                const Center(child: CircularProgressIndicator()),
              );
            } else if (state is CancelRequestSuccessState) {

              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.requestCancelledSuccessfully),
                  backgroundColor: Colors.orange,
                ),
              );
              Navigator.pop(context);
            } else if (state is CancelRequestErrorState) {
              log(state.message);
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorManger.pureWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: statusColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Column(
                      children: [
                        RequestScreenTitle(
                          statusColor: statusColor,
                          title: isEmergency
                              ? appLocalizations.emergencyRequest
                              : appLocalizations.criticalRequest,
                          time: formatTimeAgo(_createdAt),
                          status: isEmergency
                              ? appLocalizations.emergency
                              : appLocalizations.critical,
                        ),
                        SizedBox(height: 8.h),
                        BloodNeedCard(
                          bloodType: urgentRequest?.bloodType ?? [],
                          background: statusColor,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HospitalInfoCard(
                    distance: urgentRequest?.distanceKm != null
                        ? appLocalizations.kmAway(
                        urgentRequest!.distanceKm!.toStringAsFixed(1))
                        : urgentRequest?.distance ??
                        appLocalizations.gettingDistance,
                    hospitalName: urgentRequest?.hospitalName ?? '',
                    unitsNeeded:
                    '${urgentRequest?.unitsNeeded ?? 0} ${appLocalizations.units}',
                    onNavigate: _openDirections,
                    iconColor: ColorManger.brightRed,
                    location:
                    "${urgentRequest?.hospital?.address?.city ?? ''}, ${urgentRequest?.hospital?.address?.governorate ?? ''}",
                  ),
                ),

                SizedBox(height: 8.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RequestDetailsSection(
                    posted: formatTimeAgo(_createdAt),
                    contact: urgentRequest?.contactNumber ?? '',
                    patientType: urgentRequest?.patientType?.toString() ?? '',
                  ),
                ),

                SizedBox(height: 8.h),

                QrCodeCard(qrToken: urgentRequest?.qrToken ?? ''),

                SizedBox(height: 8.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MapCard(
                    hospitalName: urgentRequest?.hospitalName ?? '',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.mapScreen,
                        arguments: Coordinates(
                          latitude: urgentRequest?.hospital?.latitude ?? 0.0,
                          longitude:
                          urgentRequest?.hospital?.longitude ?? 0.0,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 8.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  ResponseMattersSection(
                    bloodType: urgentRequest?.bloodType?? [],
                    patientType: urgentRequest?.patientType ?? '',
                    unitsNeeded: urgentRequest?.unitsNeeded ?? 0,
                  ),
                ),

                SizedBox(height: 8.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<AcceptRequestCubit, AcceptRequestState>(
                    builder: (context, acceptState) {
                      return BlocBuilder<CancelRequestCubit,
                          CancelRequestState>(
                        builder: (context, cancelState) {
                          final isBusy =
                              acceptState is AcceptRequestLoadingState ||
                                  cancelState is CancelRequestLoadingState;

                          return RequestNavigationButtons(
                            accept: isBusy
                                ? null
                                : () => _handleAccept(context),
                            cancel: isBusy
                                ? null
                                : () => _handleCancel(context),
                          );
                        },
                      );
                    },
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