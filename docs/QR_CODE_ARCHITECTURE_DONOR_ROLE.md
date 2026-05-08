# 📱 QR CODE ARCHITECTURE - DONOR ROLE
**Blood Donation App - QR Code Implementation Strategy**

**Date:** May 7, 2026  
**Status:** Architecture Planning (No Code)  
**Scope:** All QR codes needed in Donor role workflow

---

## 🎯 Overview

QR codes serve 3 critical purposes in the donor appointment & donation flow:

| # | QR Code Type | When Generated | Used By | Purpose |
|---|---|---|---|---|
| 1️⃣ | **Appointment Confirmation QR** | After booking appointment | Donor + Hospital | Check-in & verification |
| 2️⃣ | **Donation Session QR** | At hospital during collection | Hospital Staff | Track donation session |
| 3️⃣ | **Blood Unit QR** | After blood collection | Hospital + Lab + Storage | Track blood unit lifecycle |

---

## 1️⃣ APPOINTMENT CONFIRMATION QR CODE

### 📋 When is it Generated?
**Trigger:** User completes all 5 steps and confirms appointment

**Location in App:** 
- Generated on `AppointmentConfirmed` screen
- Last step in `ScheduleDonation` flow
- Shown after successful API response from `/api/v1/donations/book-appointment`

**Step Flow:**
```
1. User selects Location (Hospital) → Step 1
2. User selects Date & Time → Step 2
3. User confirms details (blood type, health questions) → Step 3
4. User reviews all information → Step 4
5. User clicks "Confirm Appointment" → API Call
   ↓
6. API returns: appointment_id, confirmation_code
   ↓
7. Generate QR Code with appointment data
   ↓
8. Display QR on AppointmentConfirmed screen ✅
```

### 📦 What Data Goes Into QR Code?

**QR Code Payload (JSON):**
```json
{
  "qr_type": "APPOINTMENT_CONFIRMATION",
  "version": "1.0",
  "appointment_id": "550e8400-e29b-41d4-a716-446655440001",
  "confirmation_code": "APT-2026-05-07-001",
  "donor": {
    "donor_id": "550e8400-e29b-41d4-a716-446655440100",
    "full_name": "Ahmed Ali",
    "blood_type": "O+",
    "phone": "+92-300-1234567"
  },
  "hospital": {
    "hospital_id": "550e8400-e29b-41d4-a716-446655440002",
    "hospital_name": "City Hospital",
    "address": "123 Medical St, Karachi",
    "phone": "+92-21-123456"
  },
  "appointment": {
    "date": "2026-05-15",
    "time": "10:30 AM",
    "duration_minutes": 60,
    "appointment_status": "confirmed"
  },
  "generated_at": "2026-05-07T14:22:00Z",
  "expires_at": "2026-05-15T12:00:00Z",
  "qr_code_data": "https://app.lifelink.com/qr/appointment/550e8400-e29b-41d4-a716-446655440001"
}
```

### 🖼️ How Donor Uses It?

**On Appointment Day:**
```
Donor arrives at hospital
   ↓
Hospital staff asks for appointment confirmation
   ↓
Donor shows QR code from phone (AppointmentConfirmed screen or saved locally)
   ↓
Hospital scans QR code
   ↓
Hospital staff sees:
   - Donor name ✓
   - Blood type ✓
   - Appointment time ✓
   - Appointment ID ✓
   ↓
Staff checks in donor in hospital system ✅
```

### 🏥 Hospital Side Processing

**Hospital mobile app receives:**
1. Scans QR code
2. Extracts appointment_id and donor_id
3. Calls API: `GET /api/v1/hospital/appointments/{appointment_id}/verify`
4. Verifies QR code authenticity (check timestamp, signature)
5. Shows green checkmark if valid ✓
6. Creates donation session in hospital system

### ⏰ Lifecycle

| Timeline | Status | Action |
|----------|--------|--------|
| Day 1 | Generated | QR created after appointment confirmation |
| Day 1-14 | Active | Donor can share/download/print |
| Day 15 (appointment day) | Used | Hospital scans at check-in |
| Day 15 (after donation) | Used | Converted to Donation Session QR |
| Day 16+ | Archived | Stored for records |

---

## 2️⃣ DONATION SESSION QR CODE

### 📋 When is it Generated?

**Trigger:** Hospital staff confirms donor check-in and starts donation collection

