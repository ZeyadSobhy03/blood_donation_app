class ApiManger {
  static const String baseUrl =
      "https://graduation-project-cy61.onrender.com/";
  static const String hospitalsEndpoint = "${baseUrl}hospitals";

  static const String nearbyHospitalsEndpoint = "${baseUrl}hospitals/nearby";
  static const String hospitalDetailsEndpoint = "${baseUrl}hospitals/";
  static const String notificationsEndpoint = "${baseUrl}notifications";

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
}
