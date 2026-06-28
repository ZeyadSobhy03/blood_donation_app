import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/extension/data_ex.dart';

class HomeRequestsModel {
  HomeRequestsModel({this.success, this.message, this.data});

  HomeRequestsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeRequestsData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeRequestsData? data;
}

class HomeRequestsData {
  HomeRequestsData({this.requests, this.pagination});

  HomeRequestsData.fromJson(dynamic json) {
    if (json['requests'] is List) {
      requests = (json['requests'] as List)
          .map((e) => HomeRequestItem.fromJson(e))
          .toList();
    }
    pagination = json['pagination'] != null
        ? RequestPagination.fromJson(json['pagination'])
        : null;
  }

  List<HomeRequestItem>? requests;
  RequestPagination? pagination;
}

class HomeRequestItem {
  HomeRequestItem({
    this.id,
    this.type,
    this.bloodType,
    this.urgency,
    this.status,
    this.requestStatus,
    this.isFulfilled,
    this.quantity,
    this.unitsNeeded,
    this.unitsRequested,
    this.requiredBy,
    this.createdAt,
    this.requestDate,
    this.donorsResponded,
    this.donorsConfirmed,
  });

  HomeRequestItem.fromJson(dynamic json) {
    id            = json['_id'] ?? json['id'] ?? json['requestId'];
    type          = json['type'];

    final rawBloodType = json['bloodType'];
    if (rawBloodType is List) {
      bloodType = rawBloodType.cast<String>();
    } else if (rawBloodType is String) {
      bloodType = [rawBloodType];
    }

    urgency         = json['urgency'];
    status          = json['status'];
    requestStatus   = json['requestStatus'];
    isFulfilled     = json['isFulfilled'];
    quantity        = (json['quantity']        as num?)?.toInt();
    unitsNeeded     = (json['unitsNeeded']     as num?)?.toInt();
    unitsRequested  = (json['unitsRequested']  as num?)?.toInt();
    requiredBy      = json['requiredBy']  != null
        ? DateTime.tryParse(json['requiredBy'])
        : null;
    createdAt       = json['createdAt']   != null
        ? DateTime.tryParse(json['createdAt'])
        : null;
    requestDate     = json['requestDate'] != null
        ? DateTime.tryParse(json['requestDate'])
        : null;
    donorsResponded = (json['donorsResponded'] as num?)?.toInt();
    donorsConfirmed = (json['donorsConfirmed'] as num?)?.toInt();
  }

  String? id;
  String? type;
  List<String>? bloodType;
  String? urgency;
  String? status;
  String? requestStatus;
  bool? isFulfilled;
  int? quantity;
  int? unitsNeeded;
  int? unitsRequested;
  DateTime? requiredBy;
  DateTime? createdAt;
  DateTime? requestDate;
  int? donorsResponded;
  int? donorsConfirmed;

  String get bloodTypeDisplay => bloodType?.join(', ') ?? '';

  String timeAgo(BuildContext context) {
    final created = createdAt;
    if (created == null) return '';
    return created.toTimeAgo(context);
  }
}

class RequestPagination {
  RequestPagination({this.total, this.page, this.limit, this.totalPages});

  RequestPagination.fromJson(dynamic json) {
    total      = (json['total']      as num?)?.toInt();
    page       = (json['page']       as num?)?.toInt();
    limit      = (json['limit']      as num?)?.toInt();
    totalPages = (json['totalPages'] as num?)?.toInt();
  }

  int? total;
  int? page;
  int? limit;
  int? totalPages;
}
