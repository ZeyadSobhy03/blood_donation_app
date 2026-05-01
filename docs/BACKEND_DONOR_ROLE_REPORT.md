# Backend API Requirements Report
## Donor Role Features

**Report Date:** April 29, 2026  
**Target Audience:** Backend Development Team  
**Priority:** High (Donor is the primary user role)

---

## 📊 PART 1: DONOR DASHBOARD & OVERVIEW

### Current Frontend Status
Donor screens exist in the Flutter app but require backend support for:
- Dashboard statistics
- Donation history
- Rewards tracking
- Emergency request notifications
- Appointment management

### Dashboard Requirements

#### Endpoint 1: Get Donor Dashboard

```http
GET /api/v1/donor/dashboard
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "dashboard_id": "uuid",
    "donor_id": "uuid",
    "donor_name": "Ahmed Ali",
    "timestamp": "2026-04-29T15:22:00Z",
    "summary": {
      "total_donations": 15,
      "donations_this_month": 2,
      "donations_this_year": 12,
      "total_points": 750,
      "points_this_month": 100,
      "badges_earned": 5,
      "upcoming_appointments": 1,
      "eligible_to_donate": true,
      "days_until_next_eligible": 0
    },
    "health_status": {
      "status": "eligible",
      "last_donation": "2026-04-20",
      "next_eligible_date": "2026-05-04",
      "blood_type": "O+",
      "weight_kg": 75,
      "health_conditions": []
    },
    "recent_donations": [
      {
        "donation_id": "uuid",
        "hospital_name": "Hospital A",
        "donation_date": "2026-04-20T14:30:00Z",
        "blood_type_donated": "O+",
        "units_donated": 1,
        "status": "completed",
        "points_awarded": 50,
        "staff_feedback": "Great donation experience"
      }
    ],
    "rewards": {
      "total_points": 750,
      "redeemed_points": 0,
      "available_points": 750,
      "points_expiring_soon": 0,
      "badges_count": 5,
      "badges": [
        {
          "badge_id": "uuid",
          "badge_name": "Generous Donor",
          "badge_icon": "https://...",
          "description": "Donated 10 times",
          "earned_at": "2026-02-15T10:00:00Z"
        }
      ]
    },
    "urgent_requests": [
      {
        "request_id": "uuid",
        "hospital_name": "Hospital A",
        "blood_type": "O+",
        "units_needed": 3,
        "urgency_level": "critical",
        "patient_condition": "Trauma",
        "distance_km": 2.5,
        "estimated_time_minutes": 8,
        "request_code": "REQ-2026-04-29-001",
        "created_at": "2026-04-29T15:00:00Z"
      }
    ],
    "activities": {
      "donations_this_week": 1,
      "appointments_this_week": 0,
      "notifications_unread": 3,
      "achievements_this_month": 2
    }
  }
}
```

---

## 👤 PART 2: DONOR PROFILE MANAGEMENT

### A. PROFILE OPERATIONS

#### Endpoint 1: Get Donor Profile

```http
GET /api/v1/donor/profile
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "personal_info": {
      "full_name": "Ahmed Ali",
      "email": "ahmed@email.com",
      "phone": "+92-300-1234567",
      "date_of_birth": "1990-05-15",
      "age": 35,
      "gender": "Male",
      "address": "Street, City, Country",
      "profile_picture": "https://...",
      "created_at": "2025-01-15T10:00:00Z"
    },
    "medical_info": {
      "blood_type": "O+",
      "rh_factor": "+",
      "weight_kg": 75,
      "height_cm": 180,
      "health_conditions": [],
      "medications": [],
      "allergies": [],
      "last_blood_test": "2026-01-15"
    },
    "donation_info": {
      "total_donations": 15,
      "successful_donations": 14,
      "failed_donations": 1,
      "total_units_donated": 14,
      "first_donation_date": "2024-06-10",
      "last_donation_date": "2026-04-20"
    },
    "account_status": {
      "status": "active",
      "verified": true,
      "verified_at": "2025-01-16T10:00:00Z",
      "suspended": false,
      "banned": false
    },
    "notification_preferences": {
      "email_notifications": true,
      "sms_notifications": true,
      "push_notifications": true,
      "emergency_request_alerts": true,
      "reward_updates": true,
      "appointment_reminders": true
    }
  }
}
```

---

#### Endpoint 2: Update Donor Profile

```http
PUT /api/v1/donor/profile
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "full_name": "Ahmed Ali Khan",
  "phone": "+92-300-9876543",
  "address": "New Street, City, Country",
  "gender": "Male",
  "weight_kg": 76,
  "health_conditions": [],
  "medications": [],
  "allergies": []
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "message": "Profile updated successfully",
    "updated_fields": ["phone", "address", "weight_kg"],
    "updated_at": "2026-04-29T15:22:00Z"
  }
}
```

