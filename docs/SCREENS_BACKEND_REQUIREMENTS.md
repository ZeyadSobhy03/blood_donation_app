# Comprehensive Screen-to-Backend Requirements Report
## Blood Donation App - All Roles

**Document Version:** 1.0  
**Date:** April 26, 2026  
**Prepared For:** Backend Development Team  
**Scope:** All User Roles (Donor, Hospital, Admin)

---

## Table of Contents

1. [Overview](#overview)
2. [Donor Role Screens](#donor-role-screens)
3. [Hospital Role Screens](#hospital-role-screens)
4. [Admin Role Screens](#admin-role-screens)
5. [Authentication & Onboarding Screens](#authentication--onboarding-screens)
6. [Shared/Cross-Role Screens](#sharedcross-role-screens)
7. [API Integration Summary](#api-integration-summary)
8. [Database Requirements Summary](#database-requirements-summary)

---

# DONOR ROLE SCREENS

## 1. Donor Main Layout (Tab Navigation)

**File:** `lib/presentation/role/donor/tabs/donor_main_layout.dart`

**Purpose:** Main container with 5-tab bottom navigation

**Tabs:**
1. Home
2. Find Hospital
3. Donate
4. Rewards
5. Profile

**Backend Requirements:**
- None (UI-only container)

---

## 2. Donor Home Screen

**File:** `lib/presentation/role/donor/tabs/home/home.dart`

**Features:**
- Welcome message with donor stats
- Donation status card
- Urgent requests list
- Recent activity section
- Navigation buttons

### Backend Endpoints Required:

#### GET `/api/v1/donor/dashboard`
```json
{
  "success": true,
  "data": {
    "donor_name": "string",
    "total_donations": "integer",
    "last_donation_date": "ISO 8601",
    "next_eligible_date": "ISO 8601",
    "blood_type": "string",
    "donation_status": "ELIGIBLE|NOT_ELIGIBLE|PENDING",
    "donation_history": {
      "total_donated": "float (liters)",
      "total_count": "integer",
      "streak_days": "integer"
    }
  }
}
```

#### GET `/api/v1/urgent-requests`
```json
{
  "success": true,
  "data": {
    "requests": [
      {
        "request_id": "uuid",
        "title": "string",
        "blood_type": "string",
        "units_needed": "integer",
        "hospital_name": "string",
        "hospital_location": {
          "latitude": "float",
          "longitude": "float",
          "distance_km": "float"
        },
        "is_emergency": "boolean",
        "patient_type": "string",
        "contact_number": "string",
        "created_at": "ISO 8601"
      }
    ]
  }
}
```

#### GET `/api/v1/donor/recent-activity`
```json
{
  "success": true,
  "data": {
    "activities": [
      {
        "activity_id": "uuid",
        "activity_type": "DONATION|EMERGENCY_RESPONSE|BADGE_EARNED|POINTS_EARNED",
        "description": "string",
        "timestamp": "ISO 8601",
        "icon": "string",
        "color": "string (hex)"
      }
    ]
  }
}
```

---

## 3. Find Hospital Screen

**File:** `lib/presentation/role/donor/tabs/find_hospital/find.dart`

**Features:**
- Hospital map view
- Hospital search/filter
- Hospital details
- Location-based sorting

### Backend Endpoints Required:

#### GET `/api/v1/hospitals`
```json
{
  "success": true,
  "data": {
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "string",
        "address": "string",
        "location": {
          "latitude": "float",
          "longitude": "float"
        },
        "blood_types_needed": ["O+", "A-"],
        "urgency_level": "LOW|MEDIUM|HIGH|CRITICAL",
        "distance_km": "float",
        "contact_number": "string",
        "email": "string",
        "website": "string (nullable)",
        "emergency_contact": "string",
        "operating_hours": "string"
      }
    ],
    "total_count": "integer"
  }
}
```

#### GET `/api/v1/hospitals/{hospital_id}`
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "name": "string",
    "full_details": {
      "address": "string",
      "phone": "string",
      "email": "string",
      "website": "string",
      "services": ["string"],
      "blood_bank_hours": "string",
      "emergency_services": "boolean",
      "facilities": ["string"]
    },
    "current_blood_status": {
      "O_positive": "CRITICAL|LOW|ADEQUATE",
      "O_negative": "CRITICAL|LOW|ADEQUATE",
      "A_positive": "CRITICAL|LOW|ADEQUATE",
      "A_negative": "CRITICAL|LOW|ADEQUATE",
      "B_positive": "CRITICAL|LOW|ADEQUATE",
      "B_negative": "CRITICAL|LOW|ADEQUATE",
      "AB_positive": "CRITICAL|LOW|ADEQUATE",
      "AB_negative": "CRITICAL|LOW|ADEQUATE"
    },
    "distance_km": "float"
  }
}
```

---

## 4. Donate Screen

**File:** `lib/presentation/role/donor/tabs/donate/donate.dart`

**Features:**
- Donation eligibility check
- Donation appointment booking
- Pre-donation questionnaire
- Donation history

### Backend Endpoints Required:

#### GET `/api/v1/donor/donation-eligibility`
```json
{
  "success": true,
  "data": {
    "is_eligible": "boolean",
    "reason": "string (if not eligible)",
    "last_donation_date": "ISO 8601 (nullable)",
    "days_until_next_donation": "integer",
    "health_status": "CLEARED|NEED_CHECKUP|DEFERRED"
  }
}
```

#### POST `/api/v1/donations/book-appointment`
```json
{
  "hospital_id": "uuid",
  "appointment_date": "ISO 8601",
  "appointment_time": "HH:MM",
  "blood_type": "string",
  "notes": "string (optional)"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "uuid",
    "confirmation_code": "string",
    "appointment_date": "ISO 8601",
    "appointment_time": "HH:MM",
    "hospital_name": "string",
    "instructions": "string",
    "reminder_sent": "boolean"
  }
}
```

#### POST `/api/v1/donations/complete`
```json
{
  "appointment_id": "uuid",
  "units_donated": "float",
  "blood_type_verified": "boolean",
  "health_status_post": "NORMAL|SLIGHT_DIZZINESS|SIGNIFICANT_DIZZINESS"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donation_id": "uuid",
    "points_awarded": "integer",
    "next_eligible_date": "ISO 8601",
    "lifetime_donated": "float",
    "donation_count": "integer",
    "badges_unlocked": ["badge_id"]
  }
}
```

#### GET `/api/v1/donor/donations`
```json
{
  "success": true,
  "data": {
    "donations": [
      {
        "donation_id": "uuid",
        "donation_date": "ISO 8601",
        "hospital_name": "string",
        "units_donated": "float",
        "blood_type": "string",
        "status": "COMPLETED|CANCELLED|PENDING",
        "points_earned": "integer"
      }
    ],
    "pagination": {
      "current_page": "integer",
      "total_pages": "integer"
    }
  }
}
```

---

## 5. Rewards Screen

**File:** `lib/presentation/role/donor/tabs/rewards/rewards_screen.dart`

**Features:**
- Points display
- Rewards tab
- Badges tab
- Tier system visualization

### Backend Endpoints Required:

**See BACKEND_REWARDS_REQUIREMENTS.md for detailed specifications**

Key endpoints:
- `GET /api/v1/donor/points`
- `GET /api/v1/rewards`
- `POST /api/v1/rewards/{reward_id}/redeem`
- `GET /api/v1/donor/badges`

---

## 6. Donor Profile Screen

**File:** `lib/presentation/role/donor/tabs/profile/profile.dart`

**Features:**
- Personal information
- Health history
- Blood type
- Contact information
- Preferences
- Account security

### Backend Endpoints Required:

#### GET `/api/v1/donor/profile`
```json
{
  "success": true,
  "data": {
    "user_id": "uuid",
    "first_name": "string",
    "last_name": "string",
    "email": "string",
    "phone": "string",
    "date_of_birth": "YYYY-MM-DD",
    "blood_type": "string",
    "gender": "MALE|FEMALE|OTHER",
    "address": "string",
    "city": "string",
    "country": "string",
    "emergency_contact_name": "string",
    "emergency_contact_phone": "string",
    "medical_conditions": ["string"],
    "current_medications": ["string"],
    "allergies": ["string"],
    "last_updated": "ISO 8601"
  }
}
```

#### PUT `/api/v1/donor/profile`
```json
{
  "first_name": "string",
  "last_name": "string",
  "phone": "string",
  "address": "string",
  "city": "string",
  "emergency_contact_name": "string",
  "emergency_contact_phone": "string",
  "medical_conditions": ["string"],
  "current_medications": ["string"],
  "allergies": ["string"]
}
```

#### GET `/api/v1/donor/health-history`
```json
{
  "success": true,
  "data": {
    "blood_type": "string",
    "weight_kg": "float",
    "hemoglobin_level": "float",
    "blood_pressure": "string",
    "last_health_check": "ISO 8601",
    "health_check_status": "CLEARED|DEFERRED|NEEDS_REVIEW",
    "medical_conditions": ["string"],
    "medications": ["string"],
    "allergies": ["string"],
    "dietary_restrictions": ["string"]
  }
}
```

---

## 7. Request Details Screen

**File:** `lib/presentation/role/donor/tabs/request_screen/request_screen.dart`

**Features:**
- Emergency request details
- Hospital information
- Blood type needed
- Map view
- Accept/Decline buttons

### Backend Endpoints Required:

#### GET `/api/v1/urgent-requests/{request_id}`
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "hospital_id": "uuid",
    "hospital_name": "string",
    "blood_type_needed": "string",
    "units_needed": "integer",
    "urgency": "CRITICAL|HIGH|MEDIUM",
    "patient_type": "string",
    "contact_number": "string",
    "hospital_address": "string",
    "hospital_location": {
      "latitude": "float",
      "longitude": "float"
    },
    "distance_from_donor_km": "float",
    "created_at": "ISO 8601",
    "estimated_response_needed_by": "ISO 8601"
  }
}
```

#### POST `/api/v1/urgent-requests/{request_id}/accept`
```json
{
  "estimated_arrival_time": "ISO 8601"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "response_id": "uuid",
    "confirmation_code": "string",
    "status": "ACCEPTED",
    "hospital_contact": "string",
    "directions_url": "string",
    "points_available": "integer"
  }
}
```

#### POST `/api/v1/urgent-requests/{request_id}/decline`
```json
{
  "reason": "string (optional)"
}
```

---

## 8. Donor Notifications Screen

**File:** `lib/presentation/role/donor/tabs/notifications/notifications.dart`

**Features:**
- Push notifications display
- Mark as read
- Notification types (donation request, reward, badge, etc.)

### Backend Endpoints Required:

#### GET `/api/v1/donor/notifications`
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "notification_id": "uuid",
        "type": "DONATION_REQUEST|BADGE_EARNED|REWARD_AVAILABLE|APPOINTMENT_REMINDER|URGENT_REQUEST",
        "title": "string",
        "message": "string",
        "read": "boolean",
        "action_url": "string (nullable)",
        "created_at": "ISO 8601"
      }
    ],
    "unread_count": "integer"
  }
}
```

#### PUT `/api/v1/donor/notifications/{notification_id}/mark-read`

#### PUT `/api/v1/donor/notifications/mark-all-read`

---

## 9. Two-Factor Authentication Screen

**File:** `lib/presentation/role/donor/tabs/profile/two_factor_authentication/`

**Features:**
- Enable/disable 2FA
- OTP verification
- Backup codes

### Backend Endpoints Required:

#### POST `/api/v1/auth/2fa/setup`
```json
{}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "qr_code": "data:image/png;base64,...",
    "secret": "string",
    "backup_codes": ["string"]
  }
}
```

#### POST `/api/v1/auth/2fa/verify`
```json
{
  "otp": "string"
}
```

#### POST `/api/v1/auth/2fa/disable`
```json
{
  "password": "string"
}
```

---

## 10. Help & Support Screen

**File:** `lib/presentation/role/donor/tabs/profile/help_and_support/`

**Features:**
- FAQ display
- Document PDF viewer
- Support contact
- Donation guidelines

### Backend Endpoints Required:

#### GET `/api/v1/help/faq`
```json
{
  "success": true,
  "data": {
    "faqs": [
      {
        "category": "DONATION|HEALTH|REWARDS|TECHNICAL",
        "question": "string",
        "answer": "string"
      }
    ]
  }
}
```

#### GET `/api/v1/help/documents/{doc_type}`
```json
{
  "success": true,
  "data": {
    "document_url": "string (PDF URL)",
    "title": "string",
    "version": "string",
    "updated_at": "ISO 8601"
  }
}
```

#### POST `/api/v1/support/contact`
```json
{
  "subject": "string",
  "message": "string",
  "attachment_urls": ["string (optional)"]
}
```

---

# HOSPITAL ROLE SCREENS

## 11. Hospital Main Layout (Tab Navigation)

**File:** `lib/presentation/role/hospital/tabs/hospital_main_layout.dart`

**Tabs:**
1. Home
2. Requests
3. Staff
4. Reports
5. Profile

---

## 12. Hospital Home Screen

**File:** `lib/presentation/role/hospital/tabs/home/home.dart`

**Features:**
- Blood inventory display
- Urgent requests pending
- Staff availability
- Key metrics

### Backend Endpoints Required:

#### GET `/api/v1/hospital/dashboard`
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "hospital_name": "string",
    "current_blood_inventory": {
      "O_positive": {
        "units": "integer",
        "status": "CRITICAL|LOW|ADEQUATE|EXCESS",
        "last_updated": "ISO 8601"
      },
      "O_negative": {},
      "A_positive": {},
      "A_negative": {},
      "B_positive": {},
      "B_negative": {},
      "AB_positive": {},
      "AB_negative": {}
    },
    "pending_requests": {
      "total": "integer",
      "critical": "integer",
      "urgent": "integer"
    },
    "recent_donations": {
      "today": "integer",
      "this_week": "integer",
      "this_month": "integer"
    },
    "staff_availability": {
      "phlebotomists": "integer",
      "nurses": "integer",
      "doctors": "integer"
    }
  }
}
```

