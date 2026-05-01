# Backend API Requirements Report
## Hospital Role Features

**Report Date:** April 29, 2026  
**Target Audience:** Backend Development Team  
**Priority:** High (Hospital features are core to the system)

---

## 📊 PART 1: HOSPITAL DASHBOARD & OVERVIEW

### Current Frontend Status
Hospital screens exist in the Flutter app but require backend support for:
- Dashboard statistics
- Blood inventory management
- Emergency request handling
- Staff management
- Appointment scheduling
- Performance reporting

### Dashboard Requirements

#### Endpoint 1: Get Hospital Dashboard

```http
GET /api/v1/hospital/dashboard
Authorization: Bearer {hospital_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "dashboard_id": "uuid",
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "timestamp": "2026-04-29T15:22:00Z",
    "summary": {
      "total_staff": 28,
      "active_staff": 25,
      "offline_staff": 3,
      "total_donations_completed": 890,
      "donations_this_month": 89,
      "donations_this_week": 23,
      "pending_appointments": 12,
      "upcoming_appointments_today": 5,
      "emergency_requests_active": 3,
      "emergency_requests_completed": 156
    },
    "blood_inventory": {
      "total_units": 450,
      "status": "normal",
      "critical_types": ["B-"],
      "low_types": ["AB+"],
      "blood_types": {
        "O+": {"available": 150, "critical_threshold": 100, "status": "normal"},
        "O-": {"available": 80, "critical_threshold": 80, "status": "warning"},
        "A+": {"available": 95, "critical_threshold": 100, "status": "warning"},
        "A-": {"available": 40, "critical_threshold": 75, "status": "low"},
        "B+": {"available": 55, "critical_threshold": 100, "status": "low"},
        "B-": {"available": 20, "critical_threshold": 75, "status": "critical"},
        "AB+": {"available": 10, "critical_threshold": 75, "status": "critical"},
        "AB-": {"available": 0, "critical_threshold": 50, "status": "critical"}
      }
    },
    "performance": {
      "avg_response_time_hours": 2.5,
      "success_rate": 97.9,
      "acceptance_rate": 92.5,
      "avg_rating": 4.8,
      "total_reviews": 156,
      "avg_appointment_duration_minutes": 45
    },
    "recent_activity": {
      "last_donation_date": "2026-04-29T14:30:00Z",
      "last_appointment_created": "2026-04-29T13:45:00Z",
      "last_emergency_request": "2026-04-28T18:00:00Z",
      "donations_today": 5,
      "appointments_completed_today": 3
    },
    "upcoming_events": [
      {
        "event_id": "uuid",
        "type": "appointment",
        "donor_name": "Ahmed Ali",
        "time": "2026-04-29T16:00:00Z",
        "blood_type": "O+",
        "status": "confirmed"
      },
      {
        "event_id": "uuid",
        "type": "emergency_request",
        "patient_name": "Patient Name",
        "blood_type": "AB+",
        "units_needed": 2,
        "status": "pending_response"
      }
    ]
  }
}
```

---

## 🩸 PART 2: BLOOD INVENTORY MANAGEMENT

### A. BLOOD INVENTORY TRACKING

#### Endpoint 1: Get Blood Inventory

```http
GET /api/v1/hospital/blood-inventory
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- sort_by: string (blood_type|quantity|status) (optional)
- sort_order: asc|desc (optional)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "timestamp": "2026-04-29T15:22:00Z",
    "total_units": 450,
    "inventory_status": "normal",
    "last_updated": "2026-04-29T15:00:00Z",
    "blood_inventory": [
      {
        "blood_type": "O+",
        "available_units": 150,
        "critical_threshold": 100,
        "low_threshold": 150,
        "status": "normal",
        "percentage_of_capacity": 75,
        "expiry_date_earliest": "2026-05-10",
        "units_expiring_soon": 5,
        "last_updated": "2026-04-29T15:00:00Z",
        "last_added": "2026-04-28T10:00:00Z",
        "units_added_count": 10
      },
      {
        "blood_type": "B-",
        "available_units": 20,
        "critical_threshold": 75,
        "low_threshold": 100,
        "status": "critical",
        "percentage_of_capacity": 20,
        "expiry_date_earliest": "2026-05-05",
        "units_expiring_soon": 8,
        "last_updated": "2026-04-29T15:00:00Z",
        "last_added": "2026-04-15T10:00:00Z",
        "units_added_count": 5
      }
    ],
    "inventory_alerts": {
      "critical_count": 2,
      "low_count": 3,
      "expiring_soon_count": 12,
      "alerts": [
        {
          "alert_id": "uuid",
          "blood_type": "B-",
          "severity": "critical",
          "message": "B- blood is critically low",
          "created_at": "2026-04-29T14:30:00Z"
        }
      ]
    }
  }
}
```

---

#### Endpoint 2: Update Blood Inventory

