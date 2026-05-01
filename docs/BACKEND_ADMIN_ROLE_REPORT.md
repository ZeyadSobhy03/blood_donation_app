# Backend API Requirements Report
## Admin Role Features

**Report Date:** April 29, 2026  
**Target Audience:** Backend Development Team  
**Priority:** High (Admin features are critical for system management)

---

## 📊 PART 1: ADMIN DASHBOARD & OVERVIEW

### Current Frontend Status
Admin screens exist in the Flutter app but require backend support for:
- Dashboard statistics
- System monitoring
- User management
- System configuration

### Dashboard Requirements

#### Endpoint 1: Get Admin Dashboard

```http
GET /api/v1/admin/dashboard
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "dashboard_id": "uuid",
    "timestamp": "2026-04-29T15:22:00Z",
    "summary": {
      "total_donors": 5234,
      "total_hospitals": 45,
      "total_admins": 12,
      "total_donations_completed": 12450,
      "total_donations_pending": 89,
      "total_points_distributed": 623000,
      "new_donors_this_month": 342,
      "new_hospitals_this_month": 5
    },
    "system_health": {
      "status": "healthy",
      "uptime_percentage": 99.85,
      "response_time_ms": 245,
      "database_status": "operational",
      "api_status": "operational",
      "last_health_check": "2026-04-29T15:20:00Z"
    },
    "alerts": {
      "critical": 1,
      "warning": 5,
      "info": 12,
      "recent_alerts": [
        {
          "alert_id": "uuid",
          "severity": "critical",
          "type": "low_blood_inventory",
          "message": "O+ blood critical low at Hospital A",
          "hospital_id": "uuid",
          "created_at": "2026-04-29T14:30:00Z"
        }
      ]
    },
    "blood_inventory_summary": {
      "total_units_available": 2450,
      "blood_types": {
        "O+": {"available": 450, "critical_threshold": 100, "status": "normal"},
        "O-": {"available": 320, "critical_threshold": 80, "status": "normal"},
        "A+": {"available": 380, "critical_threshold": 100, "status": "warning"},
        "A-": {"available": 210, "critical_threshold": 75, "status": "normal"},
        "B+": {"available": 280, "critical_threshold": 100, "status": "normal"},
        "B-": {"available": 150, "critical_threshold": 75, "status": "warning"},
        "AB+": {"available": 180, "critical_threshold": 75, "status": "normal"},
        "AB-": {"available": 100, "critical_threshold": 50, "status": "normal"}
      },
      "lowest_inventory_hospital": "Hospital A",
      "highest_demand_type": "O+"
    },
    "top_hospitals": [
      {
        "rank": 1,
        "hospital_id": "uuid",
        "name": "Hospital A",
        "donations_completed": 890,
        "success_rate": 98.5,
        "avg_response_time_hours": 2.5
      }
    ],
    "activities": {
      "donations_this_week": 234,
      "appointments_this_week": 445,
      "donations_this_month": 987,
      "appointments_this_month": 1850
    }
  }
}
```

---

## 👥 PART 2: USER MANAGEMENT

### A. DONOR MANAGEMENT

#### Endpoint 1: List All Donors