---

## 13. Hospital Requests Screen

**File:** `lib/presentation/role/hospital/tabs/request/request.dart`

**Features:**
- Create emergency requests
- Request history
- Donor responses
- Request status tracking

### Backend Endpoints Required:

#### POST `/api/v1/hospital/requests/create-emergency`
```json
{
  "blood_type": "string",
  "units_needed": "integer",
  "patient_type": "string",
  "urgency": "CRITICAL|HIGH|MEDIUM",
  "notes": "string (optional)"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "request_code": "string",
    "status": "ACTIVE|PARTIALLY_FULFILLED|FULFILLED|CANCELLED",
    "blood_type": "string",
    "units_needed": "integer",
    "broadcast_sent": "boolean",
    "donors_notified": "integer"
  }
}
```

#### GET `/api/v1/hospital/requests`
```json
{
  "success": true,
  "data": {
    "requests": [
      {
        "request_id": "uuid",
        "blood_type": "string",
        "units_needed": "integer",
        "units_received": "integer",
        "status": "ACTIVE|FULFILLED|CANCELLED",
        "urgency": "CRITICAL|HIGH|MEDIUM",
        "responses_count": "integer",
        "created_at": "ISO 8601"
      }
    ]
  }
}
```

#### GET `/api/v1/hospital/requests/{request_id}/responses`
```json
{
  "success": true,
  "data": {
    "responses": [
      {
        "response_id": "uuid",
        "donor_id": "uuid",
        "donor_name": "string",
        "blood_type": "string",
        "response_time": "ISO 8601",
        "status": "ACCEPTED|REJECTED|PENDING|ARRIVED|COMPLETED",
        "estimated_arrival": "ISO 8601"
      }
    ]
  }
}
```