```http
PUT /api/v1/hospital/blood-inventory/{blood_type}
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "action": "add|remove|update",
  "quantity": 10,
  "reason": "new_donation|transfusion|expiry|adjustment",
  "donor_id": "uuid (if action is add)",
  "batch_number": "BATCH-2026-001",
  "expiry_date": "2026-05-10",
  "notes": "optional notes"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "blood_type": "O+",
    "action": "add",
    "quantity_added": 10,
    "new_total": 160,
    "previous_total": 150,
    "status": "normal",
    "inventory_log_id": "uuid",
    "updated_at": "2026-04-29T15:22:00Z",
    "message": "Blood inventory updated successfully"
  }
}
```

---

#### Endpoint 3: Get Blood Inventory History

```http
GET /api/v1/hospital/blood-inventory/history
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- blood_type: string (optional)
- start_date: date (YYYY-MM-DD)
- end_date: date (YYYY-MM-DD)
- action_type: string (add|remove|update)
- page: int (default: 1)
- limit: int (default: 50)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "inventory_logs": [
      {
        "log_id": "uuid",
        "blood_type": "O+",
        "action": "add",
        "quantity": 10,
        "reason": "new_donation",
        "donor_id": "uuid",
        "donor_name": "Ahmed Ali",
        "batch_number": "BATCH-2026-001",
        "previous_quantity": 150,
        "new_quantity": 160,
        "performed_by": "Dr. Hassan",
        "timestamp": "2026-04-29T10:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 10,
      "total_items": 450,
      "items_per_page": 50
    }
  }
}
```

---

#### Endpoint 4: Set Inventory Thresholds

```http
PUT /api/v1/hospital/blood-inventory/thresholds
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "blood_type": "O+",
  "critical_threshold": 100,
  "low_threshold": 150,
  "target_units": 200
}
```

---

## 🚨 PART 3: EMERGENCY REQUEST MANAGEMENT

### A. CREATE & MANAGE EMERGENCY REQUESTS

#### Endpoint 1: Create Emergency Request

```http
POST /api/v1/hospital/requests/create-emergency
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "blood_type": "O+",
  "units_needed": 5,
  "urgency_level": "critical|high|moderate",
  "patient_name": "Patient Name",
  "patient_age": 45,
  "patient_gender": "Male",
  "medical_condition": "Trauma|Accident|Surgery|Anemia|etc",
  "hospital_contact": "+92-21-123456",
  "contact_person_name": "Dr. Hassan",
  "location_latitude": 24.8607,
  "location_longitude": 67.0011,
  "description": "Detailed description of emergency",
  "estimated_needed_by": "2026-04-29T16:00:00Z"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "blood_type": "O+",
    "units_needed": 5,
    "urgency_level": "critical",
    "status": "pending",
    "request_code": "REQ-2026-04-29-001",
    "created_at": "2026-04-29T15:22:00Z",
    "estimated_needed_by": "2026-04-29T16:00:00Z",
    "responses_received": 0,
    "message": "Emergency request created successfully",
    "share_link": "https://app.example.com/emergency/REQ-2026-04-29-001"
  }
}
```

---

#### Endpoint 2: Get Hospital Requests

```http
GET /api/v1/hospital/requests
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- status: string (pending|in_progress|completed|cancelled|expired)
- urgency: string (critical|high|moderate)
- blood_type: string (optional)
- date_from: date (YYYY-MM-DD)
- date_to: date (YYYY-MM-DD)
- sort_by: string (created_at|urgency|status)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "requests": [
      {
        "request_id": "uuid",
        "blood_type": "O+",
        "units_needed": 5,
        "units_received": 2,
        "units_pending": 3,
        "urgency_level": "critical",
        "status": "in_progress",
        "request_code": "REQ-2026-04-29-001",
        "patient_name": "Patient Name",
        "medical_condition": "Trauma",
        "responses_count": 8,
        "accepted_count": 2,
        "pending_count": 6,
        "created_at": "2026-04-29T15:22:00Z",
        "estimated_needed_by": "2026-04-29T16:00:00Z",
        "time_remaining_hours": 0.5
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 87,
      "items_per_page": 20
    },
    "summary": {
      "total_pending": 3,
      "total_in_progress": 8,
      "total_completed": 156,
      "urgent_count": 11
    }
  }
}
```

---

#### Endpoint 3: Get Request Details & Responses