```http
GET /api/v1/admin/donors
Authorization: Bearer {admin_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20, max: 100)
- status: string (active|inactive|suspended|banned)
- blood_type: string (optional)
- search: string (name, email, phone)
- sort_by: string (name|created_at|donations_count|points)
- sort_order: asc|desc
- filter_by_eligibility: boolean (show only eligible donors)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donors": [
      {
        "donor_id": "uuid",
        "full_name": "Ahmed Ali",
        "email": "ahmed@email.com",
        "phone": "+92-300-1234567",
        "blood_type": "O+",
        "status": "active",
        "total_donations": 15,
        "total_points": 750,
        "last_donation_date": "2026-04-20",
        "is_eligible": true,
        "verified": true,
        "created_at": "2025-01-15T10:00:00Z",
        "badges": ["Generous Donor", "Regular Donor"],
        "next_eligible_donation": "2026-05-04"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 262,
      "total_items": 5234,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 2: Get Donor Details

```http
GET /api/v1/admin/donors/{donor_id}
Authorization: Bearer {admin_token}
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
      "gender": "Male",
      "address": "Street, City, Country",
      "profile_picture": "https://..."
    },
    "medical_info": {
      "blood_type": "O+",
      "rh_factor": "+",
      "weight_kg": 75,
      "health_conditions": ["None"],
      "medications": [],
      "allergies": []
    },
    "donation_history": {
      "total_donations": 15,
      "successful_donations": 14,
      "failed_donations": 1,
      "donations": [
        {
          "donation_id": "uuid",
          "hospital_name": "Hospital A",
          "donation_date": "2026-04-20",
          "blood_type_donated": "O+",
          "units_donated": 1,
          "status": "completed",
          "points_awarded": 50
        }
      ]
    },
    "reward_info": {
      "total_points": 750,
      "redeemed_points": 0,
      "badges": ["Generous Donor", "Regular Donor"],
      "redemptions": []
    },
    "account_status": {
      "status": "active",
      "verified": true,
      "verified_at": "2025-01-16T10:00:00Z",
      "suspended": false,
      "banned": false,
      "ban_reason": null
    },
    "eligibility": {
      "is_eligible": true,
      "last_donation": "2026-04-20",
      "next_eligible_date": "2026-05-04",
      "days_until_eligible": 5,
      "eligibility_reasons": []
    },
    "appointments": {
      "upcoming": [
        {
          "appointment_id": "uuid",
          "hospital_name": "Hospital A",
          "appointment_date": "2026-05-05",
          "appointment_time": "10:00-10:30",
          "status": "confirmed"
        }
      ],
      "completed_count": 14,
      "cancelled_count": 1,
      "no_show_count": 0
    },
    "created_at": "2025-01-15T10:00:00Z",
    "updated_at": "2026-04-29T15:00:00Z"
  }
}
```

---

#### Endpoint 3: Update Donor Status

```http
PUT /api/v1/admin/donors/{donor_id}
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "status": "active|inactive|suspended|banned",
  "reason": "string (required if suspended/banned)",
  "action": "update_status|verify|unverify|reset_points",
  "points_to_award": 100 (optional),
  "notes": "Admin notes (optional)"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "donor_id": "uuid",
    "previous_status": "active",
    "new_status": "suspended",
    "reason": "Multiple no-shows",
    "updated_at": "2026-04-29T15:22:00Z",
    "audit_log_id": "uuid",
    "message": "Donor status updated successfully"
  }
}
```

---

#### Endpoint 4: Ban/Unban Donor

```http
POST /api/v1/admin/donors/{donor_id}/ban
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "action": "ban|unban",
  "reason": "string (required for ban)",
  "ban_duration_days": 30 (optional, null = permanent)
}
```

---

### B. HOSPITAL MANAGEMENT

#### Endpoint 1: List All Hospitals

```http
GET /api/v1/admin/hospitals
Authorization: Bearer {admin_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 20)
- status: string (active|inactive|suspended)
- search: string (name, city, contact)
- sort_by: string (name|donations|rating|created_at)
- sort_order: asc|desc
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "Hospital A",
        "license_number": "LIC-2020-001",
        "city": "Karachi",
        "phone": "+92-21-123456",
        "email": "admin@hospitala.com",
        "status": "active",
        "verified": true,
        "total_donations": 890,
        "active_staff": 25,
        "blood_inventory_status": "normal",
        "rating": 4.8,
        "emergency_requests_count": 23,
        "acceptance_rate": 92.5,
        "created_at": "2020-01-15T10:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_items": 45,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 2: Get Hospital Details