#### POST `/api/v1/hospital/requests/{request_id}/close`
```json
{
  "total_units_received": "float",
  "notes": "string (optional)"
}
```

---

## 14. Hospital Staff Management Screen

**File:** `lib/presentation/role/hospital/tabs/staff/` (if exists)

**Features:**
- Staff roster
- Availability scheduling
- Staff performance metrics

### Backend Endpoints Required:

#### GET `/api/v1/hospital/staff`
```json
{
  "success": true,
  "data": {
    "staff": [
      {
        "staff_id": "uuid",
        "name": "string",
        "position": "PHLEBOTOMIST|NURSE|DOCTOR",
        "status": "AVAILABLE|ON_DUTY|OFF_DUTY|ON_LEAVE",
        "phone": "string",
        "shift_start": "HH:MM",
        "shift_end": "HH:MM"
      }
    ]
  }
}
```

---

## 15. Hospital Reports Screen

**File:** `lib/presentation/role/hospital/tabs/reports/` (if exists)

**Features:**
- Monthly blood inventory reports
- Donation statistics
- Emergency response metrics

### Backend Endpoints Required:

#### GET `/api/v1/hospital/reports/monthly`
```json
{
  "success": true,
  "data": {
    "month": "YYYY-MM",
    "total_donations": "integer",
    "total_units_received": "float",
    "blood_type_breakdown": {
      "O_positive": "integer",
      "O_negative": "integer"
    },
    "emergency_requests": "integer",
    "emergency_fulfilled_rate": "float",
    "average_response_time_minutes": "integer"
  }
}
```