```http
GET /api/v1/hospital/requests/{request_id}
Authorization: Bearer {hospital_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "request_code": "REQ-2026-04-29-001",
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "basic_info": {
      "blood_type": "O+",
      "units_needed": 5,
      "urgency_level": "critical",
      "status": "in_progress",
      "created_at": "2026-04-29T15:22:00Z",
      "estimated_needed_by": "2026-04-29T16:00:00Z"
    },
    "patient_info": {
      "patient_name": "Patient Name",
      "patient_age": 45,
      "gender": "Male",
      "medical_condition": "Trauma",
      "description": "Detailed description"
    },
    "contact_info": {
      "hospital_contact": "+92-21-123456",
      "contact_person_name": "Dr. Hassan",
      "location": {
        "latitude": 24.8607,
        "longitude": 67.0011,
        "address": "Street, City"
      }
    },
    "progress": {
      "units_needed": 5,
      "units_received": 2,
      "units_pending": 3,
      "received_percentage": 40
    },
    "responses": [
      {
        "response_id": "uuid",
        "donor_id": "uuid",
        "donor_name": "Ahmed Ali",
        "donor_phone": "+92-300-1234567",
        "blood_type": "O+",
        "status": "accepted",
        "response_time": "2026-04-29T15:30:00Z",
        "appointment_scheduled": true,
        "appointment_time": "2026-04-29T16:00:00Z",
        "distance_km": 2.5,
        "estimated_arrival_minutes": 8
      },
      {
        "response_id": "uuid",
        "donor_id": "uuid",
        "donor_name": "Fatima Khan",
        "donor_phone": "+92-300-9876543",
        "blood_type": "O+",
        "status": "pending",
        "response_time": "2026-04-29T15:28:00Z",
        "appointment_scheduled": false
      }
    ],
    "statistics": {
      "total_responses": 8,
      "accepted_responses": 2,
      "pending_responses": 6,
      "declined_responses": 0,
      "response_rate": 80
    }
  }
}
```

---

#### Endpoint 4: Update Request Status

```http
PUT /api/v1/hospital/requests/{request_id}
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "action": "update_status|mark_received|close|cancel",
  "new_status": "completed|in_progress|cancelled",
  "units_received": 5 (if mark_received),
  "notes": "optional notes"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "previous_status": "in_progress",
    "new_status": "completed",
    "units_received": 5,
    "units_needed": 5,
    "fulfilled_percentage": 100,
    "updated_at": "2026-04-29T15:22:00Z",
    "message": "Emergency request completed successfully"
  }
}
```

---

#### Endpoint 5: Close Emergency Request

```http
POST /api/v1/hospital/requests/{request_id}/close
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "reason": "fulfilled|cancelled|expired|other",
  "notes": "optional closure notes",
  "units_successfully_received": 5
}
```

---

## 👥 PART 4: STAFF MANAGEMENT

### A. STAFF OPERATIONS

#### Endpoint 1: Get Hospital Staff