```http
GET /api/v1/admin/hospitals/{hospital_id}
Authorization: Bearer {admin_token}
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
      "phone": "+92-21-123456",
      "email": "admin@hospitala.com",
      "website": "https://hospitala.com",
      "director_name": "Dr. Ahmed Khan"
    },
    "blood_inventory": {
      "total_units": 450,
      "O+": 150,
      "O-": 80,
      "A+": 95,
      "A-": 40,
      "B+": 55,
      "B-": 20,
      "AB+": 10,
      "AB-": 0
    },
    "performance": {
      "total_donations": 890,
      "successful_donations": 872,
      "failed_donations": 18,
      "success_rate": 97.9,
      "average_response_time_hours": 2.5,
      "emergency_requests": 23,
      "acceptance_rate": 92.5,
      "avg_rating": 4.8,
      "total_reviews": 156
    },
    "staff": {
      "total_staff": 28,
      "active_staff": 25,
      "staff_list": [
        {
          "staff_id": "uuid",
          "name": "Dr. Hassan",
          "role": "Doctor",
          "email": "hassan@hospital.com",
          "status": "active"
        }
      ]
    },
    "status": {
      "account_status": "active",
      "verified": true,
      "verified_at": "2020-01-20T10:00:00Z",
      "suspended": false,
      "accepting_requests": true
    },
    "recent_activity": {
      "last_donation_date": "2026-04-28",
      "last_request_created": "2026-04-29T10:00:00Z",
      "emergency_requests_this_month": 8,
      "donations_this_month": 89
    },
    "settings": {
      "notification_preferences": "all",
      "blood_threshold_alerts": true,
      "auto_accept_emergency": false,
      "max_concurrent_appointments": 10
    }
  }
}
```

---

#### Endpoint 3: Create/Update Hospital

```http
POST /api/v1/admin/hospitals
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "name": "New Hospital",
  "license_number": "LIC-2026-001",
  "address": "Street, City, Country",
  "phone": "+92-21-987654",
  "email": "admin@newhospital.com",
  "website": "https://newhospital.com",
  "director_name": "Dr. Name",
  "blood_bank_contact": "+92-21-111222",
  "latitude": 24.8607,
  "longitude": 67.0011
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "name": "New Hospital",
    "status": "pending_verification",
    "message": "Hospital created successfully. Pending verification.",
    "created_at": "2026-04-29T15:22:00Z"
  }
}
```

---

#### Endpoint 4: Suspend/Activate Hospital

```http
PUT /api/v1/admin/hospitals/{hospital_id}/status
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "action": "suspend|activate",
  "reason": "string (required for suspend)"
}
```

---

### C. ADMIN MANAGEMENT

#### Endpoint 1: List All Admins

```http
GET /api/v1/admin/admins
Authorization: Bearer {admin_token}
Content-Type: application/json

Query Parameters:
- page: int
- limit: int
- role: string (super_admin|admin|moderator)
- status: string (active|inactive|suspended)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "admins": [
      {
        "admin_id": "uuid",
        "full_name": "Admin Name",
        "email": "admin@system.com",
        "role": "super_admin",
        "status": "active",
        "permissions_count": 25,
        "created_at": "2024-01-15T10:00:00Z",
        "last_login": "2026-04-29T14:30:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 1,
      "total_items": 12,
      "items_per_page": 20
    }
  }
}
```

---

#### Endpoint 2: Create New Admin

```http
POST /api/v1/admin/admins
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "full_name": "New Admin",
  "email": "newadmin@system.com",
  "phone": "+92-300-1111111",
  "role": "admin|moderator",
  "permissions": ["manage_donors", "manage_hospitals", "view_reports"],
  "password": "secure_password",
  "notes": "optional notes"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "admin_id": "uuid",
    "email": "newadmin@system.com",
    "role": "admin",
    "temporary_password": "temp_password_123",
    "status": "active",
    "message": "Admin created. Send temporary password securely.",
    "created_at": "2026-04-29T15:22:00Z"
  }
}
```

---

#### Endpoint 3: Get Admin Details

```http
GET /api/v1/admin/admins/{admin_id}
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "admin_id": "uuid",
    "full_name": "Admin Name",
    "email": "admin@system.com",
    "phone": "+92-300-1234567",
    "role": "super_admin",
    "status": "active",
    "permissions": [
      "manage_donors",
      "manage_hospitals",
      "manage_admins",
      "view_reports",
      "manage_system_settings",
      "view_audit_logs"
    ],
    "activity": {
      "last_login": "2026-04-29T14:30:00Z",
      "total_logins": 523,
      "actions_performed_today": 45,
      "actions_performed_month": 1250
    },
    "created_at": "2024-01-15T10:00:00Z",
    "updated_at": "2026-04-29T15:00:00Z"
  }
}
```