**Location Timeline:**
```
Donor arrives at hospital with Appointment QR
   ↓
Hospital staff scans Appointment QR
   ↓
Staff clicks "Start Donation Session"
   ↓
API Call: POST /api/v1/donations/start-session
   {
     "appointment_id": "...",
     "hospital_id": "...",
     "staff_id": "..."
   }
   ↓
Backend returns: donation_session_id, session_code
   ↓
Generate Donation Session QR Code
   ↓
Display on Hospital staff tablet/screen ✅
```

### 📦 What Data Goes Into QR Code?

**QR Code Payload (JSON):**
```json
{
  "qr_type": "DONATION_SESSION",
  "version": "1.0",
  "donation_session_id": "550e8400-e29b-41d4-a716-446655440050",
  "session_code": "DS-2026-05-15-001",
  "appointment_id": "550e8400-e29b-41d4-a716-446655440001",
  "donor": {
    "donor_id": "550e8400-e29b-41d4-a716-446655440100",
    "full_name": "Ahmed Ali",
    "blood_type": "O+",
    "date_of_birth": "1990-05-15",
    "weight_kg": 75,
    "health_status": "eligible"
  },
  "collection": {
    "hospital_id": "550e8400-e29b-41d4-a716-446655440002",
    "collection_area": "Collection Unit A",
    "collection_bed": "Bed 5",
    "staff_id": "550e8400-e29b-41d4-a716-446655440200",
    "staff_name": "Dr. Fatima Khan"
  },
  "session": {
    "start_time": "2026-05-15T10:35:00Z",
    "duration_minutes": 50,
    "units_planned": 1,
    "volume_ml": 450,
    "status": "in_progress"
  },
  "generated_at": "2026-05-15T10:35:00Z",
  "expires_at": "2026-05-15T12:00:00Z",
  "qr_code_data": "https://app.lifelink.com/qr/donation-session/550e8400-e29b-41d4-a716-446655440050"
}
```

### 🏥 How Hospital Uses It?

**During Donation Collection:**
```
Staff starts donation collection process
   ↓
Multiple staff members involved in:
   - Blood pressure monitoring
   - Needle insertion
   - Collection tracking
   - Reaction monitoring
   ↓
Each staff member scans Donation Session QR to:
   - Update collection status
   - Log reactions/incidents
   - Record vitals
   - Track blood bags used
   ↓
After collection: Staff scans to mark "COMPLETED"
```

### 📱 Donor Mobile App Experience

**During Donation (Live Updates):**
```
Donor sees on their phone:
   ├── Donation timer (countdown to 50 minutes)
   ├── Staff checklist
   │   ├── ✓ Pre-donation assessment
   │   ├── ✓ Vital signs checked
   │   ├── ⏳ Blood collection in progress
   │   └── ⏳ Post-donation assessment
   ├── QR code (so staff can scan anytime)
   └── Emergency contact button
```

### ⏰ Lifecycle

| Stage | Time | Status |
|-------|------|--------|
| Session Start | 10:35 AM | QR generated, Status: IN_PROGRESS |
| Collection Phase | 10:35-10:45 AM | Staff scans periodically |
| Collection Complete | 10:45 AM | Status: COLLECTION_COMPLETE |
| Post-Check Complete | 10:50 AM | Status: POST_CHECK_COMPLETE |
| Session End | 10:50 AM | Convert to Blood Unit QR |

---

## 3️⃣ BLOOD UNIT QR CODE

### 📋 When is it Generated?

**Trigger:** After donation collection is completed and blood unit is created

**Location Timeline:**
```
Donation Session completed (after 50 minutes)
   ↓
Staff marks donation as "Collection Complete"
   ↓
System generates Blood Unit ID
   ↓
API Call: POST /api/v1/donations/create-blood-unit
   {
     "donation_session_id": "...",
     "blood_type": "O+",
     "volume_ml": 450,
     "collection_datetime": "...",
     "expiry_datetime": "..."
   }
   ↓
Backend returns: blood_unit_id, unit_barcode
   ↓
Generate Blood Unit QR Code
   ↓
Print label with QR code + barcode
   ↓
Attach to blood bag ✅
```

### 📦 What Data Goes Into QR Code?

