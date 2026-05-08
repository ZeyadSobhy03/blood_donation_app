# 📱 QR CODE FRONTEND IMPLEMENTATION GUIDE
**Blood Donation App - Complete Flutter Implementation**

**Date:** May 7, 2026  
**Status:** Frontend Architecture Ready  
**Framework:** Flutter + BLoC + Clean Architecture

---

## 📂 FILE STRUCTURE

```
lib/
├── core/
│   ├── models/
│   │   ├── qr_models/
│   │   │   ├── appointment_qr_model.dart
│   │   │   ├── donation_session_qr_model.dart
│   │   │   └── blood_unit_qr_model.dart
│   │   └── qr_base_model.dart
│   └── utils/
│       ├── qr_generator.dart
│       └── qr_validator.dart
│
├── data/
│   ├── datasources/
│   │   ├── qr_local_data_source.dart
│   │   ├── qr_remote_data_source.dart
│   │   └── appointment_data_source.dart
│   ├── models/
│   │   ├── qr_response_model.dart
│   │   └── appointment_model.dart
│   └── repositories/
│       ├── qr_repository_imp.dart
│       ├── appointment_repository_imp.dart
│       └── donation_session_repository_imp.dart
│
├── domain/
│   ├── entities/
│   │   ├── appointment_entity.dart
│   │   ├── donation_session_entity.dart
│   │   └── blood_unit_entity.dart
│   ├── repositories/
│   │   ├── qr_repository.dart
│   │   ├── appointment_repository.dart
│   │   └── donation_session_repository.dart
│   └── usecases/
│       ├── generate_appointment_qr_usecase.dart
│       ├── save_qr_locally_usecase.dart
│       ├── generate_donation_session_qr_usecase.dart
│       └── generate_blood_unit_qr_usecase.dart
│
├── presentation/
│   ├── cubits/
│   │   ├── qr/
│   │   │   ├── appointment_qr_cubit.dart
│   │   │   ├── appointment_qr_state.dart
│   │   │   ├── donation_session_qr_cubit.dart
│   │   │   ├── donation_session_qr_state.dart
│   │   │   ├── blood_unit_qr_cubit.dart
│   │   │   └── blood_unit_qr_state.dart
│   │
│   └── screens/
│       ├── appointment_confirmed_screen.dart
│       ├── donation_tracking_screen.dart
│       ├── donation_history_detail_screen.dart
│       └── qr_preview_screen.dart
│
│   └── widgets/
│       ├── qr_display_widget.dart
│       ├── qr_action_buttons.dart
│       ├── qr_data_card.dart
│       └── qr_loading_skeleton.dart
```

---

## 1️⃣ MODELS & ENTITIES

### Core Model - Base QR Model

**File:** `core/models/qr_base_model.dart`

```dart
// Base model for all QR codes
class QRBaseModel {
  final String qrType;
  final String version;
  final String generatedAt;
  final String expiresAt;
  final String qrCodeData;

  QRBaseModel({
    required this.qrType,
    required this.version,
    required this.generatedAt,
    required this.expiresAt,
    required this.qrCodeData,
  });

  /// Convert to JSON for encoding into QR
  Map<String, dynamic> toJson();
  
  /// Create from JSON
  factory QRBaseModel.fromJson(Map<String, dynamic> json);
}
```

---

### Model 1: Appointment QR Model

**File:** `core/models/qr_models/appointment_qr_model.dart`

```dart
class AppointmentQRModel extends QRBaseModel {
  final String appointmentId;
  final String confirmationCode;
  final DonorInfo donor;
  final HospitalInfo hospital;
  final AppointmentInfo appointment;

  AppointmentQRModel({
    required String qrType,
    required String version,
    required String generatedAt,
    required String expiresAt,
    required String qrCodeData,
    required this.appointmentId,
    required this.confirmationCode,
    required this.donor,
    required this.hospital,
    required this.appointment,
  }) : super(
    qrType: qrType,
    version: version,
    generatedAt: generatedAt,
    expiresAt: expiresAt,
    qrCodeData: qrCodeData,
  );

  @override
  Map<String, dynamic> toJson() => {
    'qr_type': qrType,
    'version': version,
    'appointment_id': appointmentId,
    'confirmation_code': confirmationCode,
    'donor': donor.toJson(),
    'hospital': hospital.toJson(),
    'appointment': appointment.toJson(),
    'generated_at': generatedAt,
    'expires_at': expiresAt,
    'qr_code_data': qrCodeData,
  };

  factory AppointmentQRModel.fromJson(Map<String, dynamic> json) {
    return AppointmentQRModel(
      qrType: json['qr_type'],
      version: json['version'],
      generatedAt: json['generated_at'],
      expiresAt: json['expires_at'],
      qrCodeData: json['qr_code_data'],
      appointmentId: json['appointment_id'],
      confirmationCode: json['confirmation_code'],
      donor: DonorInfo.fromJson(json['donor']),
      hospital: HospitalInfo.fromJson(json['hospital']),
      appointment: AppointmentInfo.fromJson(json['appointment']),
    );
  }
}

class DonorInfo {
  final String donorId;
  final String fullName;
  final String bloodType;
  final String phone;

  DonorInfo({
    required this.donorId,
    required this.fullName,
    required this.bloodType,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'donor_id': donorId,
    'full_name': fullName,
    'blood_type': bloodType,
    'phone': phone,
  };

  factory DonorInfo.fromJson(Map<String, dynamic> json) {
    return DonorInfo(
      donorId: json['donor_id'],
      fullName: json['full_name'],
      bloodType: json['blood_type'],
      phone: json['phone'],
    );
  }
}

class HospitalInfo {
  final String hospitalId;
  final String hospitalName;
  final String address;
  final String phone;

  HospitalInfo({
    required this.hospitalId,
    required this.hospitalName,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'hospital_id': hospitalId,
    'hospital_name': hospitalName,
    'address': address,
    'phone': phone,
  };

  factory HospitalInfo.fromJson(Map<String, dynamic> json) {
    return HospitalInfo(
      hospitalId: json['hospital_id'],
      hospitalName: json['hospital_name'],
      address: json['address'],
      phone: json['phone'],
    );
  }
}

class AppointmentInfo {
  final String date;
  final String time;
  final int durationMinutes;
  final String appointmentStatus;

  AppointmentInfo({
    required this.date,
    required this.time,
    required this.durationMinutes,
    required this.appointmentStatus,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'time': time,
    'duration_minutes': durationMinutes,
    'appointment_status': appointmentStatus,
  };

  factory AppointmentInfo.fromJson(Map<String, dynamic> json) {
    return AppointmentInfo(
      date: json['date'],
      time: json['time'],
      durationMinutes: json['duration_minutes'],
      appointmentStatus: json['appointment_status'],
    );
  }
}
```