---

#### Endpoint 4: Update Admin

```http
PUT /api/v1/admin/admins/{admin_id}
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "full_name": "Updated Name",
  "phone": "+92-300-9999999",
  "role": "admin|moderator",
  "status": "active|inactive|suspended",
  "permissions": ["manage_donors", "manage_hospitals"]
}
```

---

## 🔧 PART 3: SYSTEM MANAGEMENT

### A. SYSTEM HEALTH

#### Endpoint 1: Get System Health

```http
GET /api/v1/admin/system-health
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "system_id": "main-server",
    "status": "healthy",
    "timestamp": "2026-04-29T15:22:00Z",
    "uptime": {
      "uptime_percentage": 99.85,
      "last_downtime": "2026-04-15T02:30:00Z",
      "downtime_duration_minutes": 15,
      "total_downtime_month": 60
    },
    "performance": {
      "api_response_time_ms": 245,
      "database_query_time_ms": 85,
      "cache_hit_rate": 94.5,
      "request_throughput_per_second": 1250
    },
    "resources": {
      "cpu_usage_percent": 45.2,
      "memory_usage_percent": 62.3,
      "disk_usage_percent": 71.8,
      "disk_space_free_gb": 450
    },
    "services": {
      "api_server": {"status": "operational", "response_time": 245},
      "database": {"status": "operational", "connection_pool": "95/100"},
      "cache_redis": {"status": "operational", "hit_rate": 94.5},
      "notification_service": {"status": "operational", "pending_notifications": 234},
      "file_storage": {"status": "operational", "usage_gb": 1250}
    },
    "database": {
      "total_connections": 95,
      "active_queries": 12,
      "slow_queries_24h": 2,
      "backup_status": "completed",
      "last_backup": "2026-04-29T03:00:00Z"
    },
    "alerts": {
      "critical": 0,
      "warning": 1,
      "info": 3
    }
  }
}
```

---

#### Endpoint 2: Check System Health (Trigger)

```http
POST /api/v1/admin/system-health/check
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "check_type": "full|quick|database|cache|api"
}
```

---

### B. MAINTENANCE MODE

#### Endpoint 1: Set Maintenance Mode

```http
POST /api/v1/admin/maintenance-mode
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "enable": true,
  "maintenance_reason": "Database migration",
  "estimated_duration_minutes": 30,
  "maintenance_message": "System under maintenance. Back soon.",
  "notify_users": true
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "status": "maintenance_enabled",
    "maintenance_started_at": "2026-04-29T15:22:00Z",
    "estimated_end_time": "2026-04-29T15:52:00Z",
    "maintenance_reason": "Database migration",
    "message": "Maintenance mode enabled. Users will see maintenance page."
  }
}
```

---

#### Endpoint 2: Get Maintenance Status

```http
GET /api/v1/admin/maintenance-mode/status
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "is_maintenance_mode": true,
    "maintenance_started_at": "2026-04-29T15:22:00Z",
    "estimated_end_time": "2026-04-29T15:52:00Z",
    "maintenance_reason": "Database migration",
    "maintenance_message": "System under maintenance. Back soon.",
    "duration_minutes": 30,
    "time_remaining_minutes": 25
  }
}
```

---

## 📋 PART 4: AUDIT & MONITORING

### A. AUDIT LOGS

#### Endpoint 1: Get Audit Logs

