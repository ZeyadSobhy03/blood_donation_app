/// success : true
/// message : "Accepted requests retrieved successfully"
/// data : {"requests":[{"requestId":"6a130e82f9830f9b4aeb1494","donationId":"6a130e83f9830f9b4aeb149f","status":"accepted","donationStatus":"pending","acceptedAt":"2026-06-25T22:30:49.147Z","qrToken":null,"arrivalDeadline":null,"qrExpiresAt":null,"qrExpired":true,"arrivalDeadlinePassed":false,"bloodType":["O+","B-"],"bloodTypeLabel":"O+, B-","urgency":"critical","unitsNeeded":3,"unitsAccepted":0,"fullyAccepted":false,"patientType":"adult","patientDetails":null,"isEmergency":true,"hospitalName":"Cairo Care Operations","contactNumber":"1044444444","hospitalId":"6a130e820b339a45a51addb4","hospitalAddress":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}}],"pagination":{"total":1,"page":1,"currentPage":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class AcceptedRequestsModel {
  AcceptedRequestsModel({
    this.success,
    this.message,
    this.data,});

  AcceptedRequestsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// requests : [{"requestId":"6a130e82f9830f9b4aeb1494", ... ,"hospitalAddress":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}}]
/// pagination : {"total":1,"page":1,"currentPage":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