---

### Model 2: Donation Session QR Model

**File:** `core/models/qr_models/donation_session_qr_model.dart`

```dart
class DonationSessionQRModel extends QRBaseModel {
  final String donationSessionId;
  final String sessionCode;
  final String appointmentId;
  final DonorInfo donor;
  final CollectionInfo collection;
  final SessionInfo session;

  DonationSessionQRModel({
    required String qrType,
    required String version,
    required String generatedAt,
    required String expiresAt,
    required String qrCodeData,
    required this.donationSessionId,
    required this.sessionCode,
    required this.appointmentId,
    required this.donor,
    required this.collection,
    required this.session,
  }) : super(
    qrType: qrType,
    version: version,
    generatedAt: generatedAt,
    expiresAt: expiresAt,
    qrCodeData: qrCodeData,
  );

  @override
  Map<String, dynamic> toJson() => {
    'qr_type': qrType,
    'version': version,
    'donation_session_id': donationSessionId,
    'session_code': sessionCode,
    'appointment_id': appointmentId,
    'donor': donor.toJson(),
    'collection': collection.toJson(),
    'session': session.toJson(),
    'generated_at': generatedAt,
    'expires_at': expiresAt,
    'qr_code_data': qrCodeData,
  };

  factory DonationSessionQRModel.fromJson(Map<String, dynamic> json) {
    return DonationSessionQRModel(
      qrType: json['qr_type'],
      version: json['version'],
      generatedAt: json['generated_at'],
      expiresAt: json['expires_at'],
      qrCodeData: json['qr_code_data'],
      donationSessionId: json['donation_session_id'],
      sessionCode: json['session_code'],
      appointmentId: json['appointment_id'],
      donor: DonorInfo.fromJson(json['donor']),
      collection: CollectionInfo.fromJson(json['collection']),
      session: SessionInfo.fromJson(json['session']),
    );
  }
}

class CollectionInfo {
  final String hospitalId;
  final String collectionArea;
  final String collectionBed;
  final String staffId;
  final String staffName;

  CollectionInfo({
    required this.hospitalId,
    required this.collectionArea,
    required this.collectionBed,
    required this.staffId,
    required this.staffName,
  });

  Map<String, dynamic> toJson() => {
    'hospital_id': hospitalId,
    'collection_area': collectionArea,
    'collection_bed': collectionBed,
    'staff_id': staffId,
    'staff_name': staffName,
  };

  factory CollectionInfo.fromJson(Map<String, dynamic> json) {
    return CollectionInfo(
      hospitalId: json['hospital_id'],
      collectionArea: json['collection_area'],
      collectionBed: json['collection_bed'],
      staffId: json['staff_id'],
      staffName: json['staff_name'],
    );
  }
}

class SessionInfo {
  final String startTime;
  final int durationMinutes;
  final int unitsPlanned;
  final int volumeMl;
  final String status;

  SessionInfo({
    required this.startTime,
    required this.durationMinutes,
    required this.unitsPlanned,
    required this.volumeMl,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'duration_minutes': durationMinutes,
    'units_planned': unitsPlanned,
    'volume_ml': volumeMl,
    'status': status,
  };

  factory SessionInfo.fromJson(Map<String, dynamic> json) {
    return SessionInfo(
      startTime: json['start_time'],
      durationMinutes: json['duration_minutes'],
      unitsPlanned: json['units_planned'],
      volumeMl: json['volume_ml'],
      status: json['status'],
    );
  }
}
```

---

### Model 3: Blood Unit QR Model

**File:** `core/models/qr_models/blood_unit_qr_model.dart`