```http
GET /api/v1/admin/audit-logs
Authorization: Bearer {admin_token}
Content-Type: application/json

Query Parameters:
- page: int (default: 1)
- limit: int (default: 50)
- action_type: string (create|update|delete|login|ban|suspend)
- admin_id: uuid (optional - filter by admin)
- resource_type: string (donor|hospital|admin|system)
- date_from: date (YYYY-MM-DD)
- date_to: date (YYYY-MM-DD)
- search: string (resource_id, username)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "audit_logs": [
      {
        "audit_id": "uuid",
        "admin_id": "uuid",
        "admin_name": "Admin Name",
        "action_type": "update",
        "resource_type": "donor",
        "resource_id": "donor_uuid",
        "resource_name": "Ahmed Ali",
        "changes": {
          "status": {"old": "active", "new": "suspended"},
          "reason": "Multiple no-shows"
        },
        "ip_address": "192.168.1.1",
        "user_agent": "Mozilla/5.0...",
        "timestamp": "2026-04-29T14:30:00Z",
        "description": "Donor status changed from active to suspended"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 100,
      "total_items": 4950,
      "items_per_page": 50
    }
  }
}
```

---

## 🔐 PART 5: PERMISSIONS & ROLES

### A. ROLE MANAGEMENT

#### Endpoint 1: Get All Roles

```http
GET /api/v1/admin/permissions/roles
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "roles": [
      {
        "role_id": "uuid",
        "role_name": "super_admin",
        "display_name": "Super Administrator",
        "description": "Full access to all system features",
        "permissions_count": 30,
        "admins_count": 2,
        "permissions": [
          "manage_donors",
          "manage_hospitals",
          "manage_admins",
          "manage_system_settings",
          "view_audit_logs",
          "view_reports",
          "manage_permissions",
          "manage_roles"
        ],
        "created_at": "2024-01-01T00:00:00Z"
      },
      {
        "role_id": "uuid",
        "role_name": "admin",
        "display_name": "Administrator",
        "description": "Manage users and view reports",
        "permissions_count": 20,
        "admins_count": 5,
        "permissions": [
          "manage_donors",
          "manage_hospitals",
          "view_reports",
          "view_audit_logs"
        ]
      },
      {
        "role_id": "uuid",
        "role_name": "moderator",
        "display_name": "Moderator",
        "description": "Moderate user content and activities",
        "permissions_count": 10,
        "admins_count": 5,
        "permissions": [
          "manage_donors_status",
          "view_reports",
          "manage_content"
        ]
      }
    ]
  }
}
```

---

#### Endpoint 2: Get Role Details

```http
GET /api/v1/admin/permissions/roles/{role_id}
Authorization: Bearer {admin_token}
Content-Type: application/json
```

**Response:**
```json
{
  "success": true,
  "data": {
    "role_id": "uuid",
    "role_name": "admin",
    "display_name": "Administrator",
    "description": "Manage users and view reports",
    "permissions": {
      "donor_management": {
        "manage_donors": true,
        "view_donors": true,
        "update_donor_status": true,
        "ban_donor": true,
        "view_donor_details": true
      },
      "hospital_management": {
        "manage_hospitals": true,
        "create_hospital": true,
        "update_hospital": true,
        "suspend_hospital": true
      },
      "reporting": {
        "view_reports": true,
        "export_reports": true,
        "view_analytics": true
      },
      "audit": {
        "view_audit_logs": true,
        "export_logs": true
      },
      "system": {
        "view_system_health": false,
        "manage_system_settings": false,
        "maintenance_mode": false
      }
    },
    "admins_with_role": 5,
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2026-04-29T15:00:00Z"
  }
}
```

---

#### Endpoint 3: Update Role Permissions

```http
PUT /api/v1/admin/permissions/roles/{role_id}
Authorization: Bearer {admin_token}
Content-Type: application/json

Body:
{
  "role_name": "admin",
  "description": "Updated description",
  "permissions": {
    "donor_management": {
      "manage_donors": true,
      "view_donors": true,
      "update_donor_status": true,
      "ban_donor": false
    },
    "hospital_management": {
      "manage_hospitals": true,
      "create_hospital": false,
      "update_hospital": true
    }
  }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "role_id": "uuid",
    "role_name": "admin",
    "permissions_updated_count": 5,
    "permissions_added": ["new_permission"],
    "permissions_removed": ["old_permission"],
    "updated_at": "2026-04-29T15:22:00Z"
  }
}
```

---

#### Endpoint 4: Create New Role