---

## 16. Hospital Profile Screen

**File:** `lib/presentation/role/hospital/tabs/profile/profile.dart`

**Features:**
- Hospital information
- Blood bank settings
- Notification preferences
- Security settings

### Backend Endpoints Required:

#### GET `/api/v1/hospital/profile`
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "name": "string",
    "address": "string",
    "phone": "string",
    "email": "string",
    "website": "string",
    "blood_bank_manager": "string",
    "blood_bank_manager_phone": "string",
    "emergency_contact": "string",
    "operating_hours": "string",
    "blood_bank_hours": "string"
  }
}
```

#### PUT `/api/v1/hospital/profile`
```json
{
  "phone": "string",
  "email": "string",
  "blood_bank_manager": "string",
  "blood_bank_manager_phone": "string",
  "operating_hours": "string",
  "blood_bank_hours": "string"
}
```

#### PUT `/api/v1/hospital/blood-bank-settings`
```json
{
  "critical_threshold": {
    "O_positive": "integer",
    "O_negative": "integer"
  },
  "low_threshold": {
    "O_positive": "integer",
    "O_negative": "integer"
  },
  "automatic_notifications": "boolean",
  "notification_email": "string"
}
```

#### GET `/api/v1/hospital/notification-preferences`

#### PUT `/api/v1/hospital/notification-preferences`

---

# ADMIN ROLE SCREENS

## 17. Admin Main Layout (Tab Navigation)

**File:** `lib/presentation/role/admin/tabs/admin_main_layout.dart`

**Tabs:**
1. Dashboard
2. Users (Donors/Hospitals)
3. System Settings
4. Analytics (optional)

---

## 18. Admin Dashboard Screen

**File:** `lib/presentation/role/admin/tabs/dashboard/dashboard.dart`

**Features:**
- Key metrics (donors, hospitals, donations)
- Blood inventory across all hospitals
- Emergency response metrics
- Top donors leaderboard
- Critical alerts
- Weekly trends chart
- AI insights

### Backend Endpoints Required:

#### GET `/api/v1/admin/dashboard`
```json
{
  "success": true,
  "data": {
    "total_donors": "integer",
    "total_hospitals": "integer",
    "active_donors": "integer",
    "total_donations_lifetime": "integer",
    "donations_this_month": "integer",
    "critical_alerts": [
      {
        "alert_id": "uuid",
        "type": "LOW_BLOOD_TYPE|HOSPITAL_OFFLINE|HIGH_EMERGENCY_RATE",
        "severity": "CRITICAL|HIGH|MEDIUM",
        "message": "string",
        "hospital_id": "uuid (nullable)",
        "created_at": "ISO 8601"
      }
    ],
    "blood_inventory_summary": {
      "O_positive": {
        "total_units": "integer",
        "critical_hospitals": "integer"
      }
    },
    "top_donors": [
      {
        "donor_id": "uuid",
        "name": "string",
        "donation_count": "integer",
        "total_units": "float"
      }
    ],
    "weekly_stats": {
      "donations_by_date": {
        "2024-04-22": "integer",
        "2024-04-23": "integer"
      },
      "emergency_requests_by_date": {}
    }
  }
}
```

#### GET `/api/v1/admin/blood-inventory-summary`
```json
{
  "success": true,
  "data": {
    "blood_types": {
      "O_positive": {
        "total_units": "integer",
        "hospitals_critical": ["hospital_id"],
        "hospitals_low": ["hospital_id"],
        "hospitals_adequate": ["hospital_id"]
      }
    }
  }
}
```

#### GET `/api/v1/admin/alerts`
```json
{
  "success": true,
  "data": {
    "alerts": [
      {
        "alert_id": "uuid",
        "type": "string",
        "severity": "CRITICAL|HIGH|MEDIUM|LOW",
        "message": "string",
        "entity_type": "HOSPITAL|DONOR|SYSTEM",
        "entity_id": "uuid",
        "created_at": "ISO 8601",
        "resolved": "boolean"
      }
    ]
  }
}
```

---

## 19. Admin Users Management Screen

**File:** `lib/presentation/role/admin/tabs/users/users.dart`

**Features:**
- Donor list with filters
- Hospital list
- User details dialog
- Edit user dialog
- Add new hospital/admin dialog
- User statistics

### Backend Endpoints Required:

#### GET `/api/v1/admin/donors`
```json
{
  "success": true,
  "data": {
    "donors": [
      {
        "donor_id": "uuid",
        "name": "string",
        "email": "string",
        "phone": "string",
        "blood_type": "string",
        "status": "ACTIVE|INACTIVE|DEFERRED|SUSPENDED",
        "donation_count": "integer",
        "last_donation": "ISO 8601",
        "total_donated": "float",
        "points": "integer",
        "joined_date": "ISO 8601"
      }
    ],
    "pagination": {
      "current_page": "integer",
      "total_pages": "integer",
      "total_items": "integer"
    }
  }
}
```

**Query Parameters:**
- `page`: integer
- `limit`: integer
- `status`: enum
- `search`: string
- `blood_type`: string
- `sort_by`: DONATIONS|NAME|DATE

#### GET `/api/v1/admin/donors/{donor_id}`
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "full_name": "string",
    "email": "string",
    "phone": "string",
    "blood_type": "string",
    "date_of_birth": "YYYY-MM-DD",
    "address": "string",
    "status": "ACTIVE|INACTIVE|DEFERRED|SUSPENDED",
    "joined_date": "ISO 8601",
    "last_donation_date": "ISO 8601",
    "donation_history": {
      "total_count": "integer",
      "total_units": "float",
      "last_5_donations": []
    },
    "points_balance": "integer",
    "health_status": "CLEARED|DEFERRED|NEEDS_CHECKUP"
  }
}
```

