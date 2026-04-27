# Complete System Architecture & Data Flow
## Blood Donation App - Backend Requirements

---

## SYSTEM ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         FRONTEND APPLICATIONS                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐      │
│  │  DONOR APP       │  │  HOSPITAL APP    │  │  ADMIN WEB PANEL │      │
│  │  (Flutter)       │  │  (Flutter)       │  │  (Web)           │      │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘      │
│                                                                           │
└────────────────────┬──────────────────────────────┬──────────────────────┘
                     │                              │
                     │ REST API / JSON              │
                     ▼                              ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                        API GATEWAY / LOAD BALANCER                        │
│                          (HTTPS + SSL/TLS)                               │
└────────────────────┬──────────────────────────────┬──────────────────────┘
                     │ Route by Endpoint            │
                     ▼                              ▼
┌─────────────────────────────┬──────────────────────────────────────────┐
│                             │                                          │
│  ┌────────────────────────┐ │  ┌──────────────────────────────────┐   │
│  │  AUTH SERVICE          │ │  │  BACKEND MICROSERVICES          │   │
│  ├────────────────────────┤ │  ├──────────────────────────────────┤   │
│  │ • Login                 │ │  │ • Donor Service                  │   │
│  │ • Register              │ │  │ • Hospital Service               │   │
│  │ • Token Management      │ │  │ • Donation Service               │   │
│  │ • OTP/2FA               │ │  │ • Emergency Request Service      │   │
│  │ • Password Reset        │ │  │ • Points Service                 │   │
│  │ • Permission Check      │ │  │ • Rewards Service                │   │
│  └────────────────────────┘ │  │ • Badges Service                 │   │
│                             │  │ • Notification Service            │   │
│                             │  │ • Admin Service                    │   │
│                             │  │ • Report Service                   │   │
│                             │  │ • Health Check Service             │   │
│                             │  └──────────────────────────────────┘   │
│                             │                                          │
└─────────────────────────────┴──────────────────────────────────────────┘
                                     │
                    ┌────────────────┼────────────────┬──────────────┐
                    │                │                │              │
                    ▼                ▼                ▼              ▼
         ┌──────────────────┐ ┌──────────────┐ ┌──────────────┐ ┌───────┐
         │   PRIMARY DB     │ │ CACHE LAYER  │ │ FILE STORAGE │ │QUEUE  │
         │   (PostgreSQL)   │ │   (Redis)    │ │  (AWS S3)    │ │ (RMQ) │
         │                  │ │              │ │              │ │       │
         │ • Users          │ │ • User Data  │ │ • Documents  │ │ • Job │
         │ • Donations      │ │ • Rewards    │ │ • PDFs       │ │   Queue
         │ • Hospitals      │ │ • Hospital   │ │ • Images     │ │ • Notif
         │ • Emergencies    │ │   Lists      │ │              │ │   Queue
         │ • Transactions   │ │ • Points     │ │              │ │       │
         │ • Audit Logs     │ │   Balance    │ │              │ │       │
         └──────────────────┘ └──────────────┘ └──────────────┘ └───────┘
                    │
                    ▼
         ┌──────────────────┐
         │  BACKUP STORAGE  │
         │  (Daily Backups) │
         └──────────────────┘
```

---

## USER ROLE ARCHITECTURE

```
┌─────────────────────────────────────────────────────────────────┐
│                           AUTHENTICATION                        │
├─────────────────────────────────────────────────────────────────┤
│
│  Login → Send OTP → Verify OTP → JWT Token (Access + Refresh)
│
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      ROLE HIERARCHY                             │
├─────────────────────────────────────────────────────────────────┤
│
│  SUPER_ADMIN
│    ├─ Full system control
│    ├─ Manage all users
│    ├─ System configuration
│    └─ Audit log access
│
│  ADMIN
│    ├─ Donor management
│    ├─ Hospital management
│    ├─ Dashboard access
│    └─ Reports access
│
│  MODERATOR
│    ├─ Limited donor viewing
│    ├─ Alert management
│    └─ Report generation
│
│  HOSPITAL
│    ├─ Create emergency requests
│    ├─ Manage own blood inventory
│    ├─ View donor responses
│    └─ Hospital reports
│
│  DONOR
│    ├─ View emergency requests
│    ├─ Book appointments
│    ├─ Manage profile
│    ├─ Earn & redeem rewards
│    └─ View badges
│
└─────────────────────────────────────────────────────────────────┘
```

---

## DONOR FLOW - DATA MOVEMENT

```
┌──────────────────────────────────────────────────────────────────┐
│ DONOR REGISTRATION FLOW                                          │
├──────────────────────────────────────────────────────────────────┤