class Data {
  Data({
    this.requests,
    this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['requests'] != null) {
      requests = [];
      json['requests'].forEach((v) {
        requests?.add(Requests.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Requests>? requests;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requests != null) {
      map['requests'] = requests?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 1
/// page : 1
/// currentPage : 1
/// limit : 20
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Pagination {
  Pagination({
    this.total,
    this.page,
    this.currentPage,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
  int? total;
  int? page;
  int? currentPage;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['currentPage'] = currentPage;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }

}

/// requestId : "6a130e82f9830f9b4aeb1494"
/// donationId : "6a130e83f9830f9b4aeb149f"
/// status : "accepted"
/// donationStatus : "pending"
/// acceptedAt : "2026-06-25T22:30:49.147Z"
/// qrToken : null
/// arrivalDeadline : null
/// qrExpiresAt : null
/// qrExpired : true
/// arrivalDeadlinePassed : false
/// bloodType : ["O+","B-"]
/// bloodTypeLabel : "O+, B-"
/// urgency : "critical"
/// unitsNeeded : 3
/// unitsAccepted : 0
/// fullyAccepted : false
/// patientType : "adult"
/// patientDetails : null
/// isEmergency : true
/// hospitalName : "Cairo Care Operations"
/// contactNumber : "1044444444"
/// hospitalId : "6a130e820b339a45a51addb4"
/// hospitalAddress : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}

class Requests {
  Requests({
    this.requestId,
    this.donationId,
    this.status,
    this.donationStatus,
    this.acceptedAt,
    this.qrToken,
    this.arrivalDeadline,
    this.qrExpiresAt,
    this.qrExpired,
    this.arrivalDeadlinePassed,
    this.bloodType,
    this.bloodTypeLabel,
    this.urgency,
    this.unitsNeeded,
    this.unitsAccepted,
    this.fullyAccepted,
    this.patientType,
    this.patientDetails,
    this.isEmergency,
    this.hospitalName,
    this.contactNumber,
    this.hospitalId,
    this.hospitalAddress,});

  Requests.fromJson(dynamic json) {
    requestId = json['requestId'];
    donationId = json['donationId'];
    status = json['status'];
    donationStatus = json['donationStatus'];
    acceptedAt = json['acceptedAt'];
    qrToken = json['qrToken'];
    arrivalDeadline = json['arrivalDeadline'];
    qrExpiresAt = json['qrExpiresAt'];
    qrExpired = json['qrExpired'];
    arrivalDeadlinePassed = json['arrivalDeadlinePassed'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    bloodTypeLabel = json['bloodTypeLabel'];
    urgency = json['urgency'];
    unitsNeeded = json['unitsNeeded'];
    unitsAccepted = json['unitsAccepted'];
    fullyAccepted = json['fullyAccepted'];
    patientType = json['patientType'];
    patientDetails = json['patientDetails'];
    isEmergency = json['isEmergency'];
    hospitalName = json['hospitalName'];
    contactNumber = json['contactNumber'];
    hospitalId = json['hospitalId'];
    hospitalAddress = HospitalAddress.parse(json['hospitalAddress']);
  }
  String? requestId;
  String? donationId;
  String? status;
  String? donationStatus;
  String? acceptedAt;
  dynamic qrToken;
  dynamic arrivalDeadline;
  dynamic qrExpiresAt;
  bool? qrExpired;
  bool? arrivalDeadlinePassed;
  List<String>? bloodType;
  String? bloodTypeLabel;
  String? urgency;
  int? unitsNeeded;
  int? unitsAccepted;
  bool? fullyAccepted;
  String? patientType;
  dynamic patientDetails;
  bool? isEmergency;
  String? hospitalName;
  String? contactNumber;
  String? hospitalId;
  HospitalAddress? hospitalAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['donationId'] = donationId;
    map['status'] = status;
    map['donationStatus'] = donationStatus;
    map['acceptedAt'] = acceptedAt;
    map['qrToken'] = qrToken;
    map['arrivalDeadline'] = arrivalDeadline;
    map['qrExpiresAt'] = qrExpiresAt;
    map['qrExpired'] = qrExpired;
    map['arrivalDeadlinePassed'] = arrivalDeadlinePassed;
    map['bloodType'] = bloodType;
    map['bloodTypeLabel'] = bloodTypeLabel;
    map['urgency'] = urgency;
    map['unitsNeeded'] = unitsNeeded;
    map['unitsAccepted'] = unitsAccepted;
    map['fullyAccepted'] = fullyAccepted;
    map['patientType'] = patientType;
    map['patientDetails'] = patientDetails;
    map['isEmergency'] = isEmergency;
    map['hospitalName'] = hospitalName;
    map['contactNumber'] = contactNumber;
    map['hospitalId'] = hospitalId;
    map['hospitalAddress'] = hospitalAddress?.toJson();
    return map;
  }

}

/// city : "Cairo"
/// governorate : "Cairo"
/// district : "Garden City"
///
/// The backend has been observed to send this field either as an object
/// ({"city": ..., "governorate": ..., "district": ...}) or, in older/other
/// responses, as a plain string (e.g. "Cairo, Garden City"). HospitalAddress
/// safely handles both via the [parse] factory so the app never crashes
/// regardless of which shape the API returns.
class HospitalAddress {
  HospitalAddress({
    this.city,
    this.governorate,
    this.district,
    this.raw,});

  HospitalAddress.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
    district = json['district'];
  }

  /// Builds a [HospitalAddress] from either a Map or a String, or returns
  /// null if the value is null/unsupported. Use this instead of calling
  /// HospitalAddress.fromJson directly when the source field's type isn't
  /// guaranteed.
  static HospitalAddress? parse(dynamic json) {
    if (json == null) return null;
    if (json is Map) {
      return HospitalAddress.fromJson(json);
    }
    if (json is String) {
      return HospitalAddress(raw: json);
    }
    return null;
  }

  String? city;
  String? governorate;
  String? district;

  /// Populated only when the API sent a plain string instead of an object.
  String? raw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    map['district'] = district;
    return map;
  }

  /// Human-readable representation, e.g. "Garden City, Cairo, Cairo".
  /// Falls back to [raw] if the API sent a plain string.
  @override
  String toString() {
    if (raw != null && raw!.isNotEmpty) return raw!;
    final parts = [district, city, governorate]
        .where((e) => e != null && e.isNotEmpty)
        .toList();
    return parts.join(', ');
  }
}