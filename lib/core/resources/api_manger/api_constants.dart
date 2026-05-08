class ApiManger {
  static const String baseUrl =
      "https://graduation-project-cy61.onrender.com/api/v1/";
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
  static const String nearbyHospitalsEndpointWithQuery = "${baseUrl}hospitals/nearby?lat={lat}&lng={lng}";
}