1. Register (Email/Phone + Password)
   → POST /auth/register
   → Create user in DB
   → Return access_token, refresh_token

2. Setup Profile
   → PUT /donor/profile
   → Save health info, blood type, address
   → Complete health questionnaire

3. Enable 2FA (Optional)
   → POST /auth/2fa/setup
   → Save QR code & backup codes

4. Ready for Home
   → GET /donor/dashboard
   → Load urgent requests
   → Display stats

└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ EMERGENCY REQUEST RESPONSE FLOW                                  │
├──────────────────────────────────────────────────────────────────┤

Hospital Creates Request
  ↓
POST /hospital/requests/create-emergency
  ↓
Request stored in DB
  ↓
Notification Service → Send to Nearby Donors
  ↓
Donors See in Home Screen
  GET /urgent-requests
  ↓
Donor Views Details
  GET /urgent-requests/{id}
  ↓
Donor Accepts
  POST /urgent-requests/{id}/accept
  ↓
Add to Donation Queue
  ↓
Hospital Sees Response
  GET /hospital/requests/{id}/responses
  ↓
Donor Completes Donation
  POST /donations/complete
  ↓
+200 Points Awarded
  CREATE points_transaction
  ↓
Badge Check (Donation Count)
  IF donation_count == 1 THEN unlock "First Timer"
  ↓
Home Screen Updated

└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ POINTS EARNING → REDEMPTION FLOW                                │
├──────────────────────────────────────────────────────────────────┤

Event Triggered (Donation, Response, etc.)
  ↓
Points Service
  └─ Check transaction uniqueness
  └─ Add points to balance
  └─ Log transaction
  └─ Update tier if needed
  ↓
Notification Service
  └─ Send "Points Earned" notification
  ↓
User Views Rewards
  GET /donor/points        → Shows balance (cached)
  GET /rewards             → Shows catalog
  ↓
User Clicks Redeem
  POST /rewards/{id}/redeem
  ↓
Validation
  ✓ Has sufficient points?
  ✓ Reward active?
  ✓ Limits not exceeded?
  ↓
Points Deducted
  UPDATE user_points_accounts SET points_balance -= cost
  INSERT points_transaction (REWARD_REDEEMED)
  ↓
Redemption Record Created
  INSERT reward_redemptions
  ↓
Partner Integration
  → Generate voucher code
  → Send to partner API
  ↓
Delivery
  → Send via Email/SMS/WhatsApp
  ↓
Notification
  → "Reward Redeemed Successfully"

└──────────────────────────────────────────────────────────────────┘
```

---

## HOSPITAL FLOW - DATA MOVEMENT

```
┌──────────────────────────────────────────────────────────────────┐
│ HOSPITAL EMERGENCY REQUEST CREATION FLOW                         │
├──────────────────────────────────────────────────────────────────┤

Hospital Staff Logs In
  POST /auth/login (role: HOSPITAL)
  ↓
Hospital Dashboard Loaded
  GET /hospital/dashboard
  ↓
Staff Sees Blood Inventory Status
  GET /hospital/blood-inventory
  ↓
Blood Type Critical
  ↓
Create Emergency Request
  POST /hospital/requests/create-emergency
  ├─ blood_type: "A+"
  ├─ units_needed: 5
  ├─ urgency: "CRITICAL"
  └─ patient_type: "Trauma Case"
  ↓
Validate Hospital Status
  ✓ Active?
  ✓ Not in maintenance?
  ✓ Has valid blood bank?
  ↓