---

#### Endpoint 3: Update Profile Picture

```http
POST /api/v1/donor/profile/picture
Authorization: Bearer {donor_token}
Content-Type: multipart/form-data

Body:
{
  "picture": <file>
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "profile_picture_url": "https://...",
    "message": "Profile picture updated successfully"
  }
}
```

---

#### Endpoint 4: Get Donor Health History

```http
GET /api/v1/donor/health-history
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "blood_type": "O+",
    "weight_kg": 75,
    "height_cm": 180,
    "bmi": 23.1,
    "health_conditions": [],
    "medications": [],
    "allergies": [],
    "medical_history": [
      {
        "entry_id": "uuid",
        "condition": "Cold",
        "date": "2026-03-15",
        "status": "recovered"
      }
    ],
    "blood_test_history": [
      {
        "test_id": "uuid",
        "test_date": "2026-01-15",
        "hemoglobin_level": 14.5,
        "platelet_count": 250,
        "results": "normal"
      }
    ],
    "eligibility_status": "eligible"
  }
}
```

---

## 🩸 PART 3: DONATION HISTORY & ELIGIBILITY

### A. DONATION MANAGEMENT

#### Endpoint 1: Get Donation History

```http
GET /api/v1/donor/donations
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- status: string (completed|pending|cancelled|failed)
- sort_by: string (donation_date|points_awarded)
- sort_order: asc|desc
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donations": [
      {
        "donation_id": "uuid",
        "hospital_id": "uuid",
        "hospital_name": "Hospital A",
        "donation_date": "2026-04-20T14:30:00Z",
        "blood_type_donated": "O+",
        "units_donated": 1,
        "status": "completed",
        "points_awarded": 50,
        "experience_rating": 4.8,
        "feedback": "Great donation experience",
        "staff_notes": "Smooth process",
        "appointment_id": "uuid",
        "completion_time_minutes": 45
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 1,
      "total_items": 15,
      "items_per_page": 20
    },
    "summary": {
      "total_donations": 15,
      "successful_donations": 14,
      "failed_donations": 1,
      "total_units_donated": 14,
      "total_points_earned": 750
    }
  }
}
```

---

#### Endpoint 2: Get Donation Eligibility

```http
GET /api/v1/donor/donation-eligibility
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "is_eligible": true,
    "eligibility_status": "eligible",
    "last_donation_date": "2026-04-20T14:30:00Z",
    "next_eligible_date": "2026-05-04T14:30:00Z",
    "days_until_eligible": 5,
    "blood_type": "O+",
    "weight_kg": 75,
    "health_status": "healthy",
    "restrictions": [],
    "eligibility_checks": {
      "weight_check": {"passed": true, "requirement": "> 50 kg"},
      "time_check": {"passed": true, "days_since_last": 9},
      "health_check": {"passed": true, "conditions": []},
      "medication_check": {"passed": true, "medications": []},
      "blood_test_check": {"passed": true, "last_test": "2026-01-15"}
    },
    "ineligibility_reasons": []
  }
}
```

---

#### Endpoint 3: Get Nearby Hospitals

```http
GET /api/v1/hospitals/nearby
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- latitude: float (required)
- longitude: float (required)
- radius_km: float (default: 5)
- blood_type: string (optional)
- sort_by: string (distance|rating|availability) (default: distance)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user_location": {
      "latitude": 24.8607,
      "longitude": 67.0011
    },
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "Hospital A",
        "latitude": 24.8615,
        "longitude": 67.0031,
        "distance_km": 0.5,
        "duration_minutes": 2,
        "address": "Street, City",
        "phone": "+92-21-123456",
        "email": "blood@hospitala.com",
        "rating": 4.8,
        "total_reviews": 156,
        "blood_available": {
          "O+": 150,
          "O-": 80,
          "A+": 95
        },
        "blood_urgency": {
          "O+": "normal",
          "O-": "low",
          "A+": "critical"
        },
        "is_accepting_appointments": true,
        "available_slots_today": 5,
        "available_slots_week": 25,
        "appointment_waiting_time_minutes": 15,
        "is_emergency_accepting": true,
        "operating_hours": "09:00-18:00",
        "features": ["Emergency", "24/7", "Online Booking"]
      }
    ]
  }
}
```

---

## 📅 PART 4: APPOINTMENT MANAGEMENT

### A. APPOINTMENT OPERATIONS

#### Endpoint 1: Get My Appointments