```http
GET /api/v1/hospital/staff
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- status: string (active|inactive|on_leave)
- role: string (doctor|nurse|technician|manager)
- search: string (name, email)
- sort_by: string (name|role|joined_date)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "total_staff": 28,
    "active_staff": 25,
    "inactive_staff": 3,
    "staff": [
      {
        "staff_id": "uuid",
        "full_name": "Dr. Hassan",
        "email": "hassan@hospital.com",
        "phone": "+92-300-1111111",
        "role": "doctor",
        "specialization": "Emergency Medicine",
        "license_number": "LIC-2015-001",
        "status": "active",
        "joined_date": "2020-01-15",
        "last_login": "2026-04-29T14:30:00Z",
        "is_verified": true,
        "blood_type": "O+",
        "availability": {
          "available": true,
          "available_until": "2026-04-29T18:00:00Z",
          "on_duty": true
        },
        "performance": {
          "donations_coordinated": 245,
          "avg_rating": 4.8,
          "total_reviews": 45
        }
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 2,
      "total_items": 28,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 2: Add Staff Member

```http
POST /api/v1/hospital/staff
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "full_name": "Dr. New Doctor",
  "email": "newdoctor@hospital.com",
  "phone": "+92-300-2222222",
  "role": "doctor|nurse|technician|manager",
  "specialization": "Emergency Medicine",
  "license_number": "LIC-2020-001",
  "blood_type": "AB+",
  "employment_type": "full_time|part_time|contract",
  "department": "Emergency",
  "shift": "day|night|rotating"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "staff_id": "uuid",
    "full_name": "Dr. New Doctor",
    "email": "newdoctor@hospital.com",
    "role": "doctor",
    "status": "active",
    "created_at": "2026-04-29T15:22:00Z",
    "message": "Staff member added successfully"
  }
}
```

---

#### Endpoint 3: Update Staff Member

```http
PUT /api/v1/hospital/staff/{staff_id}
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "status": "active|inactive|on_leave",
  "availability": true,
  "available_until": "2026-04-29T18:00:00Z",
  "on_duty": true,
  "phone": "+92-300-2222222",
  "specialization": "Updated Specialization"
}
```

---

## 📅 PART 5: APPOINTMENT MANAGEMENT

### A. APPOINTMENT OPERATIONS

#### Endpoint 1: Get Hospital Appointments

```http
GET /api/v1/hospital/appointments
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- status: string (confirmed|completed|cancelled|pending)
- date: date (YYYY-MM-DD)
- blood_type: string (optional)
- sort_by: string (appointment_date|status)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointments": [
      {
        "appointment_id": "uuid",
        "donor_id": "uuid",
        "donor_name": "Ahmed Ali",
        "donor_phone": "+92-300-1234567",
        "blood_type": "O+",
        "appointment_date": "2026-04-29",
        "appointment_time": "10:00-10:30",
        "time_slot": "10:00-10:30",
        "status": "confirmed",
        "confirmation_code": "APPT-2026-04-29-001",
        "checked_in": false,
        "assigned_staff": "Dr. Hassan",
        "notes": "optional notes"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 89,
      "items_per_page": 20
    },
    "summary": {
      "total_today": 8,
      "completed_today": 3,
      "pending_today": 5,
      "total_confirmed": 45,
      "total_completed": 789
    }
  }
}
```

---

#### Endpoint 2: Create Appointment Slots

```http
POST /api/v1/hospital/appointment-slots
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "appointment_date": "2026-05-01",
  "time_slots": [
    {
      "start_time": "09:00",
      "end_time": "09:30",
      "capacity": 5,
      "blood_type": "O+"
    },
    {
      "start_time": "10:00",
      "end_time": "10:30",
      "capacity": 5,
      "blood_type": "O+"
    }
  ],
  "is_recurring": false,
  "recurring_until": "2026-05-31" (if recurring)
}
```

---

#### Endpoint 3: Mark Appointment Completed

```http
PUT /api/v1/hospital/appointments/{appointment_id}
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "action": "complete|cancel|no_show",
  "units_collected": 1,
  "donation_status": "successful|failed",
  "failure_reason": "optional if failed",
  "staff_notes": "optional notes"
}
```

---

## 📊 PART 6: REPORTS & ANALYTICS

### A. HOSPITAL REPORTS

#### Endpoint 1: Get Monthly Reports

```http
GET /api/v1/hospital/reports/monthly
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- month: int (1-12)
- year: int (default: current year)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "report_period": "April 2026",
    "report_date": "2026-04-29T15:22:00Z",
    "donations": {
      "total_donations": 89,
      "successful_donations": 87,
      "failed_donations": 2,
      "success_rate": 97.75,
      "units_collected": 87,
      "avg_units_per_donation": 1.0,
      "blood_type_breakdown": {
        "O+": 25,
        "O-": 15,
        "A+": 20,
        "A-": 8,
        "B+": 12,
        "B-": 5,
        "AB+": 3,
        "AB-": 1
      }
    },
    "emergency_requests": {
      "total_requests": 8,
      "completed_requests": 6,
      "pending_requests": 2,
      "avg_response_time_hours": 2.5,
      "avg_fulfillment_rate": 92.5,
      "critical_requests": 3,
      "high_priority_requests": 5
    },
    "appointments": {
      "total_appointments": 125,
      "completed_appointments": 120,
      "cancelled_appointments": 5,
      "no_show_appointments": 0,
      "attendance_rate": 96
    },
    "blood_inventory": {
      "total_units_in_stock": 450,
      "units_added": 110,
      "units_used": 87,
      "units_expired": 5,
      "critical_stock_types": ["B-", "AB-"],
      "avg_stock_value": "45 units per type"
    },
    "performance": {
      "avg_rating": 4.8,
      "total_reviews": 35,
      "staff_count": 28,
      "avg_response_time_hours": 2.5,
      "acceptance_rate": 92.5
    },
    "revenue": {
      "total_units_supplied": 87,
      "estimated_revenue": "PKR 435,000",
      "commission_earned": "PKR 43,500"
    }
  }
}
```

---

#### Endpoint 2: Get Performance Analytics

```http
GET /api/v1/hospital/analytics
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- start_date: date (YYYY-MM-DD)
- end_date: date (YYYY-MM-DD)
- metric_type: string (donations|requests|appointments|inventory)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "period": "2026-01-01 to 2026-04-29",
    "metrics": {
      "total_donations": 890,
      "monthly_average": 222.5,
      "weekly_average": 51.4,
      "daily_average": 7.3,
      "success_rate": 97.9,
      "trend": "upward"
    },
    "charts": {
      "donation_trend": [
        {"date": "2026-04-01", "count": 85},
        {"date": "2026-04-08", "count": 90},
        {"date": "2026-04-15", "count": 92},
        {"date": "2026-04-22", "count": 89},
        {"date": "2026-04-29", "count": 89}
      ],
      "blood_type_distribution": {
        "O+": 25,
        "O-": 15,
        "A+": 20,
        "A-": 8,
        "B+": 12,
        "B-": 5,
        "AB+": 3,
        "AB-": 2
      }
    }
  }
}
```

---

#### Endpoint 3: Export Reports

```http
GET /api/v1/hospital/reports/export
Authorization: Bearer {hospital_token}
Content-Type: application/json