Save to Database
  INSERT emergency_requests
  ├─ hospital_id
  ├─ blood_type
  ├─ units_needed
  ├─ created_at
  └─ status = ACTIVE
  ↓
Notification Service
  → Find nearby donors with A+ blood
  → Filter by availability
  → Send push notifications to ~50-100 donors
  ↓
Database Update
  UPDATE emergency_requests SET notifications_sent = true
  ↓
Hospital Views Responses
  GET /hospital/requests/{id}/responses
  ↓
As Donors Arrive
  POST /donations/complete
  ├─ units_donated: 1.0
  └─ units += to blood_inventory
  ↓
Update Request Status
  IF units_received >= units_needed
    THEN status = FULFILLED
  ↓
Close Request
  POST /hospital/requests/{id}/close
  ↓
Generate Report
  Hospital reports generated automatically
  GET /hospital/reports/monthly

└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ BLOOD INVENTORY MANAGEMENT FLOW                                  │
├──────────────────────────────────────────────────────────────────┤

Admin Sets Critical Thresholds
  PUT /hospital/blood-bank-settings
  ├─ O_positive: critical < 5 units
  ├─ A_negative: critical < 3 units
  └─ etc.
  ↓
Hospital Blood Bank Updates Stock
  (Via API or Manual Entry)
  ↓
System Checks Against Thresholds
  IF current_units < critical_threshold
    THEN status = CRITICAL
    THEN send_alert_to_admin()
  ↓
Alert Created
  INSERT alerts
  ├─ type: LOW_BLOOD_TYPE
  ├─ hospital_id
  ├─ blood_type
  └─ severity: CRITICAL
  ↓
Admin Dashboard Updated
  GET /admin/dashboard
  └─ Shows critical alert
  ↓
Admin May Create Donor Request
  (Automatic or manual trigger)

└──────────────────────────────────────────────────────────────────┘
```

---

## ADMIN FLOW - DATA MOVEMENT

```
┌──────────────────────────────────────────────────────────────────┐
│ ADMIN DASHBOARD & MONITORING                                     │
├──────────────────────────────────────────────────────────────────┤

Admin Logs In (with 2FA)
  POST /auth/login (role: ADMIN)
  → Send OTP
  → Verify OTP
  → Return JWT
  ↓
Dashboard Load
  GET /admin/dashboard
  ├─ Total donors: COUNT(users WHERE role='DONOR')
  ├─ Active hospitals: COUNT(hospitals WHERE status='ACTIVE')
  ├─ Total donations: COUNT(donations WHERE status='COMPLETED')
  ├─ Donations this month: COUNT by date_range
  ├─ Blood inventory summary: GROUP BY blood_type, status
  ├─ Top donors: ORDER BY donation_count LIMIT 5
  ├─ Weekly trends: GROUP BY date, SUM(donations)
  └─ Critical alerts: WHERE severity='CRITICAL'
  ↓
Real-time Updates (WebSocket or Polling)
  Subscribe to dashboard updates
  ↓
Alert Management
  GET /admin/alerts
  ├─ Unresolved alerts
  ├─ Alert history
  └─ Alert timeline
  ↓
Resolve Alert
  POST /admin/alerts/{id}/resolve
  ├─ Resolution notes
  └─ Close request
  ↓
Blood Inventory Management
  GET /admin/blood-inventory-summary
  ├─ Show all hospitals
  ├─ Color code by status
  └─ Allow filtering
  ↓
Take Action
  POST /hospital/{id}/trigger-emergency-request
    (Automatic request creation for critical blood type)

└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ USER MANAGEMENT FLOW                                             │
├──────────────────────────────────────────────────────────────────┤

Admin Views Users
  GET /admin/donors
  ├─ Pagination: page=1&limit=20
  ├─ Filter by status, blood type, date range
  └─ Sort by donations, name, date
  ↓
List Retrieved from DB
  SELECT users.* FROM users
  WHERE user_role='DONOR' AND status=?
  ORDER BY ? LIMIT ? OFFSET ?
  ↓
Display with Stats
  ├─ Name, email, phone
  ├─ Blood type
  ├─ Donation count
  ├─ Last donation date
  ├─ Status badge
  └─ Action buttons (view, edit, deactivate)
  ↓