```dart
class BloodUnitQRModel extends QRBaseModel {
  final String bloodUnitId;
  final String barcode;
  final String donationSessionId;
  final BloodDonorInfo donor;
  final BloodCollectionInfo collection;
  final UnitDetails unitDetails;
  final ValidityInfo validity;
  final TrackingInfo tracking;

  BloodUnitQRModel({
    required String qrType,
    required String version,
    required String generatedAt,
    required String expiresAt,
    required String qrCodeData,
    required this.bloodUnitId,
    required this.barcode,
    required this.donationSessionId,
    required this.donor,
    required this.collection,
    required this.unitDetails,
    required this.validity,
    required this.tracking,
  }) : super(
    qrType: qrType,
    version: version,
    generatedAt: generatedAt,
    expiresAt: expiresAt,
    qrCodeData: qrCodeData,
  );

  @override
  Map<String, dynamic> toJson() => {
    'qr_type': qrType,
    'version': version,
    'blood_unit_id': bloodUnitId,
    'barcode': barcode,
    'donation_session_id': donationSessionId,
    'donor': donor.toJson(),
    'collection': collection.toJson(),
    'unit_details': unitDetails.toJson(),
    'validity': validity.toJson(),
    'tracking': tracking.toJson(),
    'generated_at': generatedAt,
    'expires_at': expiresAt,
    'qr_code_data': qrCodeData,
  };

  factory BloodUnitQRModel.fromJson(Map<String, dynamic> json) {
    return BloodUnitQRModel(
      qrType: json['qr_type'],
      version: json['version'],
      generatedAt: json['generated_at'],
      expiresAt: json['expires_at'],
      qrCodeData: json['qr_code_data'],
      bloodUnitId: json['blood_unit_id'],
      barcode: json['barcode'],
      donationSessionId: json['donation_session_id'],
      donor: BloodDonorInfo.fromJson(json['donor']),
      collection: BloodCollectionInfo.fromJson(json['collection']),
      unitDetails: UnitDetails.fromJson(json['unit_details']),
      validity: ValidityInfo.fromJson(json['validity']),
      tracking: TrackingInfo.fromJson(json['tracking']),
    );
  }
}

class BloodDonorInfo {
  final String donorId;
  final String fullName;
  final String bloodType;
  final String rhesus;
  final String dateOfBirth;
  final TestResults testResults;

  BloodDonorInfo({
    required this.donorId,
    required this.fullName,
    required this.bloodType,
    required this.rhesus,
    required this.dateOfBirth,
    required this.testResults,
  });

  Map<String, dynamic> toJson() => {
    'donor_id': donorId,
    'full_name': fullName,
    'blood_type': bloodType,
    'rhesus': rhesus,
    'date_of_birth': dateOfBirth,
    'test_results': testResults.toJson(),
  };

  factory BloodDonorInfo.fromJson(Map<String, dynamic> json) {
    return BloodDonorInfo(
      donorId: json['donor_id'],
      fullName: json['full_name'],
      bloodType: json['blood_type'],
      rhesus: json['rhesus'],
      dateOfBirth: json['date_of_birth'],
      testResults: TestResults.fromJson(json['test_results']),
    );
  }
}

class TestResults {
  final String hiv;
  final String hepatitisB;
  final String hepatitisC;
  final String syphilis;

  TestResults({
    required this.hiv,
    required this.hepatitisB,
    required this.hepatitisC,
    required this.syphilis,
  });

  Map<String, dynamic> toJson() => {
    'hiv': hiv,
    'hepatitis_b': hepatitisB,
    'hepatitis_c': hepatitisC,
    'syphilis': syphilis,
  };

  factory TestResults.fromJson(Map<String, dynamic> json) {
    return TestResults(
      hiv: json['hiv'],
      hepatitisB: json['hepatitis_b'],
      hepatitisC: json['hepatitis_c'],
      syphilis: json['syphilis'],
    );
  }
}

class BloodCollectionInfo {
  final String hospitalId;
  final String hospitalName;
  final String collectionTime;
  final String collectionStaff;

  BloodCollectionInfo({
    required this.hospitalId,
    required this.hospitalName,
    required this.collectionTime,
    required this.collectionStaff,
  });

  Map<String, dynamic> toJson() => {
    'hospital_id': hospitalId,
    'hospital_name': hospitalName,
    'collection_time': collectionTime,
    'collection_staff': collectionStaff,
  };

  factory BloodCollectionInfo.fromJson(Map<String, dynamic> json) {
    return BloodCollectionInfo(
      hospitalId: json['hospital_id'],
      hospitalName: json['hospital_name'],
      collectionTime: json['collection_time'],
      collectionStaff: json['collection_staff'],
    );
  }
}

class UnitDetails {
  final int volumeMl;
  final String componentType;
  final String collectionMethod;
  final String anticoagulant;
  final String storageCondition;

  UnitDetails({
    required this.volumeMl,
    required this.componentType,
    required this.collectionMethod,
    required this.anticoagulant,
    required this.storageCondition,
  });

  Map<String, dynamic> toJson() => {
    'volume_ml': volumeMl,
    'component_type': componentType,
    'collection_method': collectionMethod,
    'anticoagulant': anticoagulant,
    'storage_condition': storageCondition,
  };

  factory UnitDetails.fromJson(Map<String, dynamic> json) {
    return UnitDetails(
      volumeMl: json['volume_ml'],
      componentType: json['component_type'],
      collectionMethod: json['collection_method'],
      anticoagulant: json['anticoagulant'],
      storageCondition: json['storage_condition'],
    );
  }
}

class ValidityInfo {
  final String collectionDate;
  final String expiryDate;
  final int daysValid;
  final String currentStatus;

  ValidityInfo({
    required this.collectionDate,
    required this.expiryDate,
    required this.daysValid,
    required this.currentStatus,
  });

  Map<String, dynamic> toJson() => {
    'collection_date': collectionDate,
    'expiry_date': expiryDate,
    'days_valid': daysValid,
    'current_status': currentStatus,
  };

  factory ValidityInfo.fromJson(Map<String, dynamic> json) {
    return ValidityInfo(
      collectionDate: json['collection_date'],
      expiryDate: json['expiry_date'],
      daysValid: json['days_valid'],
      currentStatus: json['current_status'],
    );
  }
}

class TrackingInfo {
  final String location;
  final String lastUpdated;
  final String storageTemperature;

  TrackingInfo({
    required this.location,
    required this.lastUpdated,
    required this.storageTemperature,
  });

  Map<String, dynamic> toJson() => {
    'location': location,
    'last_updated': lastUpdated,
    'storage_temperature': storageTemperature,
  };

  factory TrackingInfo.fromJson(Map<String, dynamic> json) {
    return TrackingInfo(
      location: json['location'],
      lastUpdated: json['last_updated'],
      storageTemperature: json['storage_temperature'],
    );
  }
}
```