```http
POST /api/v1/admin/permissions/roles
Authorization: Bearer {super_admin_token}
Content-Type: application/json

Body:
{
  "role_name": "custom_role",
  "display_name": "Custom Role Name",
  "description": "Custom role description",
  "permissions": {
    "donor_management": {
      "view_donors": true,
      "manage_donors": false
    }
  }
}
```

---

### B. PERMISSION REFERENCE

#### All Available Permissions

```json
{
  "donor_management": [
    "view_donors",
    "manage_donors",
    "update_donor_status",
    "ban_donor",
    "unban_donor",
    "verify_donor",
    "reset_donor_points",
    "view_donor_details",
    "view_donor_donations",
    "export_donor_data"
  ],
  "hospital_management": [
    "view_hospitals",
    "manage_hospitals",
    "create_hospital",
    "update_hospital",
    "suspend_hospital",
    "activate_hospital",
    "verify_hospital",
    "view_hospital_details",
    "manage_hospital_staff",
    "export_hospital_data"
  ],
  "admin_management": [
    "view_admins",
    "create_admin",
    "update_admin",
    "delete_admin",
    "manage_admin_roles",
    "reset_admin_password"
  ],
  "system_settings": [
    "view_system_health",
    "manage_system_settings",
    "enable_maintenance_mode",
    "disable_maintenance_mode",
    "manage_system_configuration"
  ],
  "audit_logging": [
    "view_audit_logs",
    "export_audit_logs",
    "search_audit_logs",
    "manage_log_retention"
  ],
  "reporting": [
    "view_reports",
    "export_reports",
    "view_analytics",
    "create_custom_reports",
    "schedule_reports"
  ]
}
```

---

## 💾 DATABASE MODELS NEEDED

### Admin Role Tables

#### admin_roles Table
```sql
CREATE TABLE admin_roles (
  id UUID PRIMARY KEY,
  role_name VARCHAR(100) UNIQUE NOT NULL,
  display_name VARCHAR(150) NOT NULL,
  description TEXT,
  is_system_role BOOLEAN DEFAULT false,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_admin_roles_name ON admin_roles(role_name);
```

#### role_permissions Table
```sql
CREATE TABLE role_permissions (
  id UUID PRIMARY KEY,
  role_id UUID NOT NULL REFERENCES admin_roles(id) ON DELETE CASCADE,
  permission_key VARCHAR(100) NOT NULL,
  permission_name VARCHAR(150) NOT NULL,
  permission_category VARCHAR(50),
  can_grant BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_role_permissions_role_id ON role_permissions(role_id);
CREATE INDEX idx_role_permissions_key ON role_permissions(permission_key);
CREATE UNIQUE INDEX idx_role_permission_unique ON role_permissions(role_id, permission_key);
```

#### audit_logs Table
```sql
CREATE TABLE audit_logs (
  id UUID PRIMARY KEY,
  admin_id UUID REFERENCES users(id),
  admin_name VARCHAR(150),
  action_type VARCHAR(50) NOT NULL,
  resource_type VARCHAR(50),
  resource_id VARCHAR(255),
  resource_name VARCHAR(255),
  changes JSONB,
  ip_address VARCHAR(45),
  user_agent TEXT,
  status VARCHAR(20) DEFAULT 'success',
  error_message TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_audit_logs_admin_id ON audit_logs(admin_id);
CREATE INDEX idx_audit_logs_action_type ON audit_logs(action_type);
CREATE INDEX idx_audit_logs_resource_type ON audit_logs(resource_type);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
```

#### system_health_logs Table
```sql
CREATE TABLE system_health_logs (
  id UUID PRIMARY KEY,
  check_timestamp TIMESTAMP NOT NULL,
  api_status VARCHAR(20),
  database_status VARCHAR(20),
  cache_status VARCHAR(20),
  cpu_percent FLOAT,
  memory_percent FLOAT,
  disk_percent FLOAT,
  response_time_ms INT,
  uptime_percent FLOAT,
  alerts_count INT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_system_health_logs_timestamp ON system_health_logs(check_timestamp);
```