Admin Clicks Edit
  GET /admin/donors/{id}
  ↓
Show Edit Dialog
  ├─ Update status (ACTIVE/INACTIVE/DEFERRED/SUSPENDED)
  ├─ Add notes
  └─ Save
  ↓
Update in DB
  UPDATE users SET status=?, notes=? WHERE id=?
  INSERT audit_log (DONOR_UPDATED, admin_id, user_id, changes)
  ↓
Notification (if status changed)
  → Notify donor of status change
  ↓
Sync to Cache
  DELETE redis_key(user:{id})
  (Force refresh on next API call)
  ↓
Audit Log Updated
  GET /admin/audit-logs
  ├─ View all admin actions
  ├─ Filter by admin, date, action type
  └─ Export capability

└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ SYSTEM ADMINISTRATION                                            │
├──────────────────────────────────────────────────────────────────┤

System Health Check
  POST /admin/system-health/check
  ├─ Database: Connection + Query test
  ├─ Cache: Redis connectivity
  ├─ Email: Send test email
  ├─ File Storage: Upload test
  └─ External APIs: Ping endpoints
  ↓
Health Status
  ✓ HEALTHY
  ⚠ DEGRADED (1+ component slow)
  ✗ CRITICAL (component down)
  ↓
View Health Details
  GET /admin/system-health
  ├─ Overall status
  ├─ Component status
  ├─ Uptime percentage
  └─ Last check time
  ↓
Maintenance Mode
  POST /admin/maintenance-mode
  ├─ enabled: true
  ├─ duration: 60 minutes
  └─ message: "System maintenance in progress"
  ↓
During Maintenance
  ✓ Admins can access
  ✗ Regular users: Maintenance message
  ✗ API: Return 503 Service Unavailable
  ↓
Maintenance Complete
  POST /admin/maintenance-mode (enabled: false)
  ↓
System Back Online
  ✓ Users can access again

└──────────────────────────────────────────────────────────────────┘
```

---

## EVENT-DRIVEN ARCHITECTURE

```
┌─────────────────────────────────────────────────────────────────┐
│                    EVENT BUS / MESSAGE QUEUE                    │
│                    (RabbitMQ or AWS SQS)                        │
└─────────────────────────────────────────────────────────────────┘

Events Published:
  │
  ├─ DONATION_COMPLETED
  │  ├─ Trigger: Donation record created
  │  ├─ Payload: {donor_id, donation_id, units, blood_type}
  │  ├─ Listeners:
  │  │  ├─ Points Service → Award 200 points
  │  │  ├─ Badges Service → Check if "First Timer"
  │  │  ├─ Notification Service → Send notification
  │  │  └─ Analytics Service → Log event
  │  └─ Result: Points + Badges + Notifications
  │
  ├─ EMERGENCY_REQUEST_CREATED
  │  ├─ Trigger: Hospital creates request
  │  ├─ Payload: {hospital_id, blood_type, units, urgency}
  │  ├─ Listeners:
  │  │  ├─ Notification Service → Broadcast to donors
  │  │  ├─ Location Service → Find nearby donors
  │  │  └─ Analytics Service → Log request
  │  └─ Result: Donors see notification
  │
  ├─ EMERGENCY_REQUEST_ACCEPTED
  │  ├─ Trigger: Donor accepts request
  │  ├─ Payload: {request_id, donor_id, eta}
  │  ├─ Listeners:
  │  │  ├─ Hospital Service → Update response list
  │  │  ├─ Notification Service → Notify hospital
  │  │  └─ Analytics Service → Log acceptance
  │  └─ Result: Hospital sees response
  │
  ├─ REWARD_REDEEMED
  │  ├─ Trigger: Donor redeems reward
  │  ├─ Payload: {redemption_id, reward_id, donor_id}
  │  ├─ Listeners:
  │  │  ├─ Partner Service → Generate voucher
  │  │  ├─ Notification Service → Send voucher
  │  │  └─ Analytics Service → Track redemption
  │  └─ Result: Voucher delivered
  │
  ├─ BLOOD_INVENTORY_CRITICAL
  │  ├─ Trigger: Blood falls below threshold
  │  ├─ Payload: {hospital_id, blood_type, current_units}
  │  ├─ Listeners:
  │  │  ├─ Alert Service → Create alert
  │  │  ├─ Notification Service → Notify admin
  │  │  └─ Analytics Service → Track low stock
  │  └─ Result: Admin sees alert
  │
  └─ PROFILE_COMPLETED
     ├─ Trigger: Donor completes profile
     ├─ Payload: {donor_id}
     ├─ Listeners:
     │  ├─ Points Service → Award 50 points
     │  ├─ Badges Service → Check "Ready to Donate"
     │  └─ Notification Service → Send reward notification
     └─ Result: Points + Badges + Notifications