---

## 2️⃣ CUBITS & STATE MANAGEMENT

### Appointment QR Cubit

**File:** `presentation/cubits/qr/appointment_qr_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'appointment_qr_state.dart';

@injectable
class AppointmentQRCubit extends Cubit<AppointmentQRState> {
  final GenerateAppointmentQRUseCase _generateQRUseCase;
  final SaveQRLocallyUseCase _saveQRUseCase;

  AppointmentQRCubit({
    required GenerateAppointmentQRUseCase generateQRUseCase,
    required SaveQRLocallyUseCase saveQRUseCase,
  })  : _generateQRUseCase = generateQRUseCase,
        _saveQRUseCase = saveQRUseCase,
        super(AppointmentQRInitial());

  /// Generate QR code after appointment booking
  Future<void> generateAppointmentQR({
    required String appointmentId,
  }) async {
    try {
      emit(AppointmentQRLoading());
      
      final qrModel = await _generateQRUseCase(appointmentId);
      
      // Generate actual QR image
      final qrImage = _generateQRImage(qrModel.toJson());
      
      emit(AppointmentQRLoaded(
        qrModel: qrModel,
        qrImage: qrImage,
      ));
    } catch (e) {
      emit(AppointmentQRError(error: e.toString()));
    }
  }

  /// Save QR code to local storage or gallery
  Future<void> saveQRLocally({
    required AppointmentQRModel qrModel,
    required String format, // 'png', 'pdf', 'image'
  }) async {
    try {
      final state = this.state;
      if (state is AppointmentQRLoaded) {
        emit(AppointmentQRSaving());
        
        final filePath = await _saveQRUseCase(
          qrImage: state.qrImage,
          format: format,
          appointmentId: qrModel.appointmentId,
        );
        
        emit(AppointmentQRSaved(
          filePath: filePath,
          qrModel: qrModel,
          qrImage: state.qrImage,
        ));
      }
    } catch (e) {
      emit(AppointmentQRError(error: 'Failed to save QR: ${e.toString()}'));
    }
  }

  /// Share QR code via share sheet
  Future<void> shareQR({
    required AppointmentQRModel qrModel,
    required String filePath,
  }) async {
    try {
      // Implementation for share_plus
      // Share.shareFiles([filePath], text: 'My Appointment QR Code');
    } catch (e) {
      emit(AppointmentQRError(error: 'Failed to share: ${e.toString()}'));
    }
  }

  /// Generate QR image from JSON data
  String _generateQRImage(Map<String, dynamic> data) {
    // Using qr_flutter package
    // Returns base64 encoded image
    final jsonString = jsonEncode(data);
    // QRCode generation and encoding logic
    return 'qr_image_base64_string';
  }

  /// Clear QR state
  void clearQR() => emit(AppointmentQRInitial());
}
```

---

### Appointment QR State

**File:** `presentation/cubits/qr/appointment_qr_state.dart`

```dart
abstract class AppointmentQRState {
  const AppointmentQRState();
}

class AppointmentQRInitial extends AppointmentQRState {
  const AppointmentQRInitial();
}

class AppointmentQRLoading extends AppointmentQRState {
  const AppointmentQRLoading();
}

class AppointmentQRLoaded extends AppointmentQRState {
  final AppointmentQRModel qrModel;
  final String qrImage; // base64 encoded

  const AppointmentQRLoaded({
    required this.qrModel,
    required this.qrImage,
  });
}

class AppointmentQRSaving extends AppointmentQRState {
  const AppointmentQRSaving();
}

class AppointmentQRSaved extends AppointmentQRState {
  final String filePath;
  final AppointmentQRModel qrModel;
  final String qrImage;

  const AppointmentQRSaved({
    required this.filePath,
    required this.qrModel,
    required this.qrImage,
  });
}

class AppointmentQRError extends AppointmentQRState {
  final String error;

  const AppointmentQRError({required this.error});
}

class AppointmentQRSharing extends AppointmentQRState {
  const AppointmentQRSharing();
}

class AppointmentQRShared extends AppointmentQRState {
  final bool isShared;

  const AppointmentQRShared({required this.isShared});
}
```

---

### Donation Session QR Cubit

**File:** `presentation/cubits/qr/donation_session_qr_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'donation_session_qr_state.dart';

@injectable
class DonationSessionQRCubit extends Cubit<DonationSessionQRState> {
  final GenerateDonationSessionQRUseCase _generateQRUseCase;
  
  Timer? _refreshTimer;

  DonationSessionQRCubit({
    required GenerateDonationSessionQRUseCase generateQRUseCase,
  })  : _generateQRUseCase = generateQRUseCase,
        super(DonationSessionQRInitial());

  /// Generate QR code when donation session starts
  Future<void> generateDonationSessionQR({
    required String donationSessionId,
  }) async {
    try {
      emit(DonationSessionQRLoading());
      
      final qrModel = await _generateQRUseCase(donationSessionId);
      
      // Generate actual QR image
      final qrImage = _generateQRImage(qrModel.toJson());
      
      emit(DonationSessionQRLoaded(
        qrModel: qrModel,
        qrImage: qrImage,
      ));
      
      // Start auto-refresh (update every 30 seconds)
      _startAutoRefresh(donationSessionId);
    } catch (e) {
      emit(DonationSessionQRError(error: e.toString()));
    }
  }

  /// Refresh QR code data (called periodically or on demand)
  Future<void> refreshDonationSessionQR({
    required String donationSessionId,
  }) async {
    try {
      final state = this.state;
      if (state is DonationSessionQRLoaded) {
        final updatedQRModel = await _generateQRUseCase(donationSessionId);
        final qrImage = _generateQRImage(updatedQRModel.toJson());
        
        emit(DonationSessionQRLoaded(
          qrModel: updatedQRModel,
          qrImage: qrImage,
        ));
      }
    } catch (e) {
      emit(DonationSessionQRError(error: e.toString()));
    }
  }

  /// Start auto-refresh timer for live updates
  void _startAutoRefresh(String donationSessionId) {
    _refreshTimer?.cancel();
    
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (_) {
      refreshDonationSessionQR(donationSessionId: donationSessionId);
    });
  }

  /// Stop auto-refresh when session ends
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  /// Generate QR image
  String _generateQRImage(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    // QRCode generation logic
    return 'qr_image_base64_string';
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
```