#### PUT `/api/v1/admin/donors/{donor_id}`
```json
{
  "status": "ACTIVE|INACTIVE|DEFERRED|SUSPENDED",
  "notes": "string (optional)"
}
```

#### GET `/api/v1/admin/hospitals`
```json
{
  "success": true,
  "data": {
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "string",
        "address": "string",
        "phone": "string",
        "email": "string",
        "status": "ACTIVE|INACTIVE|MAINTENANCE",
        "blood_bank_manager": "string",
        "total_requests": "integer",
        "emergency_responses_received": "integer",
        "joined_date": "ISO 8601"
      }
    ]
  }
}
```

#### GET `/api/v1/admin/hospitals/{hospital_id}`
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "name": "string",
    "full_address": "string",
    "phone": "string",
    "email": "string",
    "website": "string",
    "status": "ACTIVE|INACTIVE|MAINTENANCE",
    "blood_bank_manager": "string",
    "blood_bank_manager_phone": "string",
    "operating_hours": "string",
    "blood_bank_hours": "string",
    "location": {
      "latitude": "float",
      "longitude": "float"
    },
    "stats": {
      "total_emergency_requests": "integer",
      "fulfilled_requests": "integer",
      "average_response_time": "integer"
    }
  }
}
```

#### PUT `/api/v1/admin/hospitals/{hospital_id}`
```json
{
  "status": "ACTIVE|INACTIVE|MAINTENANCE",
  "phone": "string",
  "email": "string",
  "blood_bank_manager": "string",
  "blood_bank_manager_phone": "string"
}
```

#### POST `/api/v1/admin/hospitals`
```json
{
  "name": "string",
  "address": "string",
  "phone": "string",
  "email": "string",
  "blood_bank_manager": "string",
  "blood_bank_manager_phone": "string",
  "operating_hours": "string",
  "blood_bank_hours": "string",
  "location": {
    "latitude": "float",
    "longitude": "float"
  }
}
```

#### POST `/api/v1/admin/admins`
```json
{
  "first_name": "string",
  "last_name": "string",
  "email": "string",
  "phone": "string",
  "role": "SUPER_ADMIN|ADMIN|MODERATOR",
  "permissions": ["string"]
}
```

---

## 20. Admin System Settings Screen

**File:** `lib/presentation/role/admin/tabs/system_settings/system_settings.dart`

**Features:**
- System health check
- Maintenance mode
- Admin user management
- Audit logs
- Role-based permissions
- System status

### Backend Endpoints Required:

#### GET `/api/v1/admin/system-health`
```json
{
  "success": true,
  "data": {
    "status": "HEALTHY|DEGRADED|CRITICAL",
    "last_check": "ISO 8601",
    "components": {
      "database": "OPERATIONAL|DEGRADED|OFFLINE",
      "notifications": "OPERATIONAL|DEGRADED|OFFLINE",
      "file_storage": "OPERATIONAL|DEGRADED|OFFLINE",
      "email_service": "OPERATIONAL|DEGRADED|OFFLINE"
    },
    "uptime_percentage": "float"
  }
}
```

#### POST `/api/v1/admin/system-health/check`
```json
{}
```

#### POST `/api/v1/admin/maintenance-mode`
```json
{
  "enabled": "boolean",
  "duration_minutes": "integer",
  "message": "string"
}
```

#### GET `/api/v1/admin/maintenance-mode/status`

#### GET `/api/v1/admin/admins`
```json
{
  "success": true,
  "data": {
    "admins": [
      {
        "admin_id": "uuid",
        "name": "string",
        "email": "string",
        "phone": "string",
        "role": "SUPER_ADMIN|ADMIN|MODERATOR",
        "status": "ACTIVE|INACTIVE",
        "created_at": "ISO 8601",
        "last_login": "ISO 8601"
      }
    ]
  }
}
```

#### GET `/api/v1/admin/admins/{admin_id}`

#### PUT `/api/v1/admin/admins/{admin_id}`
```json
{
  "status": "ACTIVE|INACTIVE",
  "role": "SUPER_ADMIN|ADMIN|MODERATOR",
  "permissions": ["string"]
}
```

#### DELETE `/api/v1/admin/admins/{admin_id}`

#### GET `/api/v1/admin/audit-logs`
```json
{
  "success": true,
  "data": {
    "logs": [
      {
        "log_id": "uuid",
        "admin_id": "uuid",
        "admin_name": "string",
        "action": "USER_CREATED|USER_DELETED|USER_UPDATED|HOSPITAL_CREATED|SYSTEM_CONFIGURED",
        "entity_type": "USER|HOSPITAL|SYSTEM",
        "entity_id": "uuid",
        "details": "object",
        "timestamp": "ISO 8601"
      }
    ],
    "pagination": {
      "current_page": "integer",
      "total_pages": "integer"
    }
  }
}
```

#### GET `/api/v1/admin/permissions/roles`
```json
{
  "success": true,
  "data": {
    "roles": {
      "SUPER_ADMIN": ["permission_1", "permission_2"],
      "ADMIN": ["permission_3", "permission_4"],
      "MODERATOR": ["permission_5"]
    }
  }
}
```

#### PUT `/api/v1/admin/permissions/roles/{role}`
```json
{
  "permissions": ["string"]
}
```

---

# AUTHENTICATION & ONBOARDING SCREENS

## 21. Splash Screen

**File:** `lib/presentation/splash_screen/splash_screen.dart`

**Features:**
- App logo
- Auto-navigate to appropriate screen
- Token validation

### Backend Endpoints Required:

#### POST `/api/v1/auth/validate-token`
```json
{}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "is_valid": "boolean",
    "user_role": "DONOR|HOSPITAL|ADMIN",
    "user_id": "uuid"
  }
}
```

---

## 22. Onboarding Screen

**File:** `lib/presentation/onboarding/`

**Features:**
- Welcome slides
- App features explanation
- Terms & conditions

### Backend Endpoints Required:

#### POST `/api/v1/onboarding/complete`
```json
{
  "user_id": "uuid",
  "agreed_to_terms": "boolean"
}
```

---

## 23. Choose Role Screen

**File:** `lib/presentation/choose_role/`

**Features:**
- Select between Donor/Hospital/Admin
- Redirect to appropriate login

### Backend Endpoints Required:

None (UI-only)

---

## 24. Authentication Screens

**File:** `lib/presentation/authentication/`

**Features:**
- Login (email/phone)
- Password reset
- Registration
- OTP verification
- Pin verification

### Backend Endpoints Required:

#### POST `/api/v1/auth/login`
```json
{
  "email_or_phone": "string",
  "password": "string",
  "role": "DONOR|HOSPITAL|ADMIN"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "access_token": "string",
    "refresh_token": "string",
    "user_id": "uuid",
    "user_role": "DONOR|HOSPITAL|ADMIN",
    "user_name": "string",
    "expires_in": "integer (seconds)"
  }
}
```

#### POST `/api/v1/auth/register`
```json
{
  "first_name": "string",
  "last_name": "string",
  "email": "string",
  "phone": "string",
  "password": "string",
  "role": "DONOR|HOSPITAL",
  "blood_type": "string (for donors only)",
  "agreed_to_terms": "boolean"
}
```

#### POST `/api/v1/auth/send-otp`
```json
{
  "email_or_phone": "string",
  "purpose": "LOGIN|REGISTRATION|PASSWORD_RESET"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "otp_session_id": "string",
    "expires_in_seconds": "integer"
  }
}
```

#### POST `/api/v1/auth/verify-otp`
```json
{
  "otp_session_id": "string",
  "otp_code": "string"
}
```

#### POST `/api/v1/auth/password-reset`
```json
{
  "email": "string"
}
```

#### POST `/api/v1/auth/reset-password`
```json
{
  "reset_token": "string",
  "new_password": "string"
}
```

#### POST `/api/v1/auth/logout`
```json
{}
```

#### POST `/api/v1/auth/refresh-token`
```json
{
  "refresh_token": "string"
}
```

---

# SHARED/CROSS-ROLE SCREENS

## 25. Map Screen

**File:** `lib/presentation/maps/`

**Features:**
- Hospital location map
- Distance calculation
- Navigation integration

### Backend Endpoints Required:

#### GET `/api/v1/hospitals/nearby`
```json
{
  "success": true,
  "data": {
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "string",
        "location": {
          "latitude": "float",
          "longitude": "float"
        },
        "distance_km": "float",
        "urgency_level": "LOW|MEDIUM|HIGH|CRITICAL"
      }
    ]
  }
}
```

**Query Parameters:**
- `latitude`: float
- `longitude`: float
- `radius_km`: float (default: 10)

---

# API INTEGRATION SUMMARY

## Authentication Flow

```
1. POST /api/v1/auth/login (or /register)
   ↓