**QR Code Payload (JSON):**
```json
{
  "qr_type": "BLOOD_UNIT",
  "version": "1.0",
  "blood_unit_id": "BU-550e8400-e29b-41d4-a716-446655440100",
  "barcode": "550e8400e29b41d4",
  "donation_session_id": "550e8400-e29b-41d4-a716-446655440050",
  "donor": {
    "donor_id": "550e8400-e29b-41d4-a716-446655440100",
    "full_name": "Ahmed Ali",
    "blood_type": "O+",
    "rhesus": "Positive",
    "date_of_birth": "1990-05-15",
    "test_results": {
      "hiv": "negative",
      "hepatitis_b": "negative",
      "hepatitis_c": "negative",
      "syphilis": "negative"
    }
  },
  "collection": {
    "hospital_id": "550e8400-e29b-41d4-a716-446655440002",
    "hospital_name": "City Hospital",
    "collection_time": "2026-05-15T10:35:00Z",
    "collection_staff": "Dr. Fatima Khan"
  },
  "unit_details": {
    "volume_ml": 450,
    "component_type": "whole_blood",
    "collection_method": "automated_single_bag",
    "anticoagulant": "CPDA-1",
    "storage_condition": "refrigerated_4c"
  },
  "validity": {
    "collection_date": "2026-05-15",
    "expiry_date": "2026-06-29",
    "days_valid": 45,
    "current_status": "available"
  },
  "tracking": {
    "location": "Blood Bank A - Fridge 3",
    "last_updated": "2026-05-15T11:00:00Z",
    "storage_temperature": "4°C"
  },
  "generated_at": "2026-05-15T11:00:00Z",
  "qr_code_data": "https://app.lifelink.com/qr/blood-unit/BU-550e8400-e29b-41d4-a716-446655440100"
}
```

### 🏥 How Hospital Uses It?

**Blood Bank Management:**
```
Blood Unit QR Code printed on bag
   ↓
Blood bag stored in refrigerated unit
   ↓
When hospital needs blood:
   1. Lab tech scans QR on blood bag
   2. System shows:
      - Blood type (O+)
      - Donor info
      - Test results (HIV, Hepatitis, etc.)
      - Expiry date
      - Storage conditions
   3. Lab tech verifies compatibility with patient
   4. Marks as "Used" with patient ID when transfused
```

**Blood Traceability (Regulatory Compliance):**
```
Can trace any transfusion back to:
   - Which donor gave the blood
   - When it was collected
   - All test results
   - Temperature history
   - All staff involved
   - Which patient received it
```

### ⏰ Lifecycle

| Stage | Timeline | Status | Location |
|-------|----------|--------|----------|
| Created | 11:00 AM | AVAILABLE | Refrigerated storage |
| In Storage | 11:00 AM - 45 days | AVAILABLE | Blood bank |
| Ordered by Patient | Any day | ALLOCATED | Blood bank |
| Used for Transfusion | Any time | USED | Patient's medical record |
| Expired | Day 46 | EXPIRED | Disposal |

---

## 📊 QR Code Comparison Table

| Aspect | Appointment QR | Donation Session QR | Blood Unit QR |
|--------|---|---|---|
| **Generated By** | Donor's app (frontend) | Hospital app (hospital staff) | Hospital system (backend) |
| **Used By** | Hospital staff | Hospital staff (monitoring) | Blood bank staff/Lab tech |
| **Validity** | Until appointment time | Only during donation | 45 days (until expiry) |
| **Scans Expected** | 1-2 times | 3-5 times | 5-10 times (tracking) |
| **Contains** | Appointment details | Session details | Blood component data |
| **Primary Use** | Check-in & verification | Session tracking | Traceability & testing |
| **Store Locally** | Yes (donor) | No (temporary) | Yes (blood bank) |
| **Print** | Optional | No | Yes (label on bag) |

---

## 🎯 DONOR ROLE - SCREENS WITH QR CODES

### Screen 1: AppointmentConfirmed

**Location in App:**
```
Schedule Donation Flow
   ↓
LocationStep (Choose Hospital)
   ↓
DateTimeStep (Choose Date/Time)
   ↓
ConfirmYourDetails (Blood type, health questions)
   ↓
ReviewAndConfirm (Review all info)
   ↓
AppointmentConfirmed ← QR CODE DISPLAYED HERE ✅
```

**Screen Components:**
```
┌─────────────────────────────────────────┐
│  ✓ Appointment Confirmed               │
│                                         │
│  Your appointment has been scheduled   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │
│  │   [QR CODE IMAGE - 200x200px]   │   │
│  │   Appointment ID: APT-2026...   │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📋 Appointment Details:               │
│  ├─ Hospital: City Hospital            │
│  ├─ Date: May 15, 2026                 │
│  ├─ Time: 10:30 AM                     │
│  ├─ Blood Type: O+                     │
│  └─ Confirmation: APT-2026-05-07-001   │
│                                         │
│  [📥 Download] [🖨️ Print] [📤 Share] │
│                                         │
│  [ Finish ] [ View Appointments ]      │
│                                         │
└─────────────────────────────────────────┘
```