---

### Donation Session QR State

**File:** `presentation/cubits/qr/donation_session_qr_state.dart`

```dart
abstract class DonationSessionQRState {
  const DonationSessionQRState();
}

class DonationSessionQRInitial extends DonationSessionQRState {
  const DonationSessionQRInitial();
}

class DonationSessionQRLoading extends DonationSessionQRState {
  const DonationSessionQRLoading();
}

class DonationSessionQRLoaded extends DonationSessionQRState {
  final DonationSessionQRModel qrModel;
  final String qrImage;
  final DateTime lastUpdated;

  const DonationSessionQRLoaded({
    required this.qrModel,
    required this.qrImage,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? const _LastUpdatedTime();

  DonationSessionQRLoaded copyWith({
    DonationSessionQRModel? qrModel,
    String? qrImage,
    DateTime? lastUpdated,
  }) {
    return DonationSessionQRLoaded(
      qrModel: qrModel ?? this.qrModel,
      qrImage: qrImage ?? this.qrImage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class DonationSessionQRRefreshing extends DonationSessionQRState {
  final DonationSessionQRModel previousQRModel;

  const DonationSessionQRRefreshing({required this.previousQRModel});
}

class DonationSessionQRError extends DonationSessionQRState {
  final String error;

  const DonationSessionQRError({required this.error});
}
```

---

### Blood Unit QR Cubit

**File:** `presentation/cubits/qr/blood_unit_qr_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'blood_unit_qr_state.dart';

@injectable
class BloodUnitQRCubit extends Cubit<BloodUnitQRState> {
  final GenerateBloodUnitQRUseCase _generateQRUseCase;
  final SaveQRLocallyUseCase _saveQRUseCase;

  BloodUnitQRCubit({
    required GenerateBloodUnitQRUseCase generateQRUseCase,
    required SaveQRLocallyUseCase saveQRUseCase,
  })  : _generateQRUseCase = generateQRUseCase,
        _saveQRUseCase = saveQRUseCase,
        super(BloodUnitQRInitial());

  /// Generate QR code after blood unit creation
  Future<void> generateBloodUnitQR({
    required String bloodUnitId,
  }) async {
    try {
      emit(BloodUnitQRLoading());
      
      final qrModel = await _generateQRUseCase(bloodUnitId);
      
      // Generate actual QR image
      final qrImage = _generateQRImage(qrModel.toJson());
      
      emit(BloodUnitQRLoaded(
        qrModel: qrModel,
        qrImage: qrImage,
      ));
    } catch (e) {
      emit(BloodUnitQRError(error: e.toString()));
    }
  }

  /// Save QR for printing or records
  Future<void> saveBloodUnitQR({
    required BloodUnitQRModel qrModel,
    required String format, // 'pdf', 'png'
  }) async {
    try {
      final state = this.state;
      if (state is BloodUnitQRLoaded) {
        emit(BloodUnitQRSaving());
        
        final filePath = await _saveQRUseCase(
          qrImage: state.qrImage,
          format: format,
          bloodUnitId: qrModel.bloodUnitId,
        );
        
        emit(BloodUnitQRSaved(
          filePath: filePath,
          qrModel: qrModel,
          qrImage: state.qrImage,
        ));
      }
    } catch (e) {
      emit(BloodUnitQRError(error: 'Failed to save: ${e.toString()}'));
    }
  }

  /// Generate QR image
  String _generateQRImage(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    // QRCode generation logic
    return 'qr_image_base64_string';
  }

  void clearQR() => emit(BloodUnitQRInitial());
}
```

---

### Blood Unit QR State

**File:** `presentation/cubits/qr/blood_unit_qr_state.dart`

```dart
abstract class BloodUnitQRState {
  const BloodUnitQRState();
}

class BloodUnitQRInitial extends BloodUnitQRState {
  const BloodUnitQRInitial();
}

class BloodUnitQRLoading extends BloodUnitQRState {
  const BloodUnitQRLoading();
}

class BloodUnitQRLoaded extends BloodUnitQRState {
  final BloodUnitQRModel qrModel;
  final String qrImage;

  const BloodUnitQRLoaded({
    required this.qrModel,
    required this.qrImage,
  });
}

class BloodUnitQRSaving extends BloodUnitQRState {
  const BloodUnitQRSaving();
}

class BloodUnitQRSaved extends BloodUnitQRState {
  final String filePath;
  final BloodUnitQRModel qrModel;
  final String qrImage;

  const BloodUnitQRSaved({
    required this.filePath,
    required this.qrModel,
    required this.qrImage,
  });
}

class BloodUnitQRError extends BloodUnitQRState {
  final String error;

  const BloodUnitQRError({required this.error});
}
```

---

## 3️⃣ WIDGETS

### QR Display Widget