```http
GET /api/v1/donations/my-appointments
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- status: string (confirmed|completed|cancelled|pending)
- start_date: date (YYYY-MM-DD)
- end_date: date (YYYY-MM-DD)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointments": [
      {
        "appointment_id": "uuid",
        "hospital_id": "uuid",
        "hospital_name": "Hospital A",
        "hospital_phone": "+92-21-123456",
        "appointment_date": "2026-05-05",
        "appointment_time": "10:00-10:30",
        "time_slot": "10:00-10:30",
        "blood_type": "O+",
        "status": "confirmed",
        "confirmation_code": "APPT-2026-05-05-001",
        "days_until_appointment": 6,
        "can_cancel": true,
        "can_reschedule": true,
        "instructions": [
          "Bring valid ID",
          "Come 10 minutes early",
          "Avoid heavy meals 2 hours before"
        ],
        "reminder_sent": false,
        "created_at": "2026-04-29T15:00:00Z"
      }
    ],
    "summary": {
      "total_appointments": 1,
      "upcoming": 1,
      "completed": 14,
      "cancelled": 0,
      "no_show": 0
    }
  }
}
```

---

#### Endpoint 2: Book Donation Appointment

```http
POST /api/v1/donations/book-appointment
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "hospital_id": "uuid",
  "slot_id": "uuid",
  "blood_type": "O+",
  "notes": "Available after 5 PM (optional)",
  "contact_number": "+92-300-1234567"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "uuid",
    "donor_id": "uuid",
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "appointment_date": "2026-05-05",
    "appointment_time": "10:00-10:30",
    "blood_type": "O+",
    "status": "confirmed",
    "confirmation_code": "APPT-2026-05-05-001",
    "directions_url": "https://api.example.com/api/v1/maps/directions?...",
    "hospital_address": "Street, City, Country",
    "hospital_phone": "+92-21-123456",
    "instructions": [
      "Bring valid ID",
      "Come 10 minutes early",
      "Avoid heavy meals 2 hours before"
    ],
    "reminder_scheduled": true,
    "created_at": "2026-04-29T15:22:00Z",
    "appointment_at": "2026-05-05T10:00:00Z",
    "points_reward": 50
  }
}
```

---

#### Endpoint 3: Get Available Appointment Slots

```http
GET /api/v1/donations/book-appointment/slots
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- hospital_id: uuid (required)
- start_date: date (YYYY-MM-DD, required)
- end_date: date (YYYY-MM-DD, optional - default: 7 days)
- blood_type: string (required)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "blood_type": "O+",
    "available_slots": [
      {
        "slot_id": "uuid",
        "date": "2026-05-05",
        "time_slot": "10:00-10:30",
        "start_time": "10:00",
        "end_time": "10:30",
        "capacity": 5,
        "booked_count": 3,
        "available_seats": 2,
        "is_available": true
      }
    ]
  }
}
```

---

#### Endpoint 4: Cancel Appointment

```http
DELETE /api/v1/donations/book-appointment/{appointment_id}
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "reason": "Schedule conflict"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "uuid",
    "status": "cancelled",
    "cancelled_at": "2026-04-29T15:25:00Z",
    "refund_points": 50,
    "message": "Appointment cancelled. 50 points refunded."
  }
}
```

---

#### Endpoint 5: Reschedule Appointment

```http
PUT /api/v1/donations/book-appointment/{appointment_id}
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "slot_id": "new_uuid",
  "hospital_id": "uuid" (optional)
}
```

---

## 🎁 PART 5: REWARDS & POINTS SYSTEM

### A. POINTS MANAGEMENT

#### Endpoint 1: Get Donor Points

```http
GET /api/v1/donor/points
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "total_points": 750,
    "available_points": 750,
    "redeemed_points": 0,
    "points_this_month": 100,
    "points_expiring_soon": 0,
    "expiration_date": "2027-04-29",
    "points_history": [
      {
        "transaction_id": "uuid",
        "transaction_type": "donation|redemption|bonus|referral",
        "points": 50,
        "description": "Donation at Hospital A",
        "reference_id": "donation_uuid",
        "created_at": "2026-04-20T14:30:00Z"
      }
    ],
    "point_tiers": {
      "current_tier": "Silver",
      "tier_level": 2,
      "points_to_next_tier": 250,
      "tier_benefits": "Extra 10% bonus points on donations"
    }
  }
}
```

---

#### Endpoint 2: Get Available Rewards

