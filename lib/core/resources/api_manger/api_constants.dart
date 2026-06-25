class ApiManger {
  static const String baseUrl =
      "https://graduation-project-cy61.onrender.com/";
  static const String hospitalsEndpoint = "${baseUrl}hospitals";

  static const String nearbyHospitalsEndpoint = "${baseUrl}hospitals/nearby";
  static const String hospitalDetailsEndpoint = "${baseUrl}hospitals/";
  static const String notificationsEndpoint = "${baseUrl}notifications";
  static const String forgetPasswordEndpoint ="${baseUrl}auth/forgot-password";

// https://graduation-project-cy61.onrender.com/donor/stats
  static String markOneAsReadEndpoint(String id) {
    return "${baseUrl}notifications/$id/read";
  }
  static String markAllAsReadEndpoint() {
    return "${baseUrl}notifications/read-all";
  }
  static String getOneNotificationEndpoint(String id) {
    return "${baseUrl}notifications/$id";
  }
  static String deleteOneNotificationEndpoint(String id) {
    return "${baseUrl}notifications/$id";
  }
  static const String nearbyHospitalsEndpointWithQuery = "${baseUrl}hospitals/nearby?lat={lat}&lng={lng}";

  /////////////////////////////////////  donor endpoints  /////////////////////////////////////
// https://graduation-project-cy61.onrender.com/auth/signup
  static const String signUpEndpoint = "${baseUrl}auth/signup";
  static const String loginEndpoint = "${baseUrl}auth/login";
  static const String refreshTokenEndpoint = "${baseUrl}auth/refresh-token";
static const String getDonorStatsEndpoint = "${baseUrl}donor/stats";
static const String verifyEmailEndpoint = "${baseUrl}auth/verify-email";
static const String verifyEmailOtpEndpoint = "${baseUrl}auth/verify-email-otp";

static const String profileEndpoint = "${baseUrl}donor/profile";


/////////////////////////////////   hospital endpoints   /////////////////////////////////////////
//


static const String hospitalLoginEndpoint = "${baseUrl}auth/hospital/login";
static const String hospitalFindDonorsEndpoint = "${baseUrl}hospital/find-donors";
static const String hospitalHistoryEndpoint = "${baseUrl}hospital/history";
static const String hospitalCreateRequestEndpoint = "${baseUrl}hospital/request";
static const String hospitalCreateEmergencyRequestEndpoint = "${baseUrl}hospital/requests/create-emergency";
static const String hospitalDashboardEndpoint = "${baseUrl}hospital/dashboard";
static const String hospitalActivityEndpoint = "${baseUrl}hospital/activity";
static const String hospitalRequestsEndpoint = "${baseUrl}hospital/requests";
static const String hospitalNearbyDonorsEndpoint = "${baseUrl}hospital/nearby-donors";
static const String hospitalProfileEndpoint = "${baseUrl}hospital/profile";
static const String hospitalChangePasswordEndpoint = "${baseUrl}hospital/profile/password";

static String hospitalRequestByIdEndpoint(String requestId) =>
  "${baseUrl}hospital/requests/$requestId";
static String hospitalRequestResponsesEndpoint(String requestId) =>
      "${baseUrl}hospital/requests/$requestId/responses";

////////////////////////////// appointments endpoints //////////////////////////////
static const String hospitalAppointmentsEndpoint = "${baseUrl}hospital/appointments";
static const String appointmentVerifyQrEndpoint = "${baseUrl}appointments/verify-qr";
static const String donationCompleteEndpoint = "${baseUrl}donations/complete";

static String hospitalAppointmentByIdEndpoint(String appointmentId) =>
    "${baseUrl}hospital/appointments/$appointmentId";
static String appointmentVerifyEndpoint(String appointmentId) =>
    "${baseUrl}appointments/$appointmentId/verify";
static String appointmentRejectEndpoint(String appointmentId) =>
    "${baseUrl}appointments/$appointmentId/reject";
}
