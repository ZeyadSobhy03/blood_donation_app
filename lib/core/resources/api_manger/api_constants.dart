class ApiManger {
  static const String baseUrl = "https://graduation-project-cy61.onrender.com/";
  static const String hospitalsEndpoint = "${baseUrl}hospitals";

  static const String nearbyHospitalsEndpoint = "${baseUrl}hospitals/nearby";
  static const String hospitalDetailsEndpoint = "${baseUrl}hospitals/";
  static const String notificationsEndpoint = "${baseUrl}notifications";


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

  static const String nearbyHospitalsEndpointWithQuery =
      "${baseUrl}hospitals/nearby?lat={lat}&lng={lng}";

  /////////////////////////////////////  donor endpoints  /////////////////////////////////////
  static const String signUpEndpoint = "${baseUrl}auth/signup";
  static const String loginEndpoint = "${baseUrl}auth/login";
  static const String refreshTokenEndpoint = "${baseUrl}auth/refresh-token";
  static const String getDonorStatsEndpoint = "${baseUrl}donor/stats";
  static const String verifyEmailEndpoint = "${baseUrl}auth/verify-email";
  static const String verifyEmailOtpEndpoint =
      "${baseUrl}auth/verify-email-otp";

  static const String profileEndpoint = "${baseUrl}donor/profile";
  static const String nearbyHospitals = "${baseUrl}hospitals/nearby";
  static const String searchNearbyHospitals = "${baseUrl}hospitals/search";
  ////////////// donations endpoints  /////////////
  static const String appointmentsEndpoint = "${baseUrl}donations/my-appointments";
  static  String cancelAppointmentEndpoint(String appointmentId) {
    return "${baseUrl}donations/book-appointment/$appointmentId";
  }
  static const String badgesEndpoint = "${baseUrl}rewards/badges";
  static const String rewardsEndpoint = "${baseUrl}rewards/catalog";
  static const String earningRulesEndpoint= "${baseUrl}rewards/earning-rules";
  static  String redeemRewardEndpoint(String rewardId) {
    return "${baseUrl}rewards/catalog/$rewardId/redeem";
  }
  static const String requestsNearbyEndPoint = "${baseUrl}requests/nearby";
  static String acceptRequestEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId/accept";
  }
  static String cancelRequestEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId/cancel";
  }
  // https://graduation-project-cy61.onrender.com/requests/69fe540565ff7785a031314f
  static  String fetchByRequestIdEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId";
  }
  static const String editProfileEndpoint = "${baseUrl}donor/profile";
  static const String deleteNotificationEndpoint = "${baseUrl}notifications/";
  static const String donorSates= "${baseUrl}donor/stats";
  // https://graduation-project-cy61.onrender.com/donor/activity
  static const String activityHistoryEndpoint = "${baseUrl}donor/activity";
  // https://graduation-project-cy61.onrender.com/rewards/points
  static const String userPointsEndpoint = "${baseUrl}rewards/points";
  static const String pointsHistoryEndpoint = "${baseUrl}rewards/points/history";
  static const String getSettingEndpoint = "${baseUrl}donor/settings";
  static const String historyEndpoint = "${baseUrl}donor/history";

///////////// notifications endpoints  /////////////
  static const String notificationsListEndpoint = "${baseUrl}notifications";
  static const String markAllNotificationsAsReadEndpoint = "${baseUrl}notifications/read-all";

  //////////////////////// chat bot endpoints  ////////////////////////
static const String chatBotUrl = "https://donation-chatbot-1fie.onrender.com";
static const String askChatBotEndpoint = "$chatBotUrl/ask";
static const String chatEndPoint= "$chatBotUrl/chat";
/////////////////////////////////////////// fcm endpoints  /////////////////////////////////////
  // auth/fcm-token
static const String saveFcmTokenEndpoint = "${baseUrl}auth/fcm-token";
//////////////////////////////////// schedule donation endpoints  /////////////////////////////////////
  // donations/book-appointment/available-slots
  static const String availableSlotsEndpoint = "${baseUrl}donations/book-appointment/available-slots";
// https://graduation-project-cy61.onrender.com/donations/book-appointment/available-slots
}