```

---

## NOTIFICATION FLOW

```
┌─────────────────────────────────────────────────────────────────┐
│                   NOTIFICATION SERVICE                          │
├─────────────────────────────────────────────────────────────────┤

Trigger Event
  ↓
Build Message
  ├─ Recipient: user_id
  ├─ Type: enum
  ├─ Title: string
  ├─ Body: string
  ├─ Action URL: string
  └─ Priority: HIGH|NORMAL|LOW
  ↓
Store in Database
  INSERT notifications
  ├─ Save message details
  ├─ Set read=false
  └─ Mark created_at
  ↓
Deliver via Multiple Channels
  │
  ├─ IN-APP
  │  ├─ Store in DB
  │  ├─ Fetch via GET /notifications
  │  └─ Show in app UI
  │
  ├─ PUSH NOTIFICATION (Firebase Cloud Messaging)
  │  ├─ Get user device tokens
  │  ├─ Send via FCM
  │  ├─ Handle token refresh
  │  └─ Log delivery status
  │
  ├─ EMAIL
  │  ├─ Queue in email service
  │  ├─ Render HTML template
  │  ├─ Send via SMTP
  │  └─ Track open rates
  │
  └─ SMS (WhatsApp/Twilio)
     ├─ Check user preference
     ├─ Format message (160 chars)
     ├─ Send via provider
     └─ Log delivery status
  ↓
Delivery Confirmation
  ├─ Mark as delivered
  ├─ Track delivery time
  └─ Log any failures
  ↓
User Interaction
  ├─ Mark as Read: PUT /notifications/{id}/mark-read
  ├─ Delete: DELETE /notifications/{id}
  └─ Archive: PUT /notifications/{id}/archive
  ↓
Retention
  ├─ Keep in DB for 90 days
  ├─ Archive after 90 days
  └─ Clean up after 1 year

Example Notification:
  Type: EMERGENCY_REQUEST
  Title: "Urgent: A+ Blood Needed"
  Body: "City Hospital needs A+ blood urgently. 4.8 km away"
  Action URL: /urgent-requests/req_123
  Priority: HIGH
  → Deliver immediately via PUSH + EMAIL

```

---

## DATABASE SCHEMA RELATIONSHIPS

```
users (Base table)
├─ id (PK)
├─ email (UNIQUE)
├─ phone (UNIQUE)
├─ user_role (ENUM: DONOR, HOSPITAL, ADMIN)
├─ created_at
└─ is_active

donors (Extends users)
├─ id (FK → users.id, PK)
├─ blood_type
├─ date_of_birth
├─ health_status
├─ total_donated_units
├─ total_donation_count
└─ last_donation_date

hospitals (Extends users)
├─ id (FK → users.id, PK)
├─ hospital_name
├─ address
├─ location (lat/lng)
├─ blood_bank_manager
└─ operating_hours

donations
├─ id (PK)
├─ donor_id (FK → donors.id)
├─ hospital_id (FK → hospitals.id)
├─ blood_type
├─ units_donated
├─ donation_date
└─ status

emergency_requests
├─ id (PK)
├─ hospital_id (FK → hospitals.id)
├─ blood_type
├─ units_needed
├─ urgency
├─ created_at
└─ status

emergency_responses
├─ id (PK)
├─ request_id (FK → emergency_requests.id)
├─ donor_id (FK → donors.id)
├─ response_status
└─ arrival_time