2. Receive access_token, refresh_token
   ↓
3. Store tokens locally
   ↓
4. Use Authorization: Bearer {token} in all requests
   ↓
5. On 401 response → POST /api/v1/auth/refresh-token
   ↓
6. On logout → POST /api/v1/auth/logout
```

## Common Request Headers

```http
Authorization: Bearer {access_token}
Content-Type: application/json
Accept-Language: en|ar (for localization)
User-Agent: BloodDonationApp/1.0
X-Device-Id: {device_uuid}
```

## Standard Response Format

All endpoints should follow:

```json
{
  "success": true|false,
  "data": { /* endpoint-specific data */ },
  "error": { /* if success=false */
    "code": "ERROR_CODE",
    "message": "Human-readable message",
    "details": { /* additional context */ }
  },
  "pagination": { /* if applicable */
    "current_page": 1,
    "total_pages": 5,
    "total_items": 100,
    "per_page": 20
  },
  "timestamp": "ISO 8601"
}
```

---

# DATABASE REQUIREMENTS SUMMARY

## Core Tables Required

### User Management
- `users` - Base user info
- `donors` - Donor-specific info
- `hospitals` - Hospital-specific info
- `admins` - Admin-specific info
- `user_addresses` - Address history
- `user_health_data` - Health information

### Authentication
- `auth_tokens` - Active tokens
- `refresh_tokens` - Refresh token storage
- `password_reset_tokens` - Reset token tracking
- `two_factor_settings` - 2FA configuration
- `audit_logs` - Admin action logs

### Blood Donation
- `donations` - Donation records
- `appointment_schedules` - Booking slots
- `blood_inventory` - Hospital blood stock
- `blood_type_requirements` - Hospital needs
- `emergency_requests` - Urgent blood requests
- `emergency_responses` - Donor responses to requests

### Rewards System
- `user_points_accounts` - Points balance
- `points_transactions` - Points history
- `rewards_catalog` - Available rewards
- `reward_redemptions` - User redemptions
- `badge_definitions` - Badge specs
- `user_badges` - User badge progress

### Notifications
- `notifications` - User notifications
- `notification_preferences` - User settings
- `notification_logs` - Notification sent history

### System
- `system_health_checks` - Health monitoring
- `maintenance_events` - Maintenance tracking
- `system_configurations` - Config settings

---

## Database Indexes Priority

**High Priority (Create First):**
- `users(email)` - Unique
- `users(phone)` - Unique
- `users(user_role)`
- `donations(donor_id, created_at)`
- `emergency_requests(hospital_id, status)`
- `blood_inventory(hospital_id, blood_type)`
- `notifications(user_id, read, created_at)`

**Medium Priority:**
- `points_transactions(user_id, created_at)`
- `user_badges(user_id, badge_id)`
- `reward_redemptions(user_id, created_at)`
- `emergency_responses(request_id, status)`

---

## Estimated Database Size

For 100K donors, 50 hospitals, 1 year of data:

- `donations` table: ~2-3 million rows
- `points_transactions` table: ~5-10 million rows
- `notifications` table: ~50-100 million rows
- `emergency_requests` table: ~500K rows
- Total estimated size: ~5-10 GB

**Recommendation:** Implement archival strategy for old transactions (> 2 years)

---

## Data Retention Policy

| Data Type | Retention Period | Archive | Notes |
|-----------|------------------|---------|-------|
| Donations | Forever | After 2 years | Critical for analytics |
| Points Transactions | Forever | After 2 years | Audit trail |
| Notifications | 90 days | Delete | Can be cleared |
| Audit Logs | 1 year | Archive | Compliance requirement |
| Emergency Requests | 1 year | Archive | For statistics |
| Health Data | 5 years | Archive | Medical requirement |

---

## Performance Optimization Strategies

1. **Caching:**
   - User profile: 1 hour TTL
   - Hospital list: 1 hour TTL
   - Rewards catalog: 24 hour TTL
   - User points: 5 minute TTL

2. **Database:**
   - Use connection pooling (min: 10, max: 50)
   - Implement read replicas for reporting
   - Archive old transactions monthly
   - Analyze query plans monthly

3. **API:**
   - Implement pagination for all list endpoints
   - Use GraphQL for complex queries (future)
   - Implement request caching headers
   - Add CDN for static content

---

## Security Checklist

- [ ] All endpoints require authentication (except login/register)
- [ ] Role-based access control (RBAC) implemented
- [ ] Input validation on all endpoints
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS protection headers enabled
- [ ] CORS properly configured
- [ ] Rate limiting implemented (100-1000 req/hour)
- [ ] Logging and monitoring in place
- [ ] Encryption for sensitive data (email, phone, health)
- [ ] HTTPS enforced
- [ ] JWT token expiration (15-30 min access, 7 day refresh)

---

**Document Approved By:**
- [ ] Backend Lead
- [ ] Architecture Lead
- [ ] Security Lead
- [ ] Product Manager

**Last Updated:** April 26, 2026

