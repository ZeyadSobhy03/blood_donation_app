import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/core/resources/models/blood_request_history.dart';
import 'package:blood_donation_app/core/resources/models/summary_model.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

class HistoryModel {
  HistoryModel({this.success, this.message, this.data});

  HistoryModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? HistoryData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  HistoryData? data;
}

/// data: { statistics, requests[], pagination }
class HistoryData {
  HistoryData({this.statistics, this.requests, this.pagination});

  HistoryData.fromJson(dynamic json) {
    statistics = json['statistics'] != null
        ? HistoryStatistics.fromJson(json['statistics'])
        : null;

    if (json['requests'] != null && json['requests'] is List) {
      requests = (json['requests'] as List)
          .map((r) => HistoryRequestModel.fromJson(r))
          .toList();
    }

    pagination = json['pagination'] != null
        ? HistoryPagination.fromJson(json['pagination'])
        : null;
  }

  HistoryStatistics? statistics;
  List<HistoryRequestModel>? requests;
  HistoryPagination? pagination;

  SummaryModel toSummaryModel() {
    return SummaryModel(
      completed: statistics?.completedRequests ?? 0,
      active: statistics?.activeRequests ?? 0,
      cancelled: statistics?.cancelledRequests ?? 0,
    );
  }
}

/// statistics: { activeRequests, completedRequests, cancelledRequests }
class HistoryStatistics {
  HistoryStatistics({
    this.activeRequests,
    this.completedRequests,
    this.cancelledRequests,
  });

  HistoryStatistics.fromJson(dynamic json) {
    activeRequests = (json['activeRequests'] as num?)?.toInt();
    completedRequests = (json['completedRequests'] as num?)?.toInt();
    cancelledRequests = (json['cancelledRequests'] as num?)?.toInt();
  }

  int? activeRequests;
  int? completedRequests;
  int? cancelledRequests;
}

/// Individual request from the API
class HistoryRequestModel {
  HistoryRequestModel({
    this.id,
    this.bloodType,
    this.unitsRequested,
    this.urgencyLevel,
    this.donorsContacted,
    this.donorsConfirmed,
    this.isFulfilled,
    this.requestDate,
    this.completionTimeInHours,
    this.priority,
    this.location,
    this.hospitalContact,
    this.hospitalName,
    this.status,
  });

  HistoryRequestModel.fromJson(dynamic json) {
    id = json['_id'];
    final rawBloodType = json['bloodType'];
    if (rawBloodType is List) {
      bloodType = rawBloodType.join(', ');
    } else if (rawBloodType is String) {
      bloodType = rawBloodType;
    } else {
      bloodType = null;
    }
    unitsRequested = (json['unitsRequested'] as num?)?.toInt();
    urgencyLevel = json['urgencyLevel'];
    donorsContacted = (json['donorsContacted'] as num?)?.toInt();
    donorsConfirmed = (json['donorsConfirmed'] as num?)?.toInt();
    isFulfilled = json['isFulfilled'];
    requestDate = json['requestDate'] != null
        ? DateTime.tryParse(json['requestDate'])
        : null;
    completionTimeInHours = (json['completionTimeInHours'] as num?)?.toInt();
    priority = json['priority'];
    location = json['location'] != null
        ? HistoryLocation.fromJson(json['location'])
        : null;
    hospitalContact = json['hospitalContact'];
    hospitalName = json['hospitalName'];
    status = json['status'];
  }

  String? id;
  String? bloodType;
  int? unitsRequested;
  String? urgencyLevel;
  int? donorsContacted;
  int? donorsConfirmed;
  bool? isFulfilled;
  DateTime? requestDate;
  int? completionTimeInHours;
  String? priority;
  HistoryLocation? location;
  String? hospitalContact;
  String? hospitalName;
  String? status;

  String get locationDisplay {
    final lat = location?.lat;
    final lng = location?.lng;
    if (lat == null || lng == null) return '';
    return '$lat, $lng';
  }


  bool get isCompleted => status?.toLowerCase() == 'completed';
  bool get isCancelled => status?.toLowerCase() == 'cancelled';
  bool get isActive => status?.toLowerCase() == 'active';

  RequestPriority get requestPriority {
    switch (priority?.toLowerCase()) {
      case 'critical':
        return RequestPriority.high;
      case 'high':
        return RequestPriority.high;
      case 'low':
        return RequestPriority.low;
      default:
        return RequestPriority.high;
    }
  }

  BloodRequestHistoryModel toHistoryModel(AppLocalizations loc) {
    return BloodRequestHistoryModel(
      bloodRequestModel: BloodRequestModel(
        bloodType: bloodType ?? '',
        unitsRequested: unitsRequested ?? 0,
        urgencyLevel: urgencyLevel ?? '',
        donorsContacted: donorsContacted ?? 0,
        donorsConfirmed: donorsConfirmed ?? 0,
        isFulfilled: isFulfilled ?? false,
        requestDate: requestDate ?? DateTime.now(),
        completionTimeInHours: completionTimeInHours ?? 0,
        priority: requestPriority,
        location: locationDisplay,
        hospitalContact: hospitalContact ?? '',
        hospitalName: hospitalName ?? '',
      ),
      bloodType: bloodType ?? '',
      units: unitsRequested ?? 0,
      date: requestDate ?? DateTime.now(),
      priority: _localizedPriority(loc),
      status: _localizedStatus(loc),
      isFulfilled: isFulfilled ?? false,
    );
  }

  String _localizedPriority(AppLocalizations loc) {
    switch (priority?.toLowerCase()) {
      case 'critical':
        return loc.critical;
      case 'high':
        return loc.high;
      case 'medium':
        return loc.medium;
      case 'low':
        return loc.low;
      default:
        return priority ?? '';
    }
  }

  String _localizedStatus(AppLocalizations loc) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return loc.fulfilled;
      case 'cancelled':
        return loc.cancelled;
      case 'active':
        return loc.active;
      case 'pending':
        return loc.pending;
      case 'accepted':
        return loc.statusAccepted;
      case 'expired':
        return loc.statusExpired;
      default:
        return status ?? '';
    }
  }
}

/// location: { coordinates: { lat, lng } }
class HistoryLocation {
  HistoryLocation({this.lat, this.lng});

  HistoryLocation.fromJson(dynamic json) {
    final coordinates = json['coordinates'];
    if (coordinates != null) {
      lat = (coordinates['lat'] as num?)?.toDouble();
      lng = (coordinates['lng'] as num?)?.toDouble();
    }
  }

  double? lat;
  double? lng;
}

/// pagination: { total, page, currentPage, limit, totalPages,
///               hasNextPage, hasPrevPage }
class HistoryPagination {
  HistoryPagination({
    this.total,
    this.page,
    this.currentPage,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  HistoryPagination.fromJson(dynamic json) {
    total = (json['total'] as num?)?.toInt();
    page = (json['page'] as num?)?.toInt();
    currentPage = (json['currentPage'] as num?)?.toInt();
    limit = (json['limit'] as num?)?.toInt();
    totalPages = (json['totalPages'] as num?)?.toInt();
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
}