class ApiManger {
  static const String baseUrl = "https://graduation-project-cy61.onrender.com/";
  static const String hospitalsEndpoint = "${baseUrl}hospitals";

  static const String nearbyHospitalsEndpoint = "${baseUrl}hospitals/nearby";
  static const String hospitalDetailsEndpoint = "${baseUrl}hospitals/";
  static const String notificationsEndpoint = "${baseUrl}notifications";
static const String adminUpdatePasswordEndpoint = "${baseUrl}admin/profile/password";
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

  static const String me = "${baseUrl}auth/me";
  static const String validateToken = "${baseUrl}auth/validate-token";
  static const String refreshToken = "${baseUrl}auth/refresh-token";

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
  static const String appointmentsEndpoint =
      "${baseUrl}donations/book-appointment/my-appointments";
  static const String bookAppointmentEndpoint =
      "${baseUrl}donations/book-appointment";
  static String cancelAppointmentEndpoint(String appointmentId) {
    return "${baseUrl}donations/book-appointment/$appointmentId";
  }

  static const String acceptedRequestsEndpoint = "${baseUrl}requests/accepted";

  static const String donationAvailableEndpoint =
      "${baseUrl}donor/donation-eligibility";
  static const String badgesEndpoint = "${baseUrl}rewards/badges";
  static const String rewardsEndpoint = "${baseUrl}rewards/catalog";
  static const String earningRulesEndpoint = "${baseUrl}rewards/earning-rules";
  static String redeemRewardEndpoint(String rewardId) {
    return "${baseUrl}rewards/catalog/$rewardId/redeem";
  }

  static String rescheduleAppointmentEndpoint(String appointmentId) {
    return "${baseUrl}donations/book-appointment/$appointmentId";
  }