**Donor Actions:**
- 📥 Download QR code (save as image)
- 🖨️ Print QR code (take to hospital)
- 📤 Share via WhatsApp/Email
- ➕ Add to Apple Wallet / Google Wallet

---

### Screen 2: DonationTrackingScreen (During Active Donation)

**Location in App:**
```
Donor Tab → Appointments
   ↓
Select Today's Appointment
   ↓
DonationTrackingScreen ← LIVE QR + UPDATES ✅
```

**Screen Components:**
```
┌─────────────────────────────────────────┐
│  🏥 Donation in Progress               │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Donation Session QR           │   │
│  │   (Staff scans this)             │   │
│  │                                 │   │
│  │   [QR CODE IMAGE - 200x200px]   │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ⏱️ Time Remaining: 10:45:32           │
│                                         │
│  📊 Progress Checklist:                │
│  ├─ ✓ Pre-donation assessment         │
│  ├─ ✓ Vital signs checked             │
│  ├─ ⏳ Blood collection (15/50 min)    │
│  ├─ ⏳ Post-donation assessment        │
│  └─ ⏳ Recovery (5 min rest)           │
│                                         │
│  🩺 Current Status:                    │
│  ├─ Blood Pressure: 120/80             │
│  ├─ Pulse: 72 BPM                      │
│  └─ Status: Collecting...              │
│                                         │
│  [ 🆘 Emergency ] [ 📞 Call Staff ]    │
│                                         │
└─────────────────────────────────────────┘
```

**Real-time Updates:**
- Timer countdown (50 minutes total)
- Staff checklist progress
- Vital signs monitoring
- Emergency contact button

---

### Screen 3: DonationHistoryScreen

**Location in App:**
```
Donor Tab → Donation History
   ↓
Select Past Donation
   ↓
DonationHistoryDetailScreen ← BLOOD UNIT QR ✅
```

**Screen Components:**
```
┌─────────────────────────────────────────┐
│  📋 Donation #5 - Completed            │
│                                         │
│  🏥 City Hospital                      │
│  May 15, 2026 • 10:30 AM - 11:50 AM    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Blood Unit QR                 │   │
│  │   (For records/tracking)         │   │
│  │                                 │   │
│  │   [QR CODE IMAGE - 200x200px]   │   │
│  │   Unit ID: BU-550e8400...        │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📋 Donation Summary:                  │
│  ├─ Blood Type: O+ Positive            │
│  ├─ Volume Collected: 450 mL           │
│  ├─ Duration: 50 minutes               │
│  ├─ Staff: Dr. Fatima Khan             │
│  └─ Status: ✓ Completed Successfully   │
│                                         │
│  🧪 Test Results:                      │
│  ├─ ✓ HIV: Negative                    │
│  ├─ ✓ Hepatitis B: Negative            │
│  ├─ ✓ Hepatitis C: Negative            │
│  └─ ✓ Syphilis: Negative               │
│                                         │
│  ⭐ Rewards Earned: +100 Points        │
│                                         │
│  [ 📥 Download Report ] [ Share ]     │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🔐 Security & Privacy Considerations

### QR Code Security

**Appointment QR:**
- ✅ Contains public appointment info (no sensitive health data)
- ✅ Expires after appointment time
- ✅ Tied to hospital verification API

**Donation Session QR:**
- ⚠️ Contains health assessment info
- ✅ Hospital staff only (not public)
- ✅ Active only during donation session
- ✅ Requires hospital staff authentication

**Blood Unit QR:**
- ⚠️ Contains test results & blood type
- ✅ Hospital + Lab staff only
- ✅ Access requires role authentication
- ✅ Audit logged for compliance (HIPAA/GDPR)

### Data Protection

| QR Type | Data Encrypted | Access Control | Audit Log |
|---------|---|---|---|
| Appointment | Yes | Public QR | Optional |
| Donation Session | Yes | Hospital staff | Required |
| Blood Unit | Yes | Blood bank staff | Required |

---

## 🛠️ Technical Implementation Overview

### Backend API Endpoints Needed

```
1. POST /api/v1/appointments/{id}/generate-qr
   → Generate Appointment QR code
   → Return: qr_image_base64, qr_payload_json