**File:** `presentation/widgets/qr_display_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QRDisplayWidget extends StatelessWidget {
  final String qrImage; // base64 encoded
  final String qrType;  // 'appointment', 'donation_session', 'blood_unit'
  final String data;    // JSON data
  final double size;
  final Color darkColor;
  final Color lightColor;

  const QRDisplayWidget({
    required this.qrImage,
    required this.qrType,
    required this.data,
    this.size = 250,
    this.darkColor = Colors.black,
    this.lightColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// QR Code
          QrImage(
            data: data,
            version: QrVersions.auto,
            size: size,
            backgroundColor: lightColor,
            foregroundColor: darkColor,
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: darkColor,
            ),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.circle,
              color: darkColor,
            ),
          ),
          SizedBox(height: 16.h),
          
          /// QR Type Label
          Text(
            _getQRTypeLabel(qrType),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getQRTypeLabel(String type) {
    switch (type) {
      case 'appointment':
        return 'Appointment Confirmation QR';
      case 'donation_session':
        return 'Donation Session QR';
      case 'blood_unit':
        return 'Blood Unit QR';
      default:
        return 'QR Code';
    }
  }
}
```

---

### QR Action Buttons Widget

**File:** `presentation/widgets/qr_action_buttons.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class QRActionButtonsWidget extends StatelessWidget {
  final String filePath;
  final String qrData;
  final VoidCallback onDownload;
  final VoidCallback onPrint;
  final VoidCallback onShare;

  const QRActionButtonsWidget({
    required this.filePath,
    required this.qrData,
    required this.onDownload,
    required this.onPrint,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// Download Button
        _ActionButton(
          icon: Icons.download,
          label: 'Download',
          onPressed: onDownload,
        ),
        
        /// Print Button
        _ActionButton(
          icon: Icons.print,
          label: 'Print',
          onPressed: onPrint,
        ),
        
        /// Share Button
        _ActionButton(
          icon: Icons.share,
          label: 'Share',
          onPressed: onShare,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
          heroTag: label,
        ),
      ],
    );
  }
}
```

---

## 4️⃣ SCREENS

### Appointment Confirmed Screen

**File:** `presentation/screens/appointment_confirmed_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class AppointmentConfirmedScreen extends StatefulWidget {
  final String appointmentId;

  const AppointmentConfirmedScreen({
    required this.appointmentId,
  });

  @override
  State<AppointmentConfirmedScreen> createState() =>
      _AppointmentConfirmedScreenState();
}

class _AppointmentConfirmedScreenState
    extends State<AppointmentConfirmedScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger QR generation
    Future.microtask(() {
      context.read<AppointmentQRCubit>().generateAppointmentQR(
        appointmentId: widget.appointmentId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Appointment Confirmed'),
        centerTitle: true,
      ),
      body: BlocBuilder<AppointmentQRCubit, AppointmentQRState>(
        builder: (context, state) {
          if (state is AppointmentQRLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is AppointmentQRLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Success Icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 40.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  /// Confirmation Text
                  Text(
                    'Appointment Confirmed!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your appointment is scheduled',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  /// Appointment Details Card
                  _AppointmentDetailsCard(qrModel: state.qrModel),
                  SizedBox(height: 32.h),

                  /// QR Code Display
                  QRDisplayWidget(
                    qrImage: state.qrImage,
                    qrType: 'appointment',
                    data: jsonEncode(state.qrModel.toJson()),
                  ),
                  SizedBox(height: 32.h),

                  /// Action Buttons
                  QRActionButtonsWidget(
                    filePath: '',
                    qrData: jsonEncode(state.qrModel.toJson()),
                    onDownload: () => _handleDownload(context, state),
                    onPrint: () => _handlePrint(context, state),
                    onShare: () => _handleShare(context, state),
                  ),
                  SizedBox(height: 32.h),

                  /// Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to home or next screen
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                      child: Text('Go to Home'),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is AppointmentQRError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48.sp),
                  SizedBox(height: 16.h),
                  Text('Failed to generate QR code'),
                  SizedBox(height: 16.h),
                  Text(state.error, textAlign: TextAlign.center),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  void _handleDownload(BuildContext context, AppointmentQRLoaded state) {
    context.read<AppointmentQRCubit>().saveQRLocally(
      qrModel: state.qrModel,
      format: 'png',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR code saved to gallery')),
    );
  }

  void _handlePrint(BuildContext context, AppointmentQRLoaded state) {
    // TODO: Implement print functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Print functionality coming soon')),
    );
  }

  void _handleShare(BuildContext context, AppointmentQRLoaded state) {
    Share.share(
      'My appointment confirmation code: ${state.qrModel.confirmationCode}\n'
      'Date: ${state.qrModel.appointment.date}\n'
      'Time: ${state.qrModel.appointment.time}\n'
      'Hospital: ${state.qrModel.hospital.hospitalName}',
    );
  }
}

class _AppointmentDetailsCard extends StatelessWidget {
  final AppointmentQRModel qrModel;

  const _AppointmentDetailsCard({required this.qrModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailRow('Hospital', qrModel.hospital.hospitalName),
          SizedBox(height: 12.h),
          _DetailRow('Date', qrModel.appointment.date),
          SizedBox(height: 12.h),
          _DetailRow('Time', qrModel.appointment.time),
          SizedBox(height: 12.h),
          _DetailRow('Blood Type', qrModel.donor.bloodType),
          SizedBox(height: 12.h),
          _DetailRow('Confirmation Code', qrModel.confirmationCode),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
```

---

### Donation Tracking Screen

