String? _asString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

class AppointmentListModel {
  AppointmentListModel({this.success, this.message, this.data});

  AppointmentListModel.fromJson(dynamic json) {
    success = json['success'];
    message = _asString(json['message']);
    data = json['data'] != null
        ? AppointmentListData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  AppointmentListData? data;
}

class AppointmentListData {
  AppointmentListData({this.appointments});

  AppointmentListData.fromJson(dynamic json) {
    if (json['appointments'] is List) {
      appointments = (json['appointments'] as List)
          .map((e) => AppointmentListItem.fromJson(e))
          .toList();
    }
  }

  List<AppointmentListItem>? appointments;
}

class AppointmentListItem {
  AppointmentListItem({this.id, this.donorDetails});

  AppointmentListItem.fromJson(dynamic json) {
    id = _asString(json['_id'] ?? json['id']);
    donorDetails = json['donorDetails'] != null
        ? AppointmentDonorDetails.fromJson(json['donorDetails'])
        : null;
  }

  String? id;
  AppointmentDonorDetails? donorDetails;
}

class AppointmentDonorDetails {
  AppointmentDonorDetails({this.fullName, this.phoneNumber, this.bloodType});

  AppointmentDonorDetails.fromJson(dynamic json) {
    fullName = _asString(json['fullName']);
    phoneNumber = _asString(json['phoneNumber']);
    bloodType = _asString(json['bloodType']);
  }

  String? fullName;
  String? phoneNumber;
  String? bloodType;
}
