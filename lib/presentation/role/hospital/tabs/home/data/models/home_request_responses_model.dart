class HomeRequestResponsesModel {
  HomeRequestResponsesModel({this.success, this.message, this.data});

  HomeRequestResponsesModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeRequestResponsesData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeRequestResponsesData? data;
}

class HomeRequestResponsesData {
  HomeRequestResponsesData({this.donors});

  HomeRequestResponsesData.fromJson(dynamic json) {
    if (json['donors'] is List) {
      donors = (json['donors'] as List)
          .map((e) => RequestDonorResponse.fromJson(e))
          .toList();
    }
  }

  List<RequestDonorResponse>? donors;
}

class RequestDonorResponse {
  RequestDonorResponse({
    this.donorId,
    this.fullName,
    this.bloodType,
    this.isAvailable,
    this.phoneNumber,
    this.responseStatus,
    this.respondedAt,
  });

  RequestDonorResponse.fromJson(dynamic json) {
    donorId        = json['donorId'];
    fullName       = json['fullName'];
    bloodType      = json['bloodType'];
    isAvailable    = json['isAvailable'];
    phoneNumber    = json['phoneNumber'];
    responseStatus = json['responseStatus'];
    respondedAt    = json['respondedAt'] != null
        ? DateTime.tryParse(json['respondedAt'])
        : null;
  }

  String? donorId;
  String? fullName;
  String? bloodType;
  bool? isAvailable;
  String? phoneNumber;
  String? responseStatus;
  DateTime? respondedAt;
}