#### admin_activity_logs Table
```sql
CREATE TABLE admin_activity_logs (
  id UUID PRIMARY KEY,
  admin_id UUID NOT NULL REFERENCES users(id),
  activity_type VARCHAR(50),
  description TEXT,
  ip_address VARCHAR(45),
  login_time TIMESTAMP,
  logout_time TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_admin_activity_logs_admin_id ON admin_activity_logs(admin_id);
CREATE INDEX idx_admin_activity_logs_created_at ON admin_activity_logs(created_at);
```

---

## 🔧 BACKEND SERVICES NEEDED

### 1. AdminService

```javascript
// src/services/admin.service.js

class AdminService {
  // Donor Management
  async listDonors(filters, pagination) {}
  async getDonorDetails(donorId) {}
  async updateDonorStatus(donorId, newStatus, reason) {}
  async banDonor(donorId, reason, duration) {}
  async unbanDonor(donorId) {}
  async verifyDonor(donorId) {}
  async resetDonorPoints(donorId, newPoints) {}

  // Hospital Management
  async listHospitals(filters, pagination) {}
  async getHospitalDetails(hospitalId) {}
  async createHospital(hospitalData) {}
  async updateHospital(hospitalId, updateData) {}
  async suspendHospital(hospitalId, reason) {}
  async activateHospital(hospitalId) {}

  // Admin Management
  async listAdmins(filters, pagination) {}
  async createAdmin(adminData) {}
  async updateAdmin(adminId, updateData) {}
  async deleteAdmin(adminId) {}
  async resetAdminPassword(adminId) {}

  // System Health
  async getSystemHealth() {}
  async checkSystemHealth() {}
  async setMaintenanceMode(enabled, details) {}

  // Dashboard
  async getDashboardData() {}
  async getBloodInventorySummary() {}
  async getSystemAlerts() {}
}
```

### 2. AuditService

```javascript
// src/services/audit.service.js

class AuditService {
  async logAction(adminId, actionType, resourceType, resourceId, changes) {}
  async getAuditLogs(filters, pagination) {}
  async exportAuditLogs(filters, format) {}
  async searchAuditLogs(searchTerm, filters) {}
}
```

### 3. RolePermissionService

```javascript
// src/services/rolePermission.service.js

class RolePermissionService {
  async getAllRoles() {}
  async getRoleDetails(roleId) {}
  async createRole(roleData) {}
  async updateRole(roleId, roleData) {}
  async deleteRole(roleId) {}
  async assignPermissionsToRole(roleId, permissions) {}
  async checkPermission(userId, permissionKey) {}
  async getUserPermissions(userId) {}
}
```

---

## 📁 BACKEND ROUTES NEEDED

```javascript
// src/routes/admin.routes.js

// Dashboard & Health
router.get('/dashboard', adminAuth, adminController.getDashboard);
router.get('/system-health', adminAuth, adminController.getSystemHealth);
router.post('/system-health/check', adminAuth, adminController.checkSystemHealth);
router.get('/blood-inventory-summary', adminAuth, adminController.getBloodInventorySummary);
router.get('/alerts', adminAuth, adminController.getAlerts);

// Donor Management
router.get('/donors', adminAuth, adminController.listDonors);
router.get('/donors/:donorId', adminAuth, adminController.getDonorDetails);
router.put('/donors/:donorId', adminAuth, adminController.updateDonor);
router.post('/donors/:donorId/ban', adminAuth, adminController.banDonor);
router.post('/donors/:donorId/unban', adminAuth, adminController.unbanDonor);

// Hospital Management
router.get('/hospitals', adminAuth, adminController.listHospitals);
router.get('/hospitals/:hospitalId', adminAuth, adminController.getHospitalDetails);
router.post('/hospitals', adminAuth, adminController.createHospital);
router.put('/hospitals/:hospitalId', adminAuth, adminController.updateHospital);
router.put('/hospitals/:hospitalId/status', adminAuth, adminController.updateHospitalStatus);

// Admin Management
router.get('/admins', superAdminAuth, adminController.listAdmins);
router.post('/admins', superAdminAuth, adminController.createAdmin);
router.get('/admins/:adminId', superAdminAuth, adminController.getAdminDetails);
router.put('/admins/:adminId', superAdminAuth, adminController.updateAdmin);
router.delete('/admins/:adminId', superAdminAuth, adminController.deleteAdmin);

// System Management
router.post('/maintenance-mode', superAdminAuth, adminController.setMaintenanceMode);
router.get('/maintenance-mode/status', adminAuth, adminController.getMaintenanceStatus);

// Audit Logs
router.get('/audit-logs', adminAuth, adminController.getAuditLogs);
router.get('/audit-logs/export', adminAuth, adminController.exportAuditLogs);

// Permissions & Roles
router.get('/permissions/roles', adminAuth, adminController.getAllRoles);
router.get('/permissions/roles/:roleId', adminAuth, adminController.getRoleDetails);
router.put('/permissions/roles/:roleId', superAdminAuth, adminController.updateRole);
router.post('/permissions/roles', superAdminAuth, adminController.createRole);
```