**File:** `presentation/screens/donation_tracking_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationTrackingScreen extends StatefulWidget {
  final String donationSessionId;

  const DonationTrackingScreen({
    required this.donationSessionId,
  });

  @override
  State<DonationTrackingScreen> createState() =>
      _DonationTrackingScreenState();
}

class _DonationTrackingScreenState extends State<DonationTrackingScreen> {
  late Timer _countdownTimer;
  Duration _remainingTime = Duration(minutes: 50);

  @override
  void initState() {
    super.initState();
    
    // Generate QR code
    Future.microtask(() {
      context.read<DonationSessionQRCubit>().generateDonationSessionQR(
        donationSessionId: widget.donationSessionId,
      );
    });

    // Start countdown timer
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    context.read<DonationSessionQRCubit>().stopAutoRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Donation in Progress'),
        centerTitle: true,
      ),
      body: BlocBuilder<DonationSessionQRCubit, DonationSessionQRState>(
        builder: (context, state) {
          if (state is DonationSessionQRLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is DonationSessionQRLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.bloodtype, color: Colors.blue, size: 40.sp),
                        SizedBox(height: 12.h),
                        Text(
                          'Blood Donation in Progress',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  /// Countdown Timer
                  _CountdownTimer(remainingTime: _remainingTime),
                  SizedBox(height: 32.h),

                  /// Progress Checklist
                  _ProgressChecklist(qrModel: state.qrModel),
                  SizedBox(height: 32.h),

                  /// QR Code for Staff
                  Text(
                    'Staff QR Code',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12.h),
                  QRDisplayWidget(
                    qrImage: state.qrImage,
                    qrType: 'donation_session',
                    data: jsonEncode(state.qrModel.toJson()),
                  ),
                  SizedBox(height: 32.h),

                  /// Emergency Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showEmergencyDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Text(
                          'Emergency',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is DonationSessionQRError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48.sp),
                  SizedBox(height: 16.h),
                  Text('Error loading QR code'),
                  SizedBox(height: 16.h),
                  Text(state.error, textAlign: TextAlign.center),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Emergency Alert'),
        content: Text('Notifying staff of emergency...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  final Duration remainingTime;

  const _CountdownTimer({required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    final minutes = remainingTime.inMinutes;
    final seconds = remainingTime.inSeconds.remainder(60);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Column(
        children: [
          Text(
            'Time Remaining',
            style: TextStyle(color: Colors.orange.shade700),
          ),
          SizedBox(height: 8.h),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressChecklist extends StatelessWidget {
  final DonationSessionQRModel qrModel;

  const _ProgressChecklist({required this.qrModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Checklist',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          _ChecklistItem('Pre-donation assessment', true),
          _ChecklistItem('Vital signs checked', true),
          _ChecklistItem(
            'Blood collection in progress',
            true,
            isInProgress: true,
          ),
          _ChecklistItem('Post-donation assessment', false),
          _ChecklistItem('Recovery period', false),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final String label;
  final bool completed;
  final bool isInProgress;

  const _ChecklistItem(
    this.label,
    this.completed, {
    this.isInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          if (completed)
            Icon(Icons.check_circle, color: Colors.green, size: 24.sp)
          else if (isInProgress)
            SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 24.sp),
          SizedBox(width: 12.w),
          Text(label),
        ],
      ),
    );
  }
}
```

---

### Donation History Detail Screen