Query Parameters:
- format: string (pdf|csv|excel)
- report_type: string (monthly|annual|donations|appointments)
- month: int (optional)
- year: int (optional)
```

**Response:**
```
Returns file download (PDF/CSV/Excel)
```

---

## ⚙️ PART 7: HOSPITAL SETTINGS

### A. SETTINGS & PREFERENCES

#### Endpoint 1: Get Hospital Settings

```http
GET /api/v1/hospital/settings
Authorization: Bearer {hospital_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "basic_settings": {
      "hospital_name": "Hospital A",
      "address": "Street, City, Country",
      "phone": "+92-21-123456",
      "email": "admin@hospitala.com",
      "website": "https://hospitala.com"
    },
    "blood_bank_settings": {
      "blood_bank_contact": "+92-21-111222",
      "blood_bank_email": "blood@hospitala.com",
      "manager_name": "Dr. Blood Bank Manager",
      "operating_hours": "09:00-18:00",
      "emergency_contact": "+92-300-1111111"
    },
    "operational_settings": {
      "max_concurrent_appointments": 10,
      "appointment_duration_minutes": 45,
      "auto_accept_emergency": false,
      "emergency_acceptance_timeout_minutes": 15,
      "staff_on_duty_required": 3,
      "accepting_requests": true
    },
    "notification_settings": {
      "notify_on_emergency_requests": true,
      "notify_on_donor_response": true,
      "notify_on_appointment_booking": true,
      "notification_channel": "push|sms|email",
      "emergency_notification_priority": "high"
    },
    "blood_alert_thresholds": {
      "O+": {"critical": 100, "low": 150},
      "O-": {"critical": 80, "low": 120},
      "A+": {"critical": 100, "low": 150},
      "A-": {"critical": 75, "low": 120},
      "B+": {"critical": 100, "low": 150},
      "B-": {"critical": 75, "low": 120},
      "AB+": {"critical": 75, "low": 120},
      "AB-": {"critical": 50, "low": 100}
    }
  }
}
```

---

#### Endpoint 2: Update Hospital Settings

```http
PUT /api/v1/hospital/settings
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "section": "basic|blood_bank|operational|notification|blood_alerts",
  "updates": {
    "hospital_name": "Updated Name",
    "phone": "+92-21-999999",
    "accepting_requests": true,
    "auto_accept_emergency": false
  }
}
```

---

#### Endpoint 3: Update Blood Bank Settings

```http
PUT /api/v1/hospital/blood-bank-settings
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "blood_bank_contact": "+92-21-111222",
  "blood_bank_email": "blood@hospital.com",
  "manager_name": "Dr. Manager",
  "operating_hours": "09:00-18:00",
  "emergency_contact": "+92-300-1111111"
}
```

---

#### Endpoint 4: Update Notification Preferences

```http
PUT /api/v1/hospital/notification-preferences
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "notify_on_emergency_requests": true,
  "notify_on_donor_response": true,
  "notify_on_appointment_booking": true,
  "notification_channel": "push",
  "emergency_notification_priority": "high",
  "notification_frequency": "realtime|hourly|daily"
}
```

---

## 👤 PART 8: HOSPITAL PROFILE

#### Endpoint 1: Get Hospital Profile

```http
GET /api/v1/hospital/profile
Authorization: Bearer {hospital_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "basic_info": {
      "name": "Hospital A",
      "license_number": "LIC-2020-001",
      "registration_date": "2020-01-15",
      "address": "Street, City, Country",
      "latitude": 24.8607,
      "longitude": 67.0011,
      "phone": "+92-21-123456",
      "email": "admin@hospitala.com",
      "website": "https://hospitala.com",
      "director_name": "Dr. Ahmed Khan"
    },
    "contact_info": {
      "primary_contact": "+92-21-123456",
      "secondary_contact": "+92-300-1234567",
      "emergency_contact": "+92-300-9876543",
      "blood_bank_contact": "+92-21-111222"
    },
    "verification": {
      "verified": true,
      "verified_at": "2020-01-20T10:00:00Z",
      "verification_status": "approved",
      "license_expiry": "2027-01-15"
    },
    "statistics": {
      "total_donations": 890,
      "total_emergency_requests": 156,
      "total_appointments": 789,
      "avg_rating": 4.8,
      "total_reviews": 156,
      "staff_count": 28,
      "blood_inventory_units": 450
    },
    "account_status": {
      "status": "active",
      "suspended": false,
      "accepting_requests": true,
      "last_activity": "2026-04-29T15:00:00Z"
    }
  }
}
```

---

#### Endpoint 2: Update Hospital Profile

```http
PUT /api/v1/hospital/profile
Authorization: Bearer {hospital_token}
Content-Type: application/json