  static const String requestsEndPoint = "${baseUrl}donor/requests";
  static String acceptRequestEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId/accept";
  }

  static const String requestAcceptEndpoint = "${baseUrl}requests/accepted";
  static String cancelRequestEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId/cancel";
  }

  static String fetchByRequestIdEndpoint(String requestId) {
    return "${baseUrl}requests/$requestId";
  }

  static const String verifyForgetPasswordOtp = "${baseUrl}auth/verify-otp";
  static const String resetPasswordEndpoint = "${baseUrl}auth/reset-password";
  static const String forgetPasswordEndpoint = "${baseUrl}auth/forgot-password";
  static const String logoutEndpoint = "${baseUrl}auth/logout";
  static const String changePasswordEndpoint = "${baseUrl}auth/change-password";
  static const String editProfileEndpoint = "${baseUrl}donor/profile";
  static const String deleteNotificationEndpoint = "${baseUrl}notifications/";
  static const String donorSates = "${baseUrl}donor/stats";
  static const String activityHistoryEndpoint = "${baseUrl}donor/activity";
  static const String userPointsEndpoint = "${baseUrl}rewards/points";
  static const String pointsHistoryEndpoint =
      "${baseUrl}rewards/points/history";
  static const String getSettingEndpoint = "${baseUrl}donor/settings";
  static const String historyEndpoint = "${baseUrl}donor/history";
  static const String supportRequestsEndpoint = "${baseUrl}support/contact";
  static const String adminRewardsEndpoint = "${baseUrl}admin/rewards";
  // https://graduation-project-cy61.onrender.com/admin/users/donor/69f3df915f42685cbbbcbb18
  static const String createAdminReward = '${baseUrl}admin/rewards';
  static String updateRewardStatusEndpoint(String rewardId) {
    return "${baseUrl}admin/rewards/$rewardId/status";
  }
  static const String createNewEarningRuleEndpoint = "${baseUrl}admin/rewards/earning-rules";
  static const String getEarningRuleEndPoint = "${baseUrl}admin/rewards/earning-rules";
  static String updateEarningRuleEndpoint(String earningRuleId) {
    return "${baseUrl}admin/rewards/earning-rules/$earningRuleId";
  }
  static String deleteEarningRuleEndpoint(String earningRuleId) {
    return "${baseUrl}admin/rewards/earning-rules/$earningRuleId";
  }

  static   const String manuallyUpdateRewardPointsEndpoint = "${baseUrl}admin/rewards/points/adjust-by-email";


  static const String updatePointsForMultipleRewardsEndpoint =
      "${baseUrl}admin/rewards/bulk-points";
  static String updateDonorEndpoint(String userId) {
    return "${baseUrl}admin/users/donor/$userId";
  }

  static String updateHospitalEndpoint(String userId) {
    return "${baseUrl}admin/users/hospital/$userId";
  }

  static String updateAdminEndpoint(String userId) {
    return "${baseUrl}admin/users/admin/$userId";
  }

  static const String participationEndpoint = "${baseUrl}donor/participation";

  ///////////// notifications endpoints  /////////////
  static const String notificationsListEndpoint = "${baseUrl}notifications";
  static const String markAllNotificationsAsReadEndpoint =
      "${baseUrl}notifications/read-all";

  //////////////////////// chat bot endpoints  ////////////////////////
  static const String chatBotUrl = "https://donation-chatbot-1fie.onrender.com";
  static const String askChatBotEndpoint = "$chatBotUrl/ask";
  static const String chatEndPoint = "$chatBotUrl/chat";
  /////////////////////////////////////////// fcm endpoints  /////////////////////////////////////
  static const String saveFcmTokenEndpoint = "${baseUrl}auth/fcm-token";
  //////////////////////////////////// schedule donation endpoints  /////////////////////////////////////
  static const String availableSlotsEndpoint =
      "${baseUrl}donations/book-appointment/available-slots";
  /////////////////////////// admin /////////////////////////////////
  static const String adminLoginEndPoint = "${baseUrl}auth/admin/login";
  static const String systemHealthEndpoint = "${baseUrl}admin/system/health";
  static const String analyticsDashboardEndpoint = "${baseUrl}admin/dashboard";
  static const String createHospitalEndpoint = "${baseUrl}admin/users/hospital";
  static const String adminProfileEndpoint = "${baseUrl}admin/profile";
  static const String adminRequestsEndpoint = "${baseUrl}admin/requests";
  static const String systemMaintenanceEndpoint = "${baseUrl}admin/system/maintenance";
  static const String getSystemMaintenanceEndpoint = "${baseUrl}admin/system/maintenance";
  static const String adminAuditLogsEndpoint = "${baseUrl}admin/audit-logs";
  static  String rotateAdminKeyEndpoint (String adminId) {
    return "${baseUrl}admin/admins/$adminId/rotate-key";
  }
  static String fulfillRequestEndpoint(String requestId) {
    return "${baseUrl}admin/requests/$requestId/fulfill";
  }

  static const String updateAdminProfileEndpoint = "${baseUrl}admin/profile";
  static String adminCancelRequestsEndpoint(String requestId) {
    return "${baseUrl}admin/requests/$requestId/cancel";
  }

  static String broadcastRequestEndpoint(String requestId) {
    return "${baseUrl}admin/requests/$requestId/broadcast";
  }

  static const String analyticsOverviewEndpoint =
      "${baseUrl}analytics/overview";
  static const String adminUsersEndpoint = "${baseUrl}admin/users";
  static String deleteUserEndpoint(String userId) {
    return "${baseUrl}admin/users/$userId";
  }

  static String banUserEndpoint(String userId) {
    return "${baseUrl}admin/users/$userId/ban";
  }

  static String unbanUserEndpoint(String userId) {
    return "${baseUrl}admin/users/$userId/unban";
  }

  static const String createAdminEndpoint = "${baseUrl}admin/admins";
  static String updateUserEndpoint(String userId) {
    return "${baseUrl}admin/users/$userId";
  }

  static const String inboundEmailsEndpoint = "${baseUrl}admin/inbound-emails";
  static const String adminSupportTicketsEndpoint = "${baseUrl}admin/support/tickets";
  static String replyToSupportTicketEndpoint(String ticketId) {
    return "${baseUrl}admin/inbound-emails/$ticketId/reply";
  }
  static String deleteInboundEmailEndpoint(String emailId) {
    return "${baseUrl}admin/inbound-emails/$emailId";
  }

  static String markInboundEmailAsReadEndpoint(String emailId) {
    return "${baseUrl}admin/inbound-emails/$emailId/read";
  }

  static String archiveInboundEmailEndpoint(String emailId) {
    return "${baseUrl}admin/inbound-emails/$emailId/archive";
  }

  static const String analyticsDonationsEndpoint =
      "${baseUrl}analytics/donations";
  static const String topDonorsEndpoint =
      "${baseUrl}admin/analytics/top-donors";
}