**File:** `presentation/screens/donation_history_detail_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationHistoryDetailScreen extends StatefulWidget {
  final String bloodUnitId;

  const DonationHistoryDetailScreen({
    required this.bloodUnitId,
  });

  @override
  State<DonationHistoryDetailScreen> createState() =>
      _DonationHistoryDetailScreenState();
}

class _DonationHistoryDetailScreenState
    extends State<DonationHistoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    
    // Generate Blood Unit QR code
    Future.microtask(() {
      context.read<BloodUnitQRCubit>().generateBloodUnitQR(
        bloodUnitId: widget.bloodUnitId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Donation Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<BloodUnitQRCubit, BloodUnitQRState>(
        builder: (context, state) {
          if (state is BloodUnitQRLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is BloodUnitQRLoaded) {
            final qr = state.qrModel;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  _DonationHeader(qrModel: qr),
                  SizedBox(height: 24.h),

                  /// Donation Summary
                  _SectionTitle('Donation Summary'),
                  _DonationSummaryCard(qrModel: qr),
                  SizedBox(height: 24.h),

                  /// Test Results
                  _SectionTitle('Test Results'),
                  _TestResultsCard(qrModel: qr),
                  SizedBox(height: 24.h),

                  /// Blood Unit QR Code
                  _SectionTitle('Blood Unit QR Code'),
                  QRDisplayWidget(
                    qrImage: state.qrImage,
                    qrType: 'blood_unit',
                    data: jsonEncode(qr.toJson()),
                  ),
                  SizedBox(height: 24.h),

                  /// Action Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _handleDownload(context, state),
                      child: Text('Download Report'),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _handleShare(context, state),
                      child: Text('Share'),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is BloodUnitQRError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error,color: Colors.red, size: 48.sp),
                  SizedBox(height: 16.h),
                  Text('Failed to load donation details'),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  void _handleDownload(BuildContext context, BloodUnitQRLoaded state) {
    context.read<BloodUnitQRCubit>().saveBloodUnitQR(
      qrModel: state.qrModel,
      format: 'pdf',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report saved to downloads')),
    );
  }

  void _handleShare(BuildContext context, BloodUnitQRLoaded state) {
    Share.share(
      'My blood donation details:\n'
      'Blood Unit ID: ${state.qrModel.bloodUnitId}\n'
      'Blood Type: ${state.qrModel.donor.bloodType}${state.qrModel.donor.rhesus}\n'
      'Volume: ${state.qrModel.unitDetails.volumeMl} mL\n'
      'Collection Date: ${state.qrModel.validity.collectionDate}',
    );
  }
}

class _DonationHeader extends StatelessWidget {
  final BloodUnitQRModel qrModel;

  const _DonationHeader({required this.qrModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Donation Completed',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '${qrModel.donor.bloodType}+ ${qrModel.donor.rhesus}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${qrModel.unitDetails.volumeMl} mL collected on ${qrModel.validity.collectionDate}',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }
}

class _DonationSummaryCard extends StatelessWidget {
  final BloodUnitQRModel qrModel;

  const _DonationSummaryCard({required this.qrModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow('Blood Type', '${qrModel.donor.bloodType}${qrModel.donor.rhesus}'),
          Divider(),
          _InfoRow('Volume', '${qrModel.unitDetails.volumeMl} mL'),
          Divider(),
          _InfoRow('Collection Date', qrModel.validity.collectionDate),
          Divider(),
          _InfoRow('Expiry Date', qrModel.validity.expiryDate),
          Divider(),
          _InfoRow('Hospital', qrModel.collection.hospitalName),
          Divider(),
          _InfoRow('Days Valid', '${qrModel.validity.daysValid} days'),
        ],
      ),
    );
  }
}

class _TestResultsCard extends StatelessWidget {
  final BloodUnitQRModel qrModel;

  const _TestResultsCard({required this.qrModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TestResult('HIV', qrModel.donor.testResults.hiv),
          Divider(),
          _TestResult('Hepatitis B', qrModel.donor.testResults.hepatitisB),
          Divider(),
          _TestResult('Hepatitis C', qrModel.donor.testResults.hepatitisC),
          Divider(),
          _TestResult('Syphilis', qrModel.donor.testResults.syphilis),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _TestResult extends StatelessWidget {
  final String label;
  final String result;

  const _TestResult(this.label, this.result);

  @override
  Widget build(BuildContext context) {
    final isNegative = result.toLowerCase() == 'negative';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            Icon(
              isNegative ? Icons.check_circle : Icons.warning,
              color: isNegative ? Colors.green : Colors.orange,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              result,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isNegative ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

---

## 5️⃣ INTEGRATION IN MAIN APP

### MultiRepositoryProvider Setup

**File:** `main.dart` or `service_locator.dart`

```dart
MultiRepositoryProvider(
  providers: [
    RepositoryProvider<QRRepository>(
      create: (context) => QRRepositoryImpl(
        remoteDataSource: QRRemoteDataSource(),
        localDataSource: QRLocalDataSource(),
      ),
    ),
    RepositoryProvider<AppointmentRepository>(
      create: (context) => AppointmentRepositoryImpl(...),
    ),
    RepositoryProvider<DonationSessionRepository>(
      create: (context) => DonationSessionRepositoryImpl(...),
    ),
  ],
  child: MultiBlocProvider(
    providers: [
      BlocProvider<AppointmentQRCubit>(
        create: (context) => AppointmentQRCubit(
          generateQRUseCase: GenerateAppointmentQRUseCase(
            repository: context.read<QRRepository>(),
          ),
          saveQRUseCase: SaveQRLocallyUseCase(...),
        ),
      ),
      BlocProvider<DonationSessionQRCubit>(
        create: (context) => DonationSessionQRCubit(
          generateQRUseCase: GenerateDonationSessionQRUseCase(
            repository: context.read<QRRepository>(),
          ),
        ),
      ),
      BlocProvider<BloodUnitQRCubit>(
        create: (context) => BloodUnitQRCubit(
          generateQRUseCase: GenerateBloodUnitQRUseCase(
            repository: context.read<QRRepository>(),
          ),
          saveQRUseCase: SaveQRLocallyUseCase(...),
        ),
      ),
    ],
    child: MyApp(),
  ),
);
```

---

## ✅ FRONTEND CHECKLIST

```
PHASE 1 - APPOINTMENT QR (CRITICAL):
├─ ✅ Create AppointmentQRModel
├─ ✅ Create AppointmentQRCubit & States
├─ ✅ Create QRDisplayWidget
├─ ✅ Create QRActionButtonsWidget
├─ ✅ Create AppointmentConfirmedScreen
├─ ✅ Implement save/download functionality
└─ ✅ Integrate in ScheduleDonation flow

PHASE 2 - BLOOD UNIT QR (HIGH):
├─ ✅ Create BloodUnitQRModel
├─ ✅ Create BloodUnitQRCubit & States
├─ ✅ Create DonationHistoryDetailScreen
└─ ✅ Display test results

PHASE 3 - DONATION SESSION QR (MEDIUM):
├─ ✅ Create DonationSessionQRModel
├─ ✅ Create DonationSessionQRCubit & States
├─ ✅ Create DonationTrackingScreen
├─ ✅ Implement live countdown timer
├─ ✅ Implement progress checklist
└─ ✅ Implement emergency button

PHASE 4 - NICE-TO-HAVE:
├─ Add Apple Wallet integration
├─ Add Google Wallet integration
├─ Email QR codes with confirmation
└─ Print functionality
```

---

## 📊 Summary

| Component | Files | States | Screens |
|-----------|-------|--------|---------|
| Appointment QR | 3 | 6 | 1 |
| Donation Session QR | 3 | 5 | 1 |
| Blood Unit QR | 3 | 5 | 1 |
| Shared Widgets | 3 | - | - |
| **Total** | **15** | **16** | **3** |

---

**Status:** ✅ Ready to Implement  
**Complexity:** MEDIUM  
**Time Estimate:** 3-4 days (experienced Flutter developer)  
**Next Step:** Start with Appointment QR in Phase 1