Body:
{
  "name": "Updated Hospital Name",
  "address": "New Street, City, Country",
  "phone": "+92-21-999999",
  "website": "https://updated-hospital.com",
  "director_name": "Dr. New Name",
  "latitude": 24.8607,
  "longitude": 67.0011
}
```

---

## 💾 DATABASE MODELS NEEDED

### Hospital Tables

#### hospital_blood_inventory Table
```sql
CREATE TABLE hospital_blood_inventory (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  blood_type VARCHAR(10) NOT NULL,
  available_units INT DEFAULT 0,
  critical_threshold INT,
  low_threshold INT,
  target_units INT,
  status VARCHAR(20) DEFAULT 'normal',
  last_updated TIMESTAMP DEFAULT NOW(),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_hospital_blood_type ON hospital_blood_inventory(hospital_id, blood_type);
```

#### hospital_blood_inventory_logs Table
```sql
CREATE TABLE hospital_blood_inventory_logs (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  blood_type VARCHAR(10) NOT NULL,
  action VARCHAR(50),
  quantity INT,
  reason VARCHAR(100),
  donor_id UUID REFERENCES users(id),
  batch_number VARCHAR(100),
  expiry_date DATE,
  previous_quantity INT,
  new_quantity INT,
  performed_by VARCHAR(150),
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_inventory_logs_hospital_id ON hospital_blood_inventory_logs(hospital_id);
CREATE INDEX idx_inventory_logs_blood_type ON hospital_blood_inventory_logs(blood_type);
CREATE INDEX idx_inventory_logs_created_at ON hospital_blood_inventory_logs(created_at);
```

#### emergency_requests Table
```sql
CREATE TABLE emergency_requests (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  blood_type VARCHAR(10) NOT NULL,
  units_needed INT NOT NULL,
  units_received INT DEFAULT 0,
  urgency_level VARCHAR(50) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  request_code VARCHAR(100) UNIQUE NOT NULL,
  patient_name VARCHAR(150),
  patient_age INT,
  patient_gender VARCHAR(20),
  medical_condition VARCHAR(255),
  hospital_contact VARCHAR(20),
  contact_person_name VARCHAR(150),
  location_latitude FLOAT,
  location_longitude FLOAT,
  description TEXT,
  estimated_needed_by TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  completed_at TIMESTAMP
);

CREATE INDEX idx_emergency_requests_hospital_id ON emergency_requests(hospital_id);
CREATE INDEX idx_emergency_requests_status ON emergency_requests(status);
CREATE INDEX idx_emergency_requests_urgency ON emergency_requests(urgency_level);
CREATE INDEX idx_emergency_requests_created_at ON emergency_requests(created_at);
```

#### emergency_responses Table
```sql
CREATE TABLE emergency_responses (
  id UUID PRIMARY KEY,
  emergency_request_id UUID NOT NULL REFERENCES emergency_requests(id),
  donor_id UUID NOT NULL REFERENCES users(id),
  response_status VARCHAR(50) DEFAULT 'pending',
  response_time TIMESTAMP,
  appointment_scheduled BOOLEAN DEFAULT false,
  appointment_time TIMESTAMP,
  distance_km FLOAT,
  estimated_arrival_minutes INT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_emergency_responses_request_id ON emergency_responses(emergency_request_id);
CREATE INDEX idx_emergency_responses_donor_id ON emergency_responses(donor_id);
CREATE INDEX idx_emergency_responses_status ON emergency_responses(response_status);
```

#### hospital_staff Table
```sql
CREATE TABLE hospital_staff (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  user_id UUID REFERENCES users(id),
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(255) UNIQUE,
  phone VARCHAR(20),
  role VARCHAR(50) NOT NULL,
  specialization VARCHAR(150),
  license_number VARCHAR(100) UNIQUE,
  status VARCHAR(50) DEFAULT 'active',
  blood_type VARCHAR(10),
  employment_type VARCHAR(50),
  department VARCHAR(100),
  shift VARCHAR(50),
  joined_date DATE,
  available BOOLEAN DEFAULT true,
  available_until TIMESTAMP,
  on_duty BOOLEAN DEFAULT false,
  last_login TIMESTAMP,
  is_verified BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_hospital_staff_hospital_id ON hospital_staff(hospital_id);
CREATE INDEX idx_hospital_staff_status ON hospital_staff(status);
```

#### hospital_appointment_slots Table
```sql
CREATE TABLE hospital_appointment_slots (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  appointment_date DATE NOT NULL,
  time_slot_start TIME NOT NULL,
  time_slot_end TIME NOT NULL,
  capacity INT DEFAULT 5,
  booked_count INT DEFAULT 0,
  blood_type_needed VARCHAR(10),
  is_available BOOLEAN DEFAULT true,
  is_recurring BOOLEAN DEFAULT false,
  recurring_until DATE,
  created_by UUID REFERENCES hospital_staff(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_appointment_slots_hospital_id ON hospital_appointment_slots(hospital_id);
CREATE INDEX idx_appointment_slots_date ON hospital_appointment_slots(appointment_date);
```

#### hospital_settings Table
```sql
CREATE TABLE hospital_settings (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL UNIQUE REFERENCES hospitals(id),
  max_concurrent_appointments INT DEFAULT 10,
  appointment_duration_minutes INT DEFAULT 45,
  auto_accept_emergency BOOLEAN DEFAULT false,
  emergency_acceptance_timeout_minutes INT DEFAULT 15,
  staff_on_duty_required INT DEFAULT 3,
  accepting_requests BOOLEAN DEFAULT true,
  notify_on_emergency BOOLEAN DEFAULT true,
  notify_on_donor_response BOOLEAN DEFAULT true,
  notify_on_appointment_booking BOOLEAN DEFAULT true,
  notification_channel VARCHAR(50) DEFAULT 'push',
  emergency_notification_priority VARCHAR(50) DEFAULT 'high',
  blood_thresholds JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_hospital_settings_hospital_id ON hospital_settings(hospital_id);
```

#### hospital_reports Table
```sql
CREATE TABLE hospital_reports (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  report_period VARCHAR(50),
  report_month INT,
  report_year INT,
  total_donations INT,
  successful_donations INT,
  failed_donations INT,
  success_rate FLOAT,
  emergency_requests INT,
  emergency_completed INT,
  emergency_pending INT,
  avg_response_time FLOAT,
  blood_type_breakdown JSONB,
  generated_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_hospital_reports_hospital_id ON hospital_reports(hospital_id);
CREATE INDEX idx_hospital_reports_period ON hospital_reports(report_year, report_month);
```

---

## 🔧 BACKEND SERVICES NEEDED

### 1. HospitalService

```javascript
// src/services/hospital.service.js

class HospitalService {
  // Dashboard
  async getDashboard(hospitalId) {}
  
  // Blood Inventory
  async getBloodInventory(hospitalId) {}
  async updateBloodInventory(hospitalId, bloodType, action, quantity) {}
  async getInventoryHistory(hospitalId, filters) {}
  async setInventoryThresholds(hospitalId, thresholds) {}

  // Emergency Requests
  async createEmergencyRequest(hospitalId, requestData) {}
  async getHospitalRequests(hospitalId, filters) {}
  async getRequestDetails(requestId) {}
  async getRequestResponses(requestId) {}
  async updateRequestStatus(requestId, newStatus) {}
  async closeRequest(requestId, reason) {}

  // Appointments
  async getHospitalAppointments(hospitalId, filters) {}
  async createAppointmentSlots(hospitalId, slotData) {}
  async markAppointmentCompleted(appointmentId, data) {}

  // Reports
  async getMonthlyReport(hospitalId, month, year) {}
  async getAnalytics(hospitalId, filters) {}
  async exportReport(hospitalId, format, type) {}

  // Staff
  async getHospitalStaff(hospitalId) {}
  async addStaffMember(hospitalId, staffData) {}
  async updateStaffMember(staffId, updateData) {}

  // Profile & Settings
  async getHospitalProfile(hospitalId) {}
  async updateHospitalProfile(hospitalId, updateData) {}
  async getHospitalSettings(hospitalId) {}
  async updateHospitalSettings(hospitalId, settings) {}
}
```

### 2. InventoryService

```javascript
// src/services/inventory.service.js

class InventoryService {
  async addBloodUnits(hospitalId, bloodType, quantity, reason) {}
  async removeBloodUnits(hospitalId, bloodType, quantity, reason) {}
  async checkInventoryStatus(hospitalId) {}
  async getAlerts(hospitalId) {}
  async logTransaction(hospitalId, transactionData) {}
}
```

### 3. EmergencyService

```javascript
// src/services/emergency.service.js

class EmergencyService {
  async createRequest(hospitalId, requestData) {}
  async publishRequest(requestId) {}
  async getResponses(requestId) {}
  async updateProgress(requestId, unitsReceived) {}
  async calculateStats(requestId) {}
  async notifyDonors(requestId, criteria) {}
}
```

---

## 📁 BACKEND ROUTES NEEDED

```javascript
// src/routes/hospital.routes.js

// Dashboard
router.get('/dashboard', hospitalAuth, hospitalController.getDashboard);

// Blood Inventory
router.get('/blood-inventory', hospitalAuth, hospitalController.getBloodInventory);
router.put('/blood-inventory/:bloodType', hospitalAuth, hospitalController.updateBloodInventory);
router.get('/blood-inventory/history', hospitalAuth, hospitalController.getInventoryHistory);
router.put('/blood-inventory/thresholds', hospitalAuth, hospitalController.setThresholds);

// Emergency Requests
router.post('/requests/create-emergency', hospitalAuth, hospitalController.createEmergencyRequest);
router.get('/requests', hospitalAuth, hospitalController.getHospitalRequests);
router.get('/requests/:requestId', hospitalAuth, hospitalController.getRequestDetails);
router.get('/requests/:requestId/responses', hospitalAuth, hospitalController.getRequestResponses);
router.put('/requests/:requestId', hospitalAuth, hospitalController.updateRequestStatus);
router.post('/requests/:requestId/close', hospitalAuth, hospitalController.closeRequest);

// Staff Management
router.get('/staff', hospitalAuth, hospitalController.getHospitalStaff);
router.post('/staff', hospitalAuth, hospitalController.addStaffMember);
router.put('/staff/:staffId', hospitalAuth, hospitalController.updateStaffMember);

// Appointments
router.get('/appointments', hospitalAuth, hospitalController.getHospitalAppointments);
router.post('/appointment-slots', hospitalAuth, hospitalController.createAppointmentSlots);
router.put('/appointments/:appointmentId', hospitalAuth, hospitalController.markAppointmentCompleted);

// Reports
router.get('/reports/monthly', hospitalAuth, hospitalController.getMonthlyReport);
router.get('/analytics', hospitalAuth, hospitalController.getAnalytics);
router.get('/reports/export', hospitalAuth, hospitalController.exportReport);

// Profile & Settings
router.get('/profile', hospitalAuth, hospitalController.getHospitalProfile);
router.put('/profile', hospitalAuth, hospitalController.updateHospitalProfile);
router.get('/settings', hospitalAuth, hospitalController.getHospitalSettings);
router.put('/settings', hospitalAuth, hospitalController.updateHospitalSettings);
router.put('/blood-bank-settings', hospitalAuth, hospitalController.updateBloodBankSettings);
router.put('/notification-preferences', hospitalAuth, hospitalController.updateNotificationPreferences);
```

---

## 📊 IMPLEMENTATION CHECKLIST

### Phase 1: Database Setup (Week 1)
- [ ] Create `hospital_blood_inventory` table
- [ ] Create `hospital_blood_inventory_logs` table
- [ ] Create `emergency_requests` table
- [ ] Create `emergency_responses` table
- [ ] Create `hospital_staff` table
- [ ] Create `hospital_appointment_slots` table
- [ ] Create `hospital_settings` table
- [ ] Create `hospital_reports` table
- [ ] Create database indexes

### Phase 2: Core Hospital Services (Week 2)
- [ ] Create `HospitalService` class
- [ ] Create `InventoryService` class
- [ ] Create `EmergencyService` class
- [ ] Implement hospital authentication middleware
- [ ] Implement audit logging

### Phase 3: Dashboard & Inventory (Week 2-3)
- [ ] Implement dashboard endpoint
- [ ] Implement blood inventory endpoints
- [ ] Implement inventory tracking
- [ ] Implement alert system

### Phase 4: Emergency Management (Week 3-4)
- [ ] Implement emergency request creation
- [ ] Implement donor notification system
- [ ] Implement response tracking
- [ ] Implement request status updates

### Phase 5: Staff & Appointments (Week 4)
- [ ] Implement staff management
- [ ] Implement appointment slot creation
- [ ] Implement appointment completion
- [ ] Implement availability tracking

### Phase 6: Reports & Settings (Week 5)
- [ ] Implement monthly reports
- [ ] Implement analytics
- [ ] Implement report export
- [ ] Implement settings management

### Phase 7: Testing & Deployment (Week 6)
- [ ] Unit tests for all services
- [ ] Integration tests for workflows
- [ ] Load testing (500 concurrent hospitals)
- [ ] Security audit
- [ ] Production deployment

---

## 🔑 Key Requirements Summary

| Component | Count | Complexity |
|-----------|-------|-----------|
| **API Endpoints** | 30+ | Hard |
| **Database Tables** | 8 | Medium |
| **Services** | 3 | Hard |
| **Real-time Features** | Notifications | High |
| **Reporting** | Complete | Medium |

---

## 🎯 Success Metrics

- Dashboard load time: < 1 second
- Emergency request creation: < 500ms
- Blood inventory updates: < 200ms
- Staff management: < 300ms
- Report generation: < 3 seconds
- Appointment slot creation: < 400ms
- Real-time notification delivery: < 2 seconds
- Emergency response rate: > 90% within 15 minutes

---

## 📝 Security Considerations

1. **Hospital Authentication**
   - Token-based authentication
   - Session management
   - Activity logging

2. **Data Protection**
   - Encrypt sensitive data
   - Role-based access control
   - Patient data privacy

3. **Emergency Operations**
   - Real-time notifications
   - Audit trails
   - Backup systems

4. **Compliance**
   - HIPAA compliance for medical data
   - Data retention policies
   - Regular backups

---

## 📞 Support & Documentation

- API documentation: `/api/v1/hospital/docs`
- Blood inventory guide: `/docs/HOSPITAL_INVENTORY_GUIDE.md`
- Emergency procedures: `/docs/EMERGENCY_PROCEDURES.md`
- Staff management: `/docs/STAFF_MANAGEMENT.md`