```http
GET /api/v1/rewards
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- category: string (gift|discount|health|charity)
- sort_by: string (points_required|popularity|new)
- page: int (default: 1)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_points": 750,
    "rewards": [
      {
        "reward_id": "uuid",
        "reward_name": "Discount Voucher",
        "description": "50% off at selected pharmacies",
        "points_required": 200,
        "quantity_available": 50,
        "category": "discount",
        "expiry_date": "2026-12-31",
        "popularity_score": 4.8,
        "is_available": true,
        "can_redeem": true,
        "image_url": "https://...",
        "partners": ["Pharmacy A", "Pharmacy B"],
        "terms_conditions": "Valid for 30 days"
      },
      {
        "reward_id": "uuid",
        "reward_name": "Health Checkup Package",
        "description": "Free health checkup at partner hospital",
        "points_required": 500,
        "quantity_available": 25,
        "category": "health",
        "expiry_date": "2026-12-31",
        "popularity_score": 4.9,
        "is_available": true,
        "can_redeem": false,
        "reason_cannot_redeem": "Insufficient points",
        "image_url": "https://..."
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 87,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 3: Redeem Reward

```http
POST /api/v1/rewards/{reward_id}/redeem
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "quantity": 1,
  "delivery_address": "Street, City (optional)",
  "notes": "optional notes"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "redemption_id": "uuid",
    "reward_id": "uuid",
    "reward_name": "Discount Voucher",
    "points_deducted": 200,
    "remaining_points": 550,
    "voucher_code": "VOUCHER-2026-04-29-001",
    "expiry_date": "2026-05-29",
    "delivery_method": "sms|email|in_app",
    "status": "completed",
    "created_at": "2026-04-29T15:22:00Z",
    "instructions": "Show this voucher code at pharmacy"
  }
}
```

---

#### Endpoint 4: Get Donor Redemptions

```http
GET /api/v1/donor/redemptions
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- status: string (completed|pending|expired|used)
- page: int (default: 1)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "redemptions": [
      {
        "redemption_id": "uuid",
        "reward_name": "Discount Voucher",
        "voucher_code": "VOUCHER-2026-04-29-001",
        "points_spent": 200,
        "status": "completed",
        "redemption_date": "2026-04-29T15:22:00Z",
        "expiry_date": "2026-05-29",
        "used": false,
        "used_at": null
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 1,
      "total_items": 5,
      "items_per_page": 20
    }
  }
}
```

---

## 🏆 PART 6: BADGES & ACHIEVEMENTS

### A. BADGES SYSTEM

#### Endpoint 1: Get Donor Badges

```http
GET /api/v1/donor/badges
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "total_badges_earned": 5,
    "total_badges_available": 15,
    "earned_badges": [
      {
        "badge_id": "uuid",
        "badge_name": "First Time Donor",
        "badge_description": "Completed first donation",
        "badge_icon": "https://...",
        "badge_color": "#FF6B6B",
        "earned_at": "2024-06-10T10:00:00Z",
        "rarity": "common",
        "progress": 100
      },
      {
        "badge_id": "uuid",
        "badge_name": "Generous Donor",
        "badge_description": "Donated 10 times",
        "badge_icon": "https://...",
        "badge_color": "#4ECDC4",
        "earned_at": "2026-02-15T10:00:00Z",
        "rarity": "uncommon",
        "progress": 100
      }
    ],
    "progress_badges": [
      {
        "badge_id": "uuid",
        "badge_name": "Legend Donor",
        "badge_description": "Donate 50 times",
        "badge_icon": "https://...",
        "badge_color": "#FFD700",
        "rarity": "legendary",
        "progress": 15,
        "progress_percentage": 30,
        "remaining": 35
      }
    ]
  }
}
```

---

## 🚨 PART 7: EMERGENCY REQUEST RESPONSES

### A. EMERGENCY REQUESTS

#### Endpoint 1: Get Urgent Requests

```http
GET /api/v1/urgent-requests
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- blood_type: string (optional)
- urgency: string (critical|high|moderate)
- status: string (pending_response|accepted|declined|expired)
- page: int (default: 1)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_location": {
      "latitude": 24.8607,
      "longitude": 67.0011
    },
    "urgent_requests": [
      {
        "request_id": "uuid",
        "request_code": "REQ-2026-04-29-001",
        "hospital_id": "uuid",
        "hospital_name": "Hospital A",
        "blood_type": "O+",
        "units_needed": 3,
        "urgency_level": "critical",
        "status": "pending_response",
        "patient_condition": "Trauma",
        "distance_km": 2.5,
        "estimated_arrival_minutes": 8,
        "hospital_location": {
          "latitude": 24.8615,
          "longitude": 67.0031,
          "address": "Street, City"
        },
        "hospital_contact": "+92-21-123456",
        "contact_person": "Dr. Hassan",
        "estimated_needed_by": "2026-04-29T16:00:00Z",
        "time_remaining_minutes": 35,
        "created_at": "2026-04-29T15:00:00Z",
        "donor_response_status": null
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 1,
      "total_items": 3,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 2: Get Urgent Request Details

```http
GET /api/v1/urgent-requests/{request_id}
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "request_id": "uuid",
    "request_code": "REQ-2026-04-29-001",
    "hospital_info": {
      "hospital_id": "uuid",
      "hospital_name": "Hospital A",
      "address": "Street, City, Country",
      "phone": "+92-21-123456",
      "email": "blood@hospitala.com",
      "rating": 4.8,
      "latitude": 24.8615,
      "longitude": 67.0031,
      "distance_km": 2.5,
      "estimated_arrival_minutes": 8
    },
    "request_details": {
      "blood_type": "O+",
      "units_needed": 3,
      "units_received": 1,
      "units_pending": 2,
      "urgency_level": "critical",
      "status": "in_progress"
    },
    "patient_info": {
      "patient_name": "Patient Name",
      "patient_age": 45,
      "medical_condition": "Trauma",
      "description": "Multi-organ injuries from accident"
    },
    "contact_info": {
      "contact_person": "Dr. Hassan",
      "phone": "+92-21-123456",
      "emergency_contact": "+92-300-1111111"
    },
    "donor_response": {
      "donor_id": "uuid",
      "response_status": null,
      "response_time": null,
      "can_respond": true,
      "reason_cannot_respond": null
    },
    "timing": {
      "created_at": "2026-04-29T15:00:00Z",
      "estimated_needed_by": "2026-04-29T16:00:00Z",
      "time_remaining_minutes": 35,
      "expires_at": "2026-04-30T15:00:00Z"
    },
    "appointment_info": {
      "can_schedule": true,
      "available_times": [
        "2026-04-29T15:30:00Z",
        "2026-04-29T15:45:00Z",
        "2026-04-29T16:00:00Z"
      ]
    },
    "directions": {
      "directions_url": "https://api.example.com/api/v1/maps/directions?..."
    }
  }
}
```

---

#### Endpoint 3: Accept Emergency Request

```http
POST /api/v1/urgent-requests/{request_id}/accept
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "appointment_time": "2026-04-29T15:30:00Z",
  "notes": "On my way (optional)",
  "contact_number": "+92-300-1234567"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "response_id": "uuid",
    "request_id": "uuid",
    "donor_id": "uuid",
    "status": "accepted",
    "appointment_scheduled": true,
    "appointment_id": "uuid",
    "appointment_time": "2026-04-29T15:30:00Z",
    "confirmation_code": "EMERGENCY-2026-04-29-001",
    "points_reward": 100,
    "hospital_details": {
      "hospital_name": "Hospital A",
      "address": "Street, City",
      "contact": "+92-21-123456",
      "distance_km": 2.5,
      "estimated_arrival_minutes": 8
    },
    "message": "Thank you for responding. Please arrive within 8 minutes"
  }
}
```

---

#### Endpoint 4: Decline Emergency Request

```http
POST /api/v1/urgent-requests/{request_id}/decline
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "reason": "Not eligible|Too far|Personal reasons|Not available",
  "notes": "optional notes"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "response_id": "uuid",
    "request_id": "uuid",
    "status": "declined",
    "reason": "Not available",
    "declined_at": "2026-04-29T15:22:00Z"
  }
}
```

---

## 📬 PART 8: NOTIFICATIONS & ACTIVITY

### A. NOTIFICATIONS

#### Endpoint 1: Get Donor Notifications

```http
GET /api/v1/donor/notifications
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- type: string (emergency|appointment|reward|system)
- read: boolean (optional)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "notification_id": "uuid",
        "type": "emergency",
        "title": "Urgent Blood Needed",
        "message": "Hospital A needs O+ blood urgently",
        "icon": "https://...",
        "action_url": "/urgent-requests/uuid",
        "read": false,
        "read_at": null,
        "created_at": "2026-04-29T15:10:00Z",
        "data": {
          "request_id": "uuid",
          "request_code": "REQ-2026-04-29-001",
          "hospital_name": "Hospital A",
          "distance_km": 2.5
        }
      },
      {
        "notification_id": "uuid",
        "type": "appointment",
        "title": "Appointment Reminder",
        "message": "Your appointment at Hospital A is tomorrow at 10:00 AM",
        "icon": "https://...",
        "action_url": "/appointments/uuid",
        "read": true,
        "read_at": "2026-04-29T15:15:00Z",
        "created_at": "2026-04-28T10:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 2,
      "total_items": 25,
      "items_per_page": 20
    },
    "unread_count": 3
  }
}
```

---

#### Endpoint 2: Mark Notification as Read

```http
PUT /api/v1/donor/notifications/{notification_id}/mark-read
Authorization: Bearer {donor_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "notification_id": "uuid",
    "read": true,
    "read_at": "2026-04-29T15:22:00Z"
  }
}
```

---

#### Endpoint 3: Get Recent Activity

```http
GET /api/v1/donor/recent-activity
Authorization: Bearer {donor_token}
Content-Type: application/json

Query Parameters:
- limit: int (default: 20)
- days: int (default: 30)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "activity_feed": [
      {
        "activity_id": "uuid",
        "type": "donation",
        "title": "Successful Donation",
        "description": "You donated 1 unit at Hospital A",
        "timestamp": "2026-04-20T14:30:00Z",
        "icon": "blood-drop",
        "color": "#FF0000",
        "metadata": {
          "units": 1,
          "hospital_name": "Hospital A",
          "points_earned": 50
        }
      },
      {
        "activity_id": "uuid",
        "type": "reward",
        "title": "Badge Earned",
        "description": "You earned 'Generous Donor' badge",
        "timestamp": "2026-02-15T10:00:00Z",
        "icon": "star",
        "color": "#FFD700"
      },
      {
        "activity_id": "uuid",
        "type": "appointment",
        "title": "Appointment Scheduled",
        "description": "Scheduled appointment at Hospital A",
        "timestamp": "2026-04-29T15:22:00Z",
        "icon": "calendar",
        "color": "#4ECDC4"
      }
    ]
  }
}
```

---

## 💬 PART 9: HELP & SUPPORT

### A. HELP & FAQ

#### Endpoint 1: Get FAQ

```http
GET /api/v1/help/faq
Authorization: Bearer {donor_token} (optional)
Content-Type: application/json

Query Parameters:
- category: string (eligibility|donation|rewards|appointments)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "faqs": [
      {
        "faq_id": "uuid",
        "category": "eligibility",
        "question": "Who is eligible to donate blood?",
        "answer": "You must be 18+ years old, weigh at least 50kg, and have donated at least 56 days after last donation...",
        "helpful_count": 234,
        "views": 1000
      },
      {
        "faq_id": "uuid",
        "category": "donation",
        "question": "How long does a donation take?",
        "answer": "Typical donation takes about 45 minutes including registration and health screening.",
        "helpful_count": 156,
        "views": 800
      }
    ]
  }
}
```

---

#### Endpoint 2: Get Documents

```http
GET /api/v1/help/documents/{type}
Authorization: Bearer {donor_token} (optional)
Content-Type: application/json

Query Parameters:
- type: string (health_guide|eligibility_criteria|donation_process|safety_info)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "document_id": "uuid",
    "title": "Blood Donation Health Guide",
    "type": "health_guide",
    "description": "Complete guide on health requirements for blood donation",
    "content": "...",
    "file_url": "https://...",
    "download_available": true
  }
}
```

---

#### Endpoint 3: Submit Support Ticket

```http
POST /api/v1/support/contact
Authorization: Bearer {donor_token}
Content-Type: application/json

Body:
{
  "subject": "Issue with appointment",
  "category": "technical|general|complaint|suggestion",
  "message": "Detailed message",
  "contact_email": "donor@email.com",
  "attachments": [] (optional)
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "ticket_id": "uuid",
    "ticket_number": "SUPPORT-2026-04-29-001",
    "subject": "Issue with appointment",
    "status": "open",
    "created_at": "2026-04-29T15:22:00Z",
    "expected_response_time": "24 hours",
    "message": "Thank you for contacting us. We'll respond within 24 hours."
  }
}
```

---

## 💾 DATABASE MODELS NEEDED

### Donor Tables

#### donor_points_accounts Table
```sql
CREATE TABLE donor_points_accounts (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL UNIQUE REFERENCES users(id),
  total_points INT DEFAULT 0,
  available_points INT DEFAULT 0,
  redeemed_points INT DEFAULT 0,
  points_expiry_date DATE,
  tier_level INT DEFAULT 1,
  tier_name VARCHAR(50),
  last_points_update TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_donor_points_donor_id ON donor_points_accounts(donor_id);
```

#### donor_points_transactions Table
```sql
CREATE TABLE donor_points_transactions (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL REFERENCES users(id),
  transaction_type VARCHAR(50),
  points INT NOT NULL,
  description TEXT,
  reference_type VARCHAR(50),
  reference_id VARCHAR(255),
  balance_before INT,
  balance_after INT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_points_transactions_donor_id ON donor_points_transactions(donor_id);
CREATE INDEX idx_points_transactions_created_at ON donor_points_transactions(created_at);
```

#### donor_badges Table
```sql
CREATE TABLE donor_badges (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL REFERENCES users(id),
  badge_id UUID NOT NULL,
  badge_name VARCHAR(150),
  earned_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_donor_badge_unique ON donor_badges(donor_id, badge_id);
```

#### donor_reward_redemptions Table
```sql
CREATE TABLE donor_reward_redemptions (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL REFERENCES users(id),
  reward_id UUID NOT NULL,
  redemption_code VARCHAR(100) UNIQUE NOT NULL,
  points_spent INT NOT NULL,
  status VARCHAR(50) DEFAULT 'completed',
  expiry_date DATE,
  used BOOLEAN DEFAULT false,
  used_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_reward_redemptions_donor_id ON donor_reward_redemptions(donor_id);
CREATE INDEX idx_reward_redemptions_status ON donor_reward_redemptions(status);
```

#### emergency_request_responses Table (Already in Hospital report, but referenced here)
```sql
CREATE TABLE emergency_request_responses (
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

CREATE INDEX idx_emergency_responses_request_id ON emergency_request_responses(emergency_request_id);
CREATE INDEX idx_emergency_responses_donor_id ON emergency_request_responses(donor_id);
```

#### donor_notification_preferences Table
```sql
CREATE TABLE donor_notification_preferences (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL UNIQUE REFERENCES users(id),
  email_notifications BOOLEAN DEFAULT true,
  sms_notifications BOOLEAN DEFAULT true,
  push_notifications BOOLEAN DEFAULT true,
  emergency_request_alerts BOOLEAN DEFAULT true,
  reward_updates BOOLEAN DEFAULT true,
  appointment_reminders BOOLEAN DEFAULT true,
  newsletter BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_donor_preferences_donor_id ON donor_notification_preferences(donor_id);
```

---

## 🔧 BACKEND SERVICES NEEDED

### 1. DonorService

```javascript
// src/services/donor.service.js

class DonorService {
  // Dashboard
  async getDonorDashboard(donorId) {}

  // Profile
  async getDonorProfile(donorId) {}
  async updateDonorProfile(donorId, profileData) {}
  async uploadProfilePicture(donorId, file) {}
  async getDonorHealthHistory(donorId) {}

  // Donations
  async getDonationHistory(donorId, filters) {}
  async checkDonationEligibility(donorId) {}
  async getNearbyHospitals(latitude, longitude, filters) {}

  // Appointments
  async getMyAppointments(donorId, filters) {}
  async getAvailableSlots(hospitalId, startDate, endDate, bloodType) {}
  async bookAppointment(donorId, appointmentData) {}
  async cancelAppointment(appointmentId, reason) {}
  async rescheduleAppointment(appointmentId, newSlotId) {}

  // Points & Rewards
  async getDonorPoints(donorId) {}
  async getAvailableRewards(donorId, filters) {}
  async redeemReward(donorId, rewardId, quantity) {}
  async getRedemptions(donorId, filters) {}

  // Badges
  async getDonorBadges(donorId) {}
  async checkBadgeProgress(donorId) {}

  // Emergency Requests
  async getUrgentRequests(donorLocation, filters) {}
  async getUrgentRequestDetails(requestId) {}
  async acceptEmergencyRequest(donorId, requestId, appointmentTime) {}
  async declineEmergencyRequest(donorId, requestId, reason) {}

  // Notifications
  async getDonorNotifications(donorId, filters) {}
  async markNotificationAsRead(notificationId) {}
  async getRecentActivity(donorId, filters) {}
}
```

### 2. RewardService

```javascript
// src/services/reward.service.js

class RewardService {
  async getRewardsCatalog(filters) {}
  async getRewardDetails(rewardId) {}
  async redeemReward(donorId, rewardId, quantity) {}
  async trackPointsTransaction(donorId, transactionData) {}
  async calculateTierBenefits(points) {}
  async checkRewardAvailability(rewardId) {}
}
```

### 3. EligibilityService

```javascript
// src/services/eligibility.service.js

class EligibilityService {
  async checkDonationEligibility(donorId) {}
  async validateHealthStatus(donorId) {}
  async checkTimingRequirements(donorId) {}
  async getEligibilityReasons(donorId) {}
  async updateEligibilityStatus(donorId) {}
}
```

---

## 📁 BACKEND ROUTES NEEDED

```javascript
// src/routes/donor.routes.js

// Dashboard
router.get('/dashboard', donorAuth, donorController.getDashboard);

// Profile
router.get('/profile', donorAuth, donorController.getProfile);
router.put('/profile', donorAuth, donorController.updateProfile);
router.post('/profile/picture', donorAuth, donorController.uploadProfilePicture);
router.get('/health-history', donorAuth, donorController.getHealthHistory);

// Donations
router.get('/donations', donorAuth, donorController.getDonationHistory);
router.get('/donation-eligibility', donorAuth, donorController.checkEligibility);

// Appointments
router.get('/appointments', donorAuth, donorController.getMyAppointments);

// Points & Rewards
router.get('/points', donorAuth, donorController.getPoints);
router.get('/badges', donorAuth, donorController.getBadges);
router.get('/redemptions', donorAuth, donorController.getRedemptions);

// Notifications & Activity
router.get('/notifications', donorAuth, donorController.getNotifications);
router.put('/notifications/:notificationId/mark-read', donorAuth, donorController.markNotificationRead);
router.get('/recent-activity', donorAuth, donorController.getRecentActivity);

// Appointment Booking (shared routes)
router.get('/book-appointment/slots', donorAuth, appointmentController.getSlots);
router.post('/book-appointment', donorAuth, appointmentController.bookAppointment);
router.delete('/book-appointment/:appointmentId', donorAuth, appointmentController.cancelAppointment);
router.put('/book-appointment/:appointmentId', donorAuth, appointmentController.rescheduleAppointment);

// Emergency Requests
router.get('/urgent-requests', donorAuth, emergencyController.getUrgentRequests);
router.get('/urgent-requests/:requestId', donorAuth, emergencyController.getRequestDetails);
router.post('/urgent-requests/:requestId/accept', donorAuth, emergencyController.acceptRequest);
router.post('/urgent-requests/:requestId/decline', donorAuth, emergencyController.declineRequest);
```

---

## 📊 IMPLEMENTATION CHECKLIST

### Phase 1: Database Setup (Week 1)
- [ ] Create `donor_points_accounts` table
- [ ] Create `donor_points_transactions` table
- [ ] Create `donor_badges` table
- [ ] Create `donor_reward_redemptions` table
- [ ] Create `donor_notification_preferences` table
- [ ] Create database indexes

### Phase 2: Core Donor Services (Week 2)
- [ ] Create `DonorService` class
- [ ] Create `RewardService` class
- [ ] Create `EligibilityService` class
- [ ] Implement donor authentication middleware
- [ ] Implement eligibility checking

### Phase 3: Dashboard & Profile (Week 2-3)
- [ ] Implement dashboard endpoint
- [ ] Implement profile management
- [ ] Implement health history tracking
- [ ] Implement nearby hospitals finder

### Phase 4: Rewards & Points (Week 3-4)
- [ ] Implement points tracking
- [ ] Implement rewards catalog
- [ ] Implement redemption system
- [ ] Implement badge system
- [ ] Implement tier calculations

### Phase 5: Appointments (Week 4)
- [ ] Implement appointment booking
- [ ] Implement slot availability checking
- [ ] Implement cancellation & rescheduling
- [ ] Implement confirmation handling

### Phase 6: Emergency Management (Week 5)
- [ ] Implement urgent request notifications
- [ ] Implement response tracking
- [ ] Implement appointment scheduling for emergencies
- [ ] Implement real-time notifications

### Phase 7: Testing & Deployment (Week 6)
- [ ] Unit tests for all services
- [ ] Integration tests for workflows
- [ ] Load testing (5000 concurrent donors)
- [ ] Security audit
- [ ] Production deployment

---

## 🔑 Key Requirements Summary

| Component | Count | Complexity |
|-----------|-------|-----------|
| **API Endpoints** | 25+ | Hard |
| **Database Tables** | 5 | Medium |
| **Services** | 3 | Hard |
| **Real-time Features** | Notifications | High |
| **Reward System** | Complete | High |

---

## 🎯 Success Metrics

- Dashboard load time: < 1 second
- Profile update: < 300ms
- Points calculation: < 100ms
- Reward redemption: < 500ms
- Appointment booking: < 500ms
- Emergency request notification: < 2 seconds
- Badge unlocking: < 100ms
- Real-time notification delivery: < 2 seconds

---

## 📝 Security Considerations

1. **Donor Authentication**
   - Secure token-based auth
   - Session management
   - Activity logging

2. **Data Protection**
   - Encrypt health data
   - HIPAA compliance
   - Privacy controls

3. **Points Security**
   - Transaction logging
   - Fraud detection
   - Audit trails

4. **Emergency Safety**
   - Real-time notifications
   - Location tracking
   - Emergency protocols

---

## 📞 Support & Documentation

- API documentation: `/api/v1/donor/docs`
- Donation guide: `/docs/DONOR_DONATION_GUIDE.md`
- Rewards FAQ: `/docs/REWARDS_FAQ.md`
- Emergency procedures: `/docs/EMERGENCY_HELP.md`