---

## 📊 IMPLEMENTATION CHECKLIST

### Phase 1: Database Setup (Week 1)
- [ ] Create `admin_roles` table
- [ ] Create `role_permissions` table
- [ ] Create `audit_logs` table
- [ ] Create `system_health_logs` table
- [ ] Create `admin_activity_logs` table
- [ ] Create database indexes
- [ ] Seed initial roles (super_admin, admin, moderator)

### Phase 2: Core Admin Services (Week 2)
- [ ] Create `AdminService` class
- [ ] Create `AuditService` class
- [ ] Create `RolePermissionService` class
- [ ] Implement permission checking middleware
- [ ] Implement audit logging for all admin actions

### Phase 3: Admin Management Endpoints (Week 2-3)
- [ ] Implement user management endpoints (list, get, update, ban)
- [ ] Implement hospital management endpoints
- [ ] Implement admin management endpoints
- [ ] Implement role/permission endpoints
- [ ] Add input validation & error handling

### Phase 4: System Management (Week 3)
- [ ] Implement dashboard endpoint
- [ ] Implement system health monitoring
- [ ] Implement maintenance mode
- [ ] Implement audit logging
- [ ] Setup system health check scheduler

### Phase 5: Testing & Security (Week 4)
- [ ] Role-based access control testing
- [ ] Permission inheritance testing
- [ ] Audit logging verification
- [ ] Load testing (1000 concurrent admins)
- [ ] Security audit
- [ ] Unit & integration tests

---

## 🔑 Key Requirements Summary

| Component | Count | Complexity |
|-----------|-------|-----------|
| **API Endpoints** | 25+ | Hard |
| **Database Tables** | 5 | Medium |
| **Services** | 3 | Hard |
| **Permission Types** | 40+ | Medium |
| **Audit Logging** | Complete | Medium |

---

## 🎯 Success Metrics

- Admin operations response time: < 500ms
- Audit log entry creation: < 100ms
- Permission check: < 50ms
- Role loading: < 200ms
- Dashboard load: < 1 second
- Zero unauthorized access incidents
- 99.5% audit trail accuracy

---

## 📝 Security Considerations

1. **Role-Based Access Control (RBAC)**
   - All admin operations protected by role
   - Permission inheritance & caching
   - Regular permission audits

2. **Audit Logging**
   - All admin actions logged with IP, timestamp
   - Immutable audit trail
   - 7-year retention policy

3. **Admin Authentication**
   - 2FA required for super admins
   - Session timeout after 30 minutes
   - Activity monitoring & alerts
   - Login attempt limiting

4. **Data Protection**
   - Encrypt sensitive fields
   - Mask PII in logs
   - Separate read/write permissions
   - Rate limiting on sensitive operations

---

## 📞 Support & Documentation

- API documentation: `/api/v1/admin/docs`
- Permission matrix: `/docs/ADMIN_PERMISSIONS.md`
- Audit log schema: `/docs/AUDIT_LOG_SCHEMA.md`
- Role templates: `/docs/ROLE_TEMPLATES.md`