user_points_accounts
├─ id (PK)
├─ user_id (FK → users.id, UNIQUE)
├─ points_balance
├─ lifetime_points_earned
└─ tier_level

points_transactions
├─ id (PK)
├─ user_id (FK → users.id)
├─ points_amount
├─ transaction_type
├─ reference_id
└─ created_at

reward_redemptions
├─ id (PK)
├─ user_id (FK → users.id)
├─ reward_id (FK → rewards_catalog.id)
├─ points_spent
├─ redemption_status
└─ redeemed_at

user_badges
├─ id (PK)
├─ user_id (FK → users.id)
├─ badge_id (FK → badge_definitions.id)
├─ unlock_status
└─ unlocked_at

notifications
├─ id (PK)
├─ user_id (FK → users.id)
├─ notification_type
├─ title
├─ body
├─ read
└─ created_at

audit_logs
├─ id (PK)
├─ admin_id (FK → users.id)
├─ action
├─ entity_type
├─ entity_id
├─ changes (JSON)
└─ created_at

```

---

## TESTING SCENARIOS - DATA FLOWS

### Scenario 1: Complete Donation Journey (Donor)

```
User Registration
  ↓ ✓ Account created, tokens issued
Profile Setup
  ↓ ✓ Health info saved, 50 pts awarded
Home Screen
  ↓ ✓ Dashboard loads, urgent requests show
View Emergency Request
  ↓ ✓ Full details loaded, distance calculated
Accept Request
  ↓ ✓ Response recorded, hospital notified
Arrive at Hospital
  ↓ ✓ Check-in process
Complete Donation
  ↓ ✓ 1.0 units recorded, 200 points awarded
Go to Rewards
  ↓ ✓ Points updated (250 total)
Redeem Reward
  ↓ ✓ Coffee voucher redeemed, 250-500=-250 points
Check Badges
  ↓ ✓ "First Timer" badge unlocked if first donation
```

### Scenario 2: Hospital Emergency Request Flow

```
Hospital Login
  ↓ ✓ Dashboard shows inventory
Create Emergency Request
  ↓ ✓ Request created, notifications queued
Broadcast Sent
  ↓ ✓ ~100 nearby donors notified
Donor Accepts (First)
  ↓ ✓ Response recorded, hospital sees response
Donor Accepts (Second)
  ↓ ✓ Second response recorded
First Donor Arrives
  ↓ ✓ 1.0 units recorded
Second Donor Arrives
  ↓ ✓ 1.0 units recorded, total = 2.0
Close Request
  ↓ ✓ Request marked FULFILLED
```

### Scenario 3: Admin Monitoring Flow

```
Admin Dashboard
  ↓ ✓ All metrics loaded from cache
Blood Inventory Alert
  ↓ ✓ Critical alert shown
Click Alert
  ↓ ✓ Hospital details displayed
View All Donors
  ↓ ✓ Paginated list, filterable
Edit Donor Status
  ↓ ✓ Status updated, audit log created
View Audit Logs
  ↓ ✓ All admin actions visible
System Health Check
  ↓ ✓ All components healthy
```

---

## PERFORMANCE OPTIMIZATION CHECKLIST

```
Database:
  ✓ Proper indexing on foreign keys
  ✓ Pagination for all list queries
  ✓ Connection pooling (min 10, max 50)
  ✓ Read replicas for reporting
  ✓ Query optimization (EXPLAIN ANALYZE)

Caching:
  ✓ User profile (1 hour TTL)
  ✓ Hospital list (1 hour TTL)
  ✓ Rewards catalog (24 hour TTL)
  ✓ Points balance (5 min TTL)
  ✓ Cache invalidation on write

API:
  ✓ Pagination (default 20, max 100)
  ✓ Field filtering (select only needed)
  ✓ Response compression (gzip)
  ✓ CDN for static assets
  ✓ API versioning

Frontend:
  ✓ Request debouncing
  ✓ Response caching (local)
  ✓ Lazy loading lists
  ✓ Image optimization
  ✓ Minimal re-renders
```

---

**Version:** 1.0  
**Last Updated:** April 26, 2026  
**Ready for:** Architecture Review & Development