2. POST /api/v1/donations/sessions/{id}/generate-qr
   → Generate Donation Session QR code
   → Return: qr_image_base64

3. POST /api/v1/blood-units/generate-qr
   → Generate Blood Unit QR code
   → Return: qr_image_base64, barcode

4. GET /api/v1/qr/verify/{qr_code}
   → Verify QR code authenticity
   → Return: verification_status, qr_data

5. POST /api/v1/qr/{id}/track
   → Track blood unit via QR scan
   → Log: timestamp, location, scanner_id
```

### Frontend Libraries Needed

```
qr_flutter 4.0.0             # Generate QR codes
qr_code_scanner 1.0.0        # Scan QR codes
image_gallery_saver 2.0.0    # Save QR as image
printing 5.0.0               # Print QR codes
share_plus 6.0.0             # Share QR image
```

---

## 📱 Donor Role - Full QR Code Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                    DONOR JOURNEY                             │
│                                                               │
│  1. APPOINTMENT BOOKING                                      │
│     ├─ Select hospital, date, time                          │
│     ├─ Confirm health details                               │
│     └─ Summit appointment → Generate Appointment QR ✅       │
│                                                               │
│  2. PRE-APPOINTMENT (1-3 days before)                        │
│     ├─ Download QR to phone                                 │
│     ├─ Print QR or screenshot                               │
│     └─ Share confirmation with hospital                     │
│                                                               │
│  3. APPOINTMENT DAY - ARRIVAL                                │
│     ├─ Arrive at hospital                                   │
│     ├─ Go to registration desk                              │
│     ├─ Show Appointment QR to staff                         │
│     ├─ Staff scans Appointment QR                           │
│     └─ Check-in successful ✓                                │
│                                                               │
│  4. DURING DONATION                                          │
│     ├─ Moved to collection unit                             │
│     ├─ Medical assessment                                   │
│     ├─ Donation Session QR generated                        │
│     ├─ Staff scans Donation Session QR                      │
│     ├─ Donor sees live tracking on phone                    │
│     ├─ 50-minute collection period                          │
│     └─ Blood collection completes ✓                         │
│                                                               │
│  5. AFTER DONATION                                           │
│     ├─ Blood Unit QR generated (for blood bank)             │
│     ├─ Staff prints label with Blood Unit QR                │
│     ├─ Label attached to blood bag                          │
│     ├─ Donor rests (5-15 minutes)                           │
│     ├─ Post-donation assessment                             │
│     ├─ Discharge with certificate                           │
│     └─ Donor can view donation record & QR                  │
│                                                               │
│  6. AFTER DONATION (DONOR APP)                               │
│     ├─ Donation appears in "Donation History"               │
│     ├─ Blood Unit QR accessible for records                 │
│     ├─ Test results available                               │
│     ├─ Rewards points earned                                │
│     └─ Can track where blood went (optional)                │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

---

## ✅ Summary Table - What QR Codes to Implement

| # | QR Code | When | Used By | Screens |
|---|---------|------|---------|---------|
| 1 | **Appointment Confirmation** | After booking | Donor + Hospital | AppointmentConfirmed |
| 2 | **Donation Session** | During donation | Hospital staff | DonationTrackingScreen |
| 3 | **Blood Unit** | After collection | Blood bank staff | DonationHistoryDetail |

---

## 🎯 Implementation Priority

```
PHASE 1 (CRITICAL):
├─ Appointment Confirmation QR ⭐⭐⭐
├─ Display in AppointmentConfirmed screen
├─ Download/Print functionality
└─ Share via WhatsApp/Email

PHASE 2 (HIGH):
├─ Blood Unit QR (for hospital)
├─ Display in DonationHistoryDetail
├─ Make printable for records
└─ Add test results alongside

PHASE 3 (MEDIUM):
├─ Donation Session QR (hospital staff app)
├─ Live tracking updates
└─ Integration with hospital system

PHASE 4 (NICE-TO-HAVE):
├─ Add to Apple Wallet
├─ Add to Google Wallet
├─ Blood unit tracking for donors
└─ Email QR with appointment confirmation
```

---

## 📋 Specification Document

**File Location:** `/docs/QR_CODE_ARCHITECTURE_DONOR_ROLE.md`  
**Version:** 1.0  
**Status:** Ready for Frontend Development  
**Next Step:** Implement Appointment QR in Phase 1

